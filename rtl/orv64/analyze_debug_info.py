#!/usr/bin/env python3.6

import os
import csv
import sys

with open(sys.argv[1]) as f_debug_info:
    ls_cycle = list()

    for row in csv.reader(f_debug_info, delimiter=';'):
        assert len(row) == 9, row

        mcycle = int(row[0], 16)

        ls_stage = list()
        for i in range(1, 6):
            ls = row[i].replace('(', ' ').replace(')', ' ').strip().split()
            assert len(ls) in [1, 2], str(ls) + ' ' + str(row)
            if (len(ls) == 1):
                inst_code = ''
                pc = 0
            elif (len(ls) == 2):
                inst_code = ls[0]
                if ('x' in ls[1]):
                    pc = 0
                else:
                    pc = int(ls[1], 16)
            ls_stage.append((inst_code, pc))

        if_wait = row[6].strip()
        assert if_wait.startswith('NPC_AVAIL_'), row

        ls_id_wait = row[7].replace('=', ' ').strip().split()

        ls_cycle.append((mcycle, ls_stage, if_wait, ls_id_wait))

# consolidate WB status
ls_wb = list()
for inst_code, pc in [cycle[1][-1] for cycle in ls_cycle]:
    if (len(ls_wb) > 0):
        if ((inst_code == ls_wb[-1][0]) and (pc == ls_wb[-1][1])):
            continue
    ls_wb.append((inst_code, pc))

# find JUMP/BR inst
ls_j_inst_code = list()
n_non_taken = 0

last_inst_code = ''
last_pc = 0
for inst_code, pc in ls_wb:
    if (last_inst_code.startswith('J') or last_inst_code.startswith('B')):
        ls_j_inst_code.append(last_inst_code)

        if (pc == (last_pc + 4)):
            n_non_taken += 1
    last_inst_code = inst_code
    last_pc = pc

n_jmp = len(ls_j_inst_code)

print('found the following Jump/Branch instructions:')
print(set(ls_j_inst_code))

print('non-taken / overall:')
print('%d / %d = %.2f%%' % (n_non_taken, n_jmp, (100.0*n_non_taken/n_jmp)))
