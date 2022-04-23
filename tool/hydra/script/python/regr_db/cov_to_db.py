import sys
import os
import gzip
import re
import xml.etree.ElementTree as ET
import database as db
import utils

def cov_to_db(topdir, regr_id, regr):
    print('INFO: Gathering regression data from dir: %s' % topdir, flush=True)
    regr_dirs = get_regr_dirs(topdir)

    build_data = dict()
    run_data   = dict()
    for block_name in regr_dirs:
        print('INFO: Processing build for block %s' % block_name, flush=True)
        build_data[block_name] = cov_process_build_vdb(block_name, topdir, regr_dirs[block_name]['build'])
        #cov_check_build_id(build_data[block_name]['build_id'], regr.new_session())
        utils.check_build_id(build_data[block_name]['build_id'], regr.new_session())
        regr.commit()
        regr.close_session()

        # Process all modules for this block
        print('INFO: Processing modules for block %s' % block_name, flush=True)
        for module_id in build_data[block_name]['modules']:            
            # Get the hierarchical instance name for each instance in this module
            # For use during run processing later for mapping inst_hier to inst_id
            for inst_id in build_data[block_name]['modules'][module_id]['inst']:
                build_data[block_name]['insts_by_hier'][get_inst_hier(build_data[block_name]['insts'], inst_id)] = inst_id

    for block_name in regr_dirs:
        for run_dir in regr_dirs[block_name]['runs']:
            print('INFO: Processing run %s' % run_dir, flush=True)
            run_data[block_name] = cov_process_run_vdb(block_name, topdir, run_dir, regr.new_session())

            #is_new_run = cov_check_regr_runs_table(run_dir, regr_id, build_data[block_name]['build_id'], block_name, regr.new_session())
            is_new_run = utils.check_regr_runs(run_dir, regr_id, build_data[block_name]['build_id'], block_name, 'cov', regr.new_session())
            regr.commit()
            regr.close_session()

            if is_new_run:
                for inst_hier in run_data[block_name]:
                    cov_write_cov_runs_table(build_data, run_data, block_name, inst_hier, run_dir, regr.new_session())
                    regr.commit()
                    regr.close_session()


def get_inst_hier(insts, inst_id):
    inst_name = insts[inst_id]['name']
    inst_pid  = insts[inst_id]['pid']

    if inst_pid == '-1':
        return inst_name

    return get_inst_hier(insts, inst_pid) + '.' + inst_name


def get_regr_dirs(topdir):
    # Scrape all directories to find the run and build dirs for each block
    regr_dirs = dict()
    # %regr_dirs =
    #   $block_name =
    #     build = <str> # build directory
    #     runs = [] # list of run dirs
    #
    for subdir in os.listdir(topdir):
        if os.path.isdir(os.path.join(topdir, subdir)) and not subdir.endswith('_bld'):
            rerun_file = os.path.join(topdir, subdir, 'rerun.sh')
            block_name = ""
            build_dir  = ""

            # Figure out the runv -tag from rerun.sh
            if (os.path.isfile(rerun_file)):
                fh_rerun = open(rerun_file, "r")
                for line in fh_rerun:
                    # Find block name
                    match_obj = re.search(" -tag ([^ ]*)", line)
                    if match_obj:
                        block_name = match_obj.group(1)

                    # Find build directory
                    match_obj = re.search("(\/\S+)\/simv", line)
                    if match_obj and os.path.isdir(match_obj.group(1)):
                        build_dir = match_obj.group(1)
                fh_rerun.close()

            if block_name != "":
                regr_dirs[block_name] = dict()
                regr_dirs[block_name]['build'] = build_dir.split('/')[-1]
                regr_dirs[block_name]['runs']  = list()
                regr_dirs[block_name]['runs'].append(subdir)

    return regr_dirs


# def cov_check_regr_runs_table(run_id, regr_id, build_id, block_name, sesh):
#     # Populate the regr_runs table
#     if sesh.query(db.RegrRuns.run_id).filter(db.RegrRuns.run_id==run_id).count() <= 0:
#         rr_entry = db.RegrRuns(run_id, regr_id, build_id, block_name, "cov")
#         sesh.add(rr_entry)
#         return True
#     else:
#         return False


