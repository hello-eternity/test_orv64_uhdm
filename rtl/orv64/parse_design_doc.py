#!/usr/bin/env python3.6

import sys
from xlrd import open_workbook

header = """
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
"""


def read_sheet_by_col(workbook, sheet_name, with_title=True): # {{{
    sheet = workbook.sheet_by_name(sheet_name)
    dt_col = dict()
    for idx_col in range(sheet.ncols):
        for idx_row in range(sheet.nrows):
            item = str(sheet.cell(idx_row, idx_col).value).strip()
            if (idx_row == 0):
                if (with_title):
                    title = str(item)
                    dt_col[title] = list()
                else:
                    title = idx_col
                    dt_col[title] = list()
                    dt_col[title].append(item)
            else:
                dt_col[title].append(item)
    #  print(dt_col)
    return dt_col
# }}}

def read_sheet_by_row(workbook, sheet_name): # {{{
    sheet = workbook.sheet_by_name(sheet_name)
    ls_row = list()
    for idx_row in range(sheet.nrows):
        ls_col = list()
        for idx_col in range(sheet.ncols):
            item = str(sheet.cell(idx_row, idx_col).value).strip()
            ls_col.append(item)
        ls_row.append(ls_col)
    return ls_row
# }}}

def write_enum(ls_name, ls_value, enum_name): # {{{
    print(ls_name)
    print(ls_value)
    max_len = max([len(x) for x in ls_name])

    s = '  enum {'
    for i, name in enumerate(ls_name):
        name = name + ' ' * (max_len - len(name))
        try:
            value = ls_value[i]
            s += ('\n    %s = %s,' % (name, value))
        except IndexError:
            s += ('\n    %s,' % name)

    s = s.rstrip(',')
    s += '\n  } %s;\n' % enum_name

    return s
# }}}

def write_opcode_enum(workbook, sv_fpath=None): # {{{
    dt_col = read_sheet_by_col(workbook, 'Instruction')
    assert 'OPCODE' in dt_col.keys(), dt_col.keys()
    assert r'[6:0]' in dt_col.keys(), dt_col.keys()

    ls_name = dt_col['OPCODE']
    ls_value = ['\'b' + x for x in dt_col['[6:0]']]

    dt_enum = dict()

    for (name, value) in zip(ls_name, ls_value):
        if (name in dt_enum.keys()):
            assert value == dt_enum[name], 'not matching %s vs %s' % (value, dt_enum[name])
        else:
            dt_enum[name] = value
    #  print(dt_enum)

    sv = write_enum(list(dt_enum.keys()), list(dt_enum.values()), 'opcode_t')
    if (sv_fpath is not None):
        with open(sv_fpath, 'w') as f:
            f.write(sv)

    return sv
# }}}

def write_imm_type_enum(workbook, sv_fpath=None): # {{{
    dt_col = read_sheet_by_col(workbook, 'Instruction')
    assert 'IMM' in dt_col.keys(), dt_col.keys()

    ls_name = list(set(dt_col['IMM']))

    sv = write_enum(ls_name, list(), 'imm_type_t')
    with open(sv_fpath, 'w') as f:
        f.write(sv)

    return sv
# }}}

def parse_interface(): # {{{
    class signal:
        def __init__(self):
            self.name = ''
            self.width = 0
            self.is_struct = False
            self.struct_name = ''
            self.modport_in = list()
            self.modport_out = list()
        def __str__(self):
            s = self.name + ' %d ' % self.width + self.struct_name + ' ' + str(self.modport_in) + ' ' + str(self.modport_out)
            return s

    class interface:
        def __init__(self):
            self.name = ''
            self.parameter = list()
            self.siglist = list()
        def __str__(self):
            s = self.name + '\n'
            s += 'param = ' + str(self.parameter) + '\n'
            s += str([str(x) for x in self.siglist])
            return s

    ls_intf = list()

    workbook = open_workbook(sys.argv[1])
    ls_row = read_sheet_by_row(workbook, 'Interface')
    while (len(ls_row) > 0):
        row = ls_row.pop(0)
        if row[0].startswith('if_'):
            intf = interface()
            intf.name = row[0]
            ls_intf.append(intf)

            # parameter
            assert len(ls_row) > 0
            while (ls_row[0][0].find('=') != -1):
                ls = ls_row.pop(0)[0].split('=')
                assert len(ls) == 2, ls
                intf.parameter.append((ls[0], ls[1]))

            # signal table
            assert len(ls_row) > 0
            row = ls_row.pop(0)
            assert row[0] == 'Signal'
            assert row[1] == 'Type'
            ls_modport = list()
            for modport in row[2:]:
                assert modport.startswith('MP:') or len(modport) == 0, modport
                if (len(modport) > 0):
                    ls_modport.append(modport[3:])

            while (len(ls_row) > 0 and len(ls_row[0][0]) > 0):
                row = ls_row.pop(0)
                sig = signal()
                sig.name = row[0]
                intf.siglist.append(sig)
                try:
                    w = int(row[1])
                    sig.width = w
                    sig.is_struct = False
                except:
                    sig.is_struct = True
                    sig.struct_name = row[1]

                for i, io in enumerate(row[2:]):
                    if (io == 'I'):
                        sig.modport_in.append(ls_modport[i])
                    elif (io == 'O'):
                        sig.modport_out.append(ls_modport[i])
    return ls_intf
