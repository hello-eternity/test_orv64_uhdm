#!/work/users/jwang/.local/conda/py36/bin/python3

import os
import re
import sys
import glob

print('** find source')
ls_src_fpath = list()
for fpath in glob.glob('./*', recursive=True):
    fname = os.path.basename(fpath)
    dpath = os.path.dirname(fpath)

    if (os.path.isdir(fpath)):
        print('skip dir: ' + fpath)
        continue

    if (not fname.endswith('.sv')):
        print('skip non-sv: ' + fpath)
        continue

    if (re.match(r'.+define.+', fname)):
        print('skil define: ' + fpath)
        continue

    assert fname.startswith('orv'), fpath
    ls_src_fpath.append(fpath)

print('** replace source')
for tgt in ['mp', 'cpint', 'cpfp']:
# for tgt in ['mp']:
    for fpath in ls_src_fpath:
        fname = os.path.basename(fpath)
        dpath = os.path.dirname(fpath)
        new_fname = fname.replace('orv', tgt)
        new_dpath = '../' + tgt
        assert os.path.isdir(new_dpath), new_dpath
        new_fpath = os.path.join(new_dpath, new_fname)

        print('%s -> %s' % (fpath, new_fpath))

        fin = open(fpath, 'r')
        fout = open(new_fpath, 'w')

        for line in fin:
            line = line.replace('orv', tgt)
            line = line.replace('ORV', tgt.upper())

            fout.write(line)

        fin.close();
        fout.close()
