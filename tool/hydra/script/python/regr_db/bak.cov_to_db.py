import sys
import os
import gzip
import re
import xml.etree.ElementTree as ET
import database as db

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


# def write_regr_table(topdir, sesh):
#     # Get the regression dir name and populate the regr table
#     regr_id = topdir.split('/')[-1]
#     if sesh.query(db.Regr.regr_id).filter(db.Regr.regr_id==regr_id).count() <= 0:
#         r_entry = db.Regr(regr_id)
#         sesh.add(r_entry)

#     return regr_id

def process_build_vdb(block_name, topdir, build_dir):
    # Process all build vdbs
    build_vdb_dir = os.path.join(topdir, build_dir, 'cov_bld.vdb')

    # Read verilog.design.xml for all modules
    design_file = os.path.join(build_vdb_dir, 'snps/coverage/db/design/verilog.design.xml')
    fh_design = gzip.open(design_file, 'r')
    root = ET.fromstring(fh_design.read())
    #root = tree.getroot()
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
    #root = tree.getroot()
    fh_sourceinfo.close()

    sourcefiles = dict()
    # %sourcelines =
    #   $fileid = <filename>
    for srcinfo in root.iter('srcinfo'):
        for fileinfo in srcinfo.iter('fileinfo'):
            file_id = fileinfo.get('id')
            sourcefiles[file_id] = fileinfo.get('name')

    # Read rtl file for every module
    # for module_id in modules:
    #     module_file = sourcefiles[modules[module_id]['file_id']]
    #     if os.path.isfile(module_file):
    #         modules[module_id]['lines'] = list()
    #         fh_source = open(module_file, 'r')
    #         cursor = 1
    #         for line in fh_source:
    #             if cursor >= int(modules[module_id]['line_start']) and cursor <= int(modules[module_id]['line_end']):
    #                 modules[module_id]['lines'].append(line.rstrip())
    #             if cursor > int(modules[module_id]['line_end']):
    #                 break
    #             cursor += 1
    #         fh_source.close()
    #     else:
    #         print('Source file not found: %s' % module_file)

    # Read line.verilog.shape.xml
    line_shape_file = os.path.join(build_vdb_dir, 'snps/coverage/db/shape/line.verilog.shape.xml')
    fh_shape = gzip.open(line_shape_file, 'r')
    root = ET.fromstring(fh_shape.read())
    #root = tree.getroot()
    fh_shape.close()

    for line in root.iter('line'):
        for linedef in line.iter('linedef'):
            module_id = linedef.get('id')

            for lineshape in linedef.iter('lineshape'):
                for lineprocess in lineshape.iter('lineprocess'):
                    lineprocess_id = lineprocess.get('id')

                    for linebb in lineprocess.iter('linebb'):
                        #group_id    = linebb.get('id')
                        group_id    = int(linebb.get('index'))
                        #ignore_type = linebb.get('type')
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

                            # ignore_val = 0
                            # if line_ignore == '5':
                            #     ignore_val = ignore_type

                            #modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['ignore'] = ignore_val
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['ignore'] = line_ignore
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['type']   = line_type
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['num']    = linestmt.get('line_num')
                            modules[module_id]['groups'][group_id]['lines'][file_name][line_id]['group']  = lineprocess_id

    block_data = dict()
    block_data['modules']       = modules
    block_data['insts']         = insts
    block_data['insts_by_hier'] = insts_by_hier
    block_data['sourcefiles']   = sourcefiles

    return block_data


def process_run_vdb(block_name, topdir, run_dir, sesh):
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


def write_module_builds_table(modules, block_name, sesh):
    new_modules = list()
    for module_id in modules:
        module_name = modules[module_id]['name']
        build_id    = modules[module_id]['chksum']

        # Check db for existing module
        if sesh.query(db.ModuleBuilds.block_name, db.ModuleBuilds.build_id, db.ModuleBuilds.module_name).filter(db.ModuleBuilds.block_name==block_name, db.ModuleBuilds.build_id==build_id, db.ModuleBuilds.module_name==module_name).count() <= 0:
            # Populate the module_builds table; module checksum used as build_id
            mb_entry = db.ModuleBuilds(block_name, build_id, module_name)
            sesh.add(mb_entry)
            new_modules.append(module_id)

    return new_modules


def write_regr_builds_table(new_modules, modules, block_name, regr_id, sesh):
    for module_id in new_modules:
        module_name = modules[module_id]['name']
        build_id    = modules[module_id]['chksum']

        # Populate the regr_builds table
        rb_entry = db.RegrBuilds(regr_id, block_name, build_id, module_name)
        sesh.add(rb_entry)