# }}}

def get_ctrl_value(title, ls_inst_code, ls_value, dt_inst):
    ls = title.split('\n')
    if (len(ls) > 1):
        title = ls[0]
        prefix = ls[1].strip('(').strip(')') + '_'
    else:
        prefix = ''

    ls = title.split('=')
    assert len(ls) == 2, title
    ctrl_name = ls[0]
    default_value = ls[1]

    print (ctrl_name + '=' + default_value)

    for (inst_code, value) in zip(ls_inst_code, ls_value):
        n = dt_inst[inst_code]
        if (value == ''):
            value = default_value
        else:
            value = value.replace('.0', '')

        if value is not None:
            value = prefix + value

        n.dt_ctrl[ctrl_name] = value

if __name__ == '__main__':
    workbook = open_workbook(sys.argv[1])
    if (sys.argv[2] == 'orv_opcode_enum.sv'):
        #  print(wb.sheet_names())
        sv_fpath = sys.argv[2]
        write_opcode_enum(workbook, sv_fpath=sv_fpath)
    elif (sys.argv[2] == 'orv_imm_type_enum.sv'):
        #  print(wb.sheet_names())
        sv_fpath = sys.argv[2]
        write_imm_type_enum(workbook, sv_fpath=sv_fpath)
    elif (sys.argv[2] == 'test_parse_interface'):
        for intf in parse_interface():
            print(intf)
    elif (sys.argv[2] == 'orv64_decode_func_pkg.sv'):
        fout = open(sys.argv[2], 'w')
        dt_col = read_sheet_by_col(workbook, 'Instruction')

        is_if = False
        is_id = False
        is_ex = False

        ls_if = list()
        ls_id = list()
        ls_ex = list()
        for i, title in enumerate(dt_col.keys()):
            if (is_if and title != 'IF'):
                ls_if.append(title)
            if (is_id and title != 'ID'):
                ls_id.append(title)
            if (is_ex and title != 'EX'):
                ls_ex.append(title)

            if (title == 'breakdown'):
                is_if = True
            elif (title == 'IF'):
                is_if = False
                is_id = True
            elif (title == 'ID'):
                is_id = False
                is_ex = True
            elif (title == 'EX') :
                is_ex = False

        class inst:
            def __init__(self, inst_code):
                self.inst_code = inst_code.replace('.', '_');
                self.dt_ctrl = dict()
            def __str__(self):
                s = self.inst_code + '\n'
                for (ctrl_name, ctrl_value) in self.dt_ctrl.items():
                    s += '%s=%s\n' % (ctrl_name, ctrl_value)
                return s
            def to_func(self, stage):
                s  = '  function automatic void func_orv64_decode_%s_%s (output orv64_%s_ctrl_t %s_ctrl);\n' % (stage, self.inst_code.lower(), stage, stage)
                s += '    %s_ctrl = \'{default:0};\n' % stage
                for (ctrl_name, ctrl_value) in self.dt_ctrl.items():
                    if (ctrl_value is None ):
                        continue
                    s += '    %s_ctrl.%s = %s;\n' % (stage, ctrl_name, ctrl_value)
                s += '    `ifndef SYNTHESIS\n'
                s += '    %s_ctrl.inst_code = "%s";\n' % (stage, self.inst_code)
                s += '    `endif\n'
                s += '  endfunction\n'
                return s

        print(header, file=fout)
        print('package orv64_decode_func_pkg;\n', file=fout)
        print('  import orv64_typedef_pkg::*; \n', file=fout)

        print(ls_id)
        dt_inst = dict()
        for inst_code in dt_col['INST_CODE']:
            n = inst(inst_code)
            dt_inst[inst_code] = n
        n = inst('default')
        dt_inst['default'] = n
        for title in ls_id:
            get_ctrl_value(title, dt_col['INST_CODE'] + ['default'], dt_col[title] + [''], dt_inst)
        for n in dt_inst.values():
            print(n.to_func('id2ex'))
            print(n.to_func('id2ex'), file=fout)

        print(ls_ex)
        dt_inst = dict()
        for inst_code in dt_col['INST_CODE']:
            n = inst(inst_code)
            dt_inst[inst_code] = n
        n = inst('default')
        dt_inst['default'] = n
        for title in ls_ex:
            get_ctrl_value(title, dt_col['INST_CODE'] + ['default'], dt_col[title] + [''], dt_inst)
        for n in dt_inst.values():
            print(n.to_func('ex2ma'))
            print(n.to_func('ex2ma'), file=fout)

        print('endpackage\n', file=fout)
        print('import orv64_decode_func_pkg::*;', file=fout)
        fout.close()