# def cov_check_build_id(build_id, sesh):
#     if sesh.query(db.Builds.build_id).filter(db.Builds.build_id==build_id).count() <= 0:
#         # Add new build id
#         b_entry = db.Builds(build_id)
#         sesh.add(b_entry)
#     return


def cov_process_build_vdb(block_name, topdir, build_dir):
    # Process build vdb
    build_vdb_dir = os.path.join(topdir, build_dir, 'cov_bld.vdb')

    # Get build_id derived from git hashes found from files in the flist
    flist    = os.path.join(topdir, build_dir, 'flat.f')
    build_id = os.popen('export HYDRA_HOME=/work/asic_backend/flow/HYDRA; ${HYDRA_HOME}/hydra.pl report_regr_build_id -rtl_flist %s' % (flist)).read()

    # Read verilog.design.xml for all modules
    design_file = os.path.join(build_vdb_dir, 'snps/coverage/db/design/verilog.design.xml')
    fh_design = gzip.open(design_file, 'r')
    root = ET.fromstring(fh_design.read())
    fh_design.close()

    modules       = dict()
    insts         = dict()
    insts_by_hier = dict()
    # %modules =
    #   $module_id =
    #     name|chksum|line_start|line_end|file_id = <val>
    #     lines = [] # array of source lines from line_start to line_end
    #     groups =
    #       $group_id = # linebb index, corresponds to each bit in cov value
    #         lines =
    #           $file_name =
    #             $line_id =
    #               ignore|num = <val>
    #     inst = [] # list of inst_ids
    #
    # %insts =
    #   $inst_id =
    #     name|pid|module_id = <val>
    #
    # %insts_by_hier =
    #   $hier = <inst_id>
    # 
    for design in root.iter('design'):
        for srcdef in design.iter('srcdef'):
            if srcdef.get('type') == 'module':
                module_id = srcdef.get('id')
                if module_id not in modules:
                    modules[module_id]           = dict()
                    modules[module_id]['inst']   = list()
                    modules[module_id]['groups'] = dict()

                modules[module_id]['name']   = srcdef.get('name')
                modules[module_id]['chksum'] = srcdef.get('chksum')

                for srclocmult in srcdef.iter('srclocmult'):
                    modules[module_id]['line_start'] = srclocmult.get('start')
                    modules[module_id]['line_end']   = srclocmult.get('end')
                    modules[module_id]['file_id']    = srclocmult.get('file_id')

                    for srcinst in srcdef.iter('srcinst'):
                        inst_id = srcinst.get('id')
                        if inst_id not in insts:
                            insts[inst_id] = dict()

                        modules[module_id]['inst'].append(inst_id)
                        insts[inst_id]['name']      = srcinst.get('name')
                        insts[inst_id]['pid']       = srcinst.get('pid')
                        insts[inst_id]['module_id'] = module_id


    # Read verilog.sourceinfo.xml
    sourceinfo_file = os.path.join(build_vdb_dir, 'snps/coverage/db/auxiliary/verilog.sourceinfo.xml')
    fh_sourceinfo = open(sourceinfo_file, 'r')
    root = ET.fromstring(fh_sourceinfo.read())
    fh_sourceinfo.close()

    sourcefiles = dict()
    # %sourcelines =
    #   $fileid = <filename>
    #
    for srcinfo in root.iter('srcinfo'):
        for fileinfo in srcinfo.iter('fileinfo'):
            file_id = fileinfo.get('id')
            sourcefiles[file_id] = fileinfo.get('name')

    # Read line.verilog.shape.xml
    line_shape_file = os.path.join(build_vdb_dir, 'snps/coverage/db/shape/line.verilog.shape.xml')
    fh_shape = gzip.open(line_shape_file, 'r')
    root = ET.fromstring(fh_shape.read())
    fh_shape.close()

    for line in root.iter('line'):
        for linedef in line.iter('linedef'):
            module_id = linedef.get('id')

            for lineshape in linedef.iter('lineshape'):
                for lineprocess in lineshape.iter('lineprocess'):
                    lineprocess_id = lineprocess.get('id')

                    for linebb in lineprocess.iter('linebb'):
                        group_id    = int(linebb.get('index'))
                        line_type   = linebb.get('type')

                        for linestmt in linebb.iter('linestmt'):
                            line_id     = linestmt.get('id')
                            line_ignore = linestmt.get('line_ignore')
                            file_id     = linestmt.get('file_id')
                            file_name   = sourcefiles[file_id]

                            if group_id not in modules[module_id]['groups']:
                                modules[module_id]['groups'][group_id]          = dict()
                                modules[module_id]['groups'][group_id]['lines'] = dict()

                            if file_name not in modules[module_id]['groups'][group_id]['lines']:
                                modules[module_id]['groups'][group_id]['lines'][file_name] = dict()

                            if line_id not in modules[module_id]['groups'][group_id]['lines'][file_name]:
                                 modules[module_id]['groups'][group_id]['lines'][file_name][line_id] = dict()

                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['ignore'] = line_ignore
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['type']   = line_type
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['num']    = linestmt.get('line_num')
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['group']  = lineprocess_id

    block_data = dict()
    block_data['modules']       = modules
    block_data['insts']         = insts
    block_data['insts_by_hier'] = insts_by_hier
    block_data['sourcefiles']   = sourcefiles
    block_data['build_id']      = build_id

    return block_data