def write_inst_hier_table(modules, block_name, sesh):
    pass
    # Populate the inst_hierarchy table; use srcinst id as inst_id; resolve hierarchy with srcinst pid to get inst_hier
    ### This table is not needed?
    ### Hierarchy can be recreated from the full hierarchical instance name
    # for inst_id in modules[module_id]['inst']:
    #     inst_name = insts[inst_id]['name']
    #     inst_hier = get_inst_hier(insts, inst_id)
    #     ih_entry  = db.InstHier(block_name, build_id, module_name, inst_id, inst_hier, inst_name)
    #     sesh.add(ih_entry)


def write_cov_lines_table(modules, block_name, sesh):
    pass
    # Populate the cov_lines table
    ### Should cov_lines be removed?
    ### Cov run results should be processed to be understandable with only rtl_lines table
    ### 1. Process run results with line shape
    ### 2. Record checksum for line shape and check against runs everytime
    # for group_id in modules[module_id]['groups']:
    #     for line_id in modules[module_id]['groups'][group_id]['lines']:
    #         line_ignore = modules[module_id]['groups'][group_id]['lines'][line_id]['ignore']
    #         line_num    = modules[module_id]['groups'][group_id]['lines'][line_id]['num']
    #         cl_entry = db.CovLines(block_name, build_id, module_name, group_id, line_id, line_num, line_ignore)
    #         sesh.add(cl_entry)


def write_rtl_lines_table(modules, module_id, block_name, file_name, regr):
    module_name = modules[module_id]['name']
    build_id    = modules[module_id]['chksum']

    # Populate the rtl_lines table
    count = 0
    line_start = modules[module_id]['line_start']
    line_end   = modules[module_id]['line_end']
    if 'lines' in modules[module_id]:
        sesh = regr.new_session()
        for index, line in enumerate(modules[module_id]['lines']):
            if count >= 5000:
                regr.commit()
                regr.close_session()
                sesh = regr.new_session()
                count = 0
            if line is not None:
                line = line.rstrip()
            add_rtl_lines_entry(block_name, build_id, module_name, file_name, index+int(line_start), line, sesh)
            count += 1
        regr.commit()
        regr.close_session()

def add_rtl_lines_entry(block_name, build_id, module_name, file_name, line_num, line, sesh):
    rl_entry = db.RtlLines(block_name, build_id, module_name, file_name, line_num, line)
    sesh.add(rl_entry)

def write_secondary_rtl_lines_table(modules, secondary_files, module_id, block_name, file_name, regr):
    module_name = modules[module_id]['name']
    build_id    = modules[module_id]['chksum']

    if os.path.isfile(file_name):
        fh_source = open(file_name, 'r')
        cursor = 1
        count  = 0
        sesh = regr.new_session()
        for line in fh_source:
            if str(cursor) in secondary_files[module_id][file_name]:
                if count >= 5000:
                    regr.commit()
                    regr.close_session()
                    sesh = regr.new_session()
                    count = 0
                add_rtl_lines_entry(block_name, build_id, module_name, file_name, cursor, line.rstrip(), sesh)
                count += 1
            cursor += 1
        fh_source.close()
        regr.commit()
        regr.close_session()
    else:
        print('Secondary source file not found; db will be populated with empty lines: %s' % module_file, flush=True)
        count = 0
        for line_num in secondary_files[module_id][file_name]:
            if count >= 5000:
                regr.commit()
                regr.close_session()
                sesh = regr.new_session()
                count = 0
            add_rtl_lines_entry(block_name, build_id, module_name, file_name, line_num, None, sesh)
            count += 1
        regr.commit()
        regr.close_session()

def write_regr_runs_table(regr_id, block_name, run_id, sesh):
    # Populate the regr_runs table
    if sesh.query(db.RegrRuns.regr_id, db.RegrRuns.block_name, db.RegrRuns.run_id).filter(db.RegrRuns.regr_id==regr_id, db.RegrRuns.block_name==block_name, db.RegrRuns.run_id==run_id).count() <= 0:
        rr_entry = db.RegrRuns(regr_id, block_name, run_id)
        sesh.add(rr_entry)
        return True
    else:
        return False

def write_cov_runs_table(build_data, run_data, block_name, inst_hier, run_id, sesh):
    # Populate the cov_runs table
    cov_value   = run_data[block_name][inst_hier]
    inst_id     = build_data[block_name]['insts_by_hier'][inst_hier]
    module_id   = build_data[block_name]['insts'][inst_id]['module_id']
    build_id    = build_data[block_name]['modules'][module_id]['chksum']
    module_name = build_data[block_name]['modules'][module_id]['name']

    # for index, value in enumerate(list(cov_value)):
    #     if index in build_data[block_name]['modules'][module_id]['groups']:
    #         for line_id in build_data[block_name]['modules'][module_id]['groups'][index]['lines']:
    #             line_num    = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][line_id]['num']
    #             line_ignore = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][line_id]['ignore']
    #             line_type   = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][line_id]['type']
    #             cr_entry = db.CovRuns(block_name, build_id, module_name, run_id, inst_hier, index, line_num, value, line_ignore, line_type)
    #             sesh.add(cr_entry)

    lines = dict()
    # %lines =
    #   $num =
    #     value|type|ignore = <int>
    #     id =
    #       $line_id = 0|1 # cov_value for this line_id
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
                    cr_entry = db.CovRuns(block_name, build_id, module_name, run_id, inst_hier, index, file_name, line_num, line_val, line_ignore, line_type, line_group)
                    sesh.add(cr_entry)
        