def cov_process_run_vdb(block_name, topdir, run_dir, sesh):
    # Process run vdbs
    run_vdb_dir = os.path.join(topdir, run_dir, 'cov_run.vdb')

    # Read line.verilog.data.xml
    line_data_file = os.path.join(run_vdb_dir, 'snps/coverage/db/testdata/test/line.verilog.data.xml')
    fh_line = gzip.open(line_data_file, 'r')
    root = ET.fromstring(fh_line.read())
    fh_line.close()

    cov = dict()
    # %cov =
    #   $inst_hier = <value>
    #
    for covdata in root.iter('covdata'):
        for instance_data in covdata.iter('instance_data'):
            inst_hier = instance_data.get('name')
            cov_value = instance_data.get('value')
            cov[inst_hier] = cov_value

    return cov



def cov_write_cov_runs_table(build_data, run_data, block_name, inst_hier, run_id, sesh):
    # Populate the cov_runs table
    cov_value   = run_data[block_name][inst_hier]
    inst_id     = build_data[block_name]['insts_by_hier'][inst_hier]
    module_id   = build_data[block_name]['insts'][inst_id]['module_id']
    #build_id    = build_data[block_name]['modules'][module_id]['chksum']
    module_name = build_data[block_name]['modules'][module_id]['name']

    lines = dict()
    # %lines =
    #   $num =
    #     value|type|ignore = <int>
    #     id =
    #       $line_id = 0|1 # cov_value for this line_id
    #
    for index, value in enumerate(list(cov_value)):
        if index in build_data[block_name]['modules'][module_id]['groups']:
            if index not in lines:
                lines[index] = dict()

            for file_name in build_data[block_name]['modules'][module_id]['groups'][index]['lines']:
                for line_id in build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name]:
                    line_num    = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name][line_id]['num']
                    line_ignore = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name][line_id]['ignore']
                    line_type   = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name][line_id]['type']
                    line_group  = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name][line_id]['group']
                    if file_name not in lines[index]:
                        lines[index][file_name] = dict()

                    if line_num not in lines[index][file_name]:
                        lines[index][file_name][line_num] = dict()
                        lines[index][file_name][line_num]['id'] = dict()

                    lines[index][file_name][line_num]['type']        = line_type
                    lines[index][file_name][line_num]['ignore']      = line_ignore
                    lines[index][file_name][line_num]['group']       = line_group
                    lines[index][file_name][line_num]['id'][line_id] = value

    for index in lines:
        for file_name in lines[index]:
            for line_num in lines[index][file_name]:
                    line_type   = lines[index][file_name][line_num]['type']
                    line_ignore = lines[index][file_name][line_num]['ignore']
                    line_group  = lines[index][file_name][line_num]['group']
                    line_val    = ''
                    for line_id in sorted(lines[index][file_name][line_num]['id']):
                        line_val += lines[index][file_name][line_num]['id'][line_id]

                    #print('%s %s %s %s %s' % (block_name, build_id, module_name, file_name, line_num), flush=True)
                    #print('  ' + line_val)
                    cr_entry = db.CovRuns(run_id, inst_hier, index, file_name, line_num, module_name, line_val, line_ignore, line_type, line_group)
                    sesh.add(cr_entry)