def cov_to_db(topdir, regr_id, regr):
    print('INFO: Gathering regression data from dir: %s' % topdir, flush=True)
    regr_dirs = get_regr_dirs(topdir)
    #regr_id   = write_regr_table(topdir, regr.new_session())
    #regr.commit()
    #regr.close_session()

    build_data = dict()
    run_data   = dict()
    for block_name in regr_dirs:
        print('INFO: Processing build for block %s' % block_name, flush=True)
        build_data[block_name] = process_build_vdb(block_name, topdir, regr_dirs[block_name]['build'])

        # Process all modules for this block
        print('INFO: Processing modules for block %s' % block_name, flush=True)
        for module_id in build_data[block_name]['modules']:
            module_name = build_data[block_name]['modules'][module_id]['name']
            build_id    = build_data[block_name]['modules'][module_id]['chksum']
            
            # Get the hierarchical instance name for each instance in this module
            # For use during run processing later for mapping inst_hier to inst_id
            for inst_id in build_data[block_name]['modules'][module_id]['inst']:
                build_data[block_name]['insts_by_hier'][get_inst_hier(build_data[block_name]['insts'], inst_id)] = inst_id

        new_modules = write_module_builds_table(build_data[block_name]['modules'], block_name, regr.new_session())
        regr.commit()
        regr.close_session()

        write_regr_builds_table(new_modules, build_data[block_name]['modules'], block_name, regr_id, regr.new_session())
        regr.commit()
        regr.close_session()

        # inst_hier table?

        secondary_files = dict()
        for module_id in new_modules:
            # Read rtl file for this module
            module_file = build_data[block_name]['sourcefiles'][build_data[block_name]['modules'][module_id]['file_id']]
            if os.path.isfile(module_file):
                build_data[block_name]['modules'][module_id]['lines'] = list()
                fh_source = open(module_file, 'r')
                cursor = 1
                for line in fh_source:
                    if cursor >= int(build_data[block_name]['modules'][module_id]['line_start']) and cursor <= int(build_data[block_name]['modules'][module_id]['line_end']):
                        build_data[block_name]['modules'][module_id]['lines'].append(line.rstrip())
                    if cursor > int(build_data[block_name]['modules'][module_id]['line_end']):
                        break
                    cursor += 1
                fh_source.close()
            else:
                print('Source file not found; db will be populated with null lines: %s' % module_file, flush=True)
                build_data[block_name]['modules'][module_id]['lines'] = [None for _ in range(int(build_data[block_name]['modules'][module_id]['line_start']), int(build_data[block_name]['modules'][module_id]['line_end'])+1)]
                #for line_num in range(int(build_data[block_name]['modules'][module_id]['line_start']), int(build_data[block_name]['modules'][module_id]['line_end'])+1):
                #    build_data[block_name]['modules'][module_id]['lines'].append(' ')

            write_rtl_lines_table(build_data[block_name]['modules'], module_id, block_name, module_file, regr)
            #regr.commit()
            #regr.close_session()

            # Check shape.xml for secondary files used by this module, and add to the rtl_lines table
            for index in build_data[block_name]['modules'][module_id]['groups']:
                for file_name in build_data[block_name]['modules'][module_id]['groups'][index]['lines']:
                    if file_name != module_file:
                        if module_id not in secondary_files:
                            secondary_files[module_id] = dict()

                        if file_name not in secondary_files[module_id]:
                            secondary_files[module_id][file_name] = dict()

                        for line_id in build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name]:
                            line_num = build_data[block_name]['modules'][module_id]['groups'][index]['lines'][file_name][line_id]['num']
                            secondary_files[module_id][file_name][line_num] = 1

        # Write secondary files to the rtl_lines table
        for module_id in secondary_files:
            for file_name in secondary_files[module_id]:
                write_secondary_rtl_lines_table(build_data[block_name]['modules'], secondary_files, module_id, block_name, file_name, regr)
                #regr.commit()
                #regr.close_session()
        

        # cov_lines table?
                

    for block_name in regr_dirs:
        for run_dir in regr_dirs[block_name]['runs']:
            print('INFO: Processing run %s' % run_dir, flush=True)
            run_data[block_name] = process_run_vdb(block_name, topdir, run_dir, regr.new_session())

            is_new_run = write_regr_runs_table(regr_id, block_name, run_dir, regr.new_session())
            regr.commit()
            regr.close_session()

            if is_new_run:
                for inst_hier in run_data[block_name]:
                    write_cov_runs_table(build_data, run_data, block_name, inst_hier, run_dir, regr.new_session())
                    regr.commit()
                    regr.close_session()

