import os
import re
#import hashlib
from datetime import datetime
import database as db
import utils

def synth_to_db(topdir, regr_id, regr):
    print('INFO: Gathering synthesis data from dir: %s' % topdir, flush=True)
    synth_dirs = get_synth_dirs(topdir)
    
    synth_data = dict()
    # %synth_data =
    #   $block_name =
    #     $run_id =
    #       build_id|total_area|cell_area|port_count|net_count|cell_count|comb_cell_count|
    #       seq_cell_count|macro_count|buf_count|ref_count|freq|setup_wns|setup_tns|setup_count|
    #       hold_wns|hold_tns|hold_count = <num>
    #
    for block_name in synth_dirs:
        for run_id in synth_dirs[block_name]:
            print('INFO: Processing synth run %s' % run_id, flush=True)
            synth_dir    = synth_dirs[block_name][run_id]
            rtl_report   = os.path.join(synth_dir, 'rpt/rtl_files.list')
            area_report  = os.path.join(synth_dir, 'rpt/synth.area.hier.rpt')
            hold_report  = os.path.join(synth_dir, 'rpt/synth.min_delay.rpt')
            setup_report = os.path.join(synth_dir, 'rpt/synth.max_delay.rpt')
            sdc_file     = os.path.join(synth_dir, 'output/%s.synth.final.sdc' % block_name)
            log_file     = os.path.join(synth_dir, 'log/synth.log')

            # # Get git hashes of synth run
            # git_hashes = dict()
            # if os.path.isfile(rtl_report):
            #     fh_files = open(rtl_report, 'r')
            #     for line in fh_files:
            #         match = re.search('^\# (\S+) ([a-f0-9]{40})\s*$', line)
            #         if match:
            #             git_hashes[match.group(1)] = match.group(2)
            #     fh_files.close()
            # else:
            #     # Skip this synth run if git hash cant be determined
            #     continue

            # # Create build_id from all git hashes appended
            # build_id = ''
            # for repo in sorted(git_hashes.keys()):
            #     build_id += '%s:%s,' % (repo, git_hashes[repo])
            # build_id = re.sub(',$', '', build_id)
            build_id = utils.get_build_id(rtl_report)
            if build_id is None:
                # Skip this run if build_id cannot be determined
                continue

            # Check build_id against repo and add if needed
            #synth_check_build_id(build_id, regr.new_session())
            utils.check_build_id(build_id, regr.new_session())
            regr.commit()
            regr.close_session()

            # Add entry to regr_runs table
            #is_new_run = synth_check_regr_runs(run_id, regr_id, build_id, block_name, regr.new_session())
            is_new_run = utils.check_regr_runs(run_id, regr_id, build_id, block_name, 'synth', regr.new_session())
            regr.commit()
            regr.close_session()

            if not is_new_run:
                # Skip this synth run if it already exists in the database
                continue

            # Create database entry for this synth run
            run_entry = db.SynthRuns(run_id)

            # Get end date
            if os.path.isfile(log_file):
                fh_log = open(log_file, 'r')
                for line in fh_log:
                    match = re.search('^\s*RUN ENDED AT\s+(\S+)\s+(\S+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)\s+(\d+)', line)
                    if match:
                        time_string = '%s %s %s %s %s %s %s' % (match.group(1), match.group(2), match.group(3), match.group(4), 
                                                                match.group(5), match.group(6), match.group(7))
                        end_time = datetime.strptime(time_string, '%a %b %d %H %M %S %Y')
                        run_entry.set_ended_at(end_time)
                fh_log.close()

            # Get frequency
            if os.path.isfile(sdc_file):
                fh_sdc = open(sdc_file, 'r')
                for line in fh_sdc:
                    match = re.search('^\s*create_clock.*-period\s+([\d\.]+)', line)
                    if match:
                        freq = float(match.group(1))
                        freq = 1 / (freq * 0.001)
                        run_entry.set_freq(freq)
                fh_sdc.close()

            # Get area data
            if os.path.isfile(area_report):
                fh_area = open(area_report, 'r')
                for line in fh_area:
                    match = re.search('Number of ports:\s+(\d+)', line)
                    if match:
                        run_entry.set_port_count(match.group(1))

                    match = re.search('Number of nets:\s+(\d+)', line)
                    if match:
                        run_entry.set_net_count(match.group(1))

                    match = re.search('Number of cells:\s+(\d+)', line)
                    if match:
                        run_entry.set_cell_count(match.group(1))

                    match = re.search('Number of combinational cells:\s+(\d+)', line)
                    if match:
                        run_entry.set_comb_count(match.group(1))

                    match = re.search('Number of sequential cells:\s+(\d+)', line)
                    if match:
                        run_entry.set_seq_count(match.group(1))

                    match = re.search('Number of macros/black boxes:\s+(\d+)', line)
                    if match:
                        run_entry.set_macro_count(match.group(1))

                    match = re.search('Number of buf/inv:\s+(\d+)', line)
                    if match:
                        run_entry.set_buf_count(match.group(1))

                    match = re.search('Number of references:\s+(\d+)', line)
                    if match:
                        run_entry.set_ref_count(match.group(1))

                    match = re.search('Combinational area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_comb_area(match.group(1))

                    match = re.search('Buf/Inv area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_buf_area(match.group(1))

                    match = re.search('Noncombinational area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_noncomb_area(match.group(1))

                    match = re.search('Macro/Black Box area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_macro_area(match.group(1))

                    match = re.search('Net Interconnect area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_net_area(match.group(1))

                    match = re.search('Total cell area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_cell_area(match.group(1))

                    match = re.search('Total area:\s+([\d\.]+)', line)
                    if match:
                        run_entry.set_total_area(match.group(1))
                fh_area.close()

            # Get hold data
            if os.path.isfile(hold_report):
                fh_hold    = open(hold_report, 'r')
                hold_wns   = None
                hold_tns   = 0
                hold_count = 0
                for line in fh_hold:
                    match = re.search('slack\s+\(VIOLATED\)\s+([\d\.\-]+)', line)
                    if match:
                        slack = float(match.group(1))
                        if hold_wns is None or slack < hold_wns:
                            hold_wns = slack
                        hold_tns   += slack
                        hold_count += 1
                run_entry.set_hold_wns(hold_wns)
                run_entry.set_hold_tns(hold_tns)
                run_entry.set_hold_count(hold_count)
                fh_hold.close()

            # Get setup data
            if os.path.isfile(setup_report):
                fh_setup    = open(setup_report, 'r')
                setup_wns   = None
                setup_tns   = 0
                setup_count = 0
                for line in fh_setup:
                    match = re.search('slack\s+\(VIOLATED\)\s+([\d\.\-]+)', line)
                    if match:
                        slack = float(match.group(1))
                        if setup_wns is None or slack < setup_wns:
                            setup_wns = slack
                        setup_tns   += slack
                        setup_count += 1
                run_entry.set_setup_wns(setup_wns)
                run_entry.set_setup_tns(setup_tns)
                run_entry.set_setup_count(setup_count)
                fh_setup.close()

            # Commit data
            sesh = regr.new_session()
            sesh.add(run_entry)
            regr.commit()
            regr.close_session()


def get_synth_dirs(topdir):
    # Scrape all directories to find synth dirs for each block
    synth_dirs = dict()
    # %synth_dirs =
    #   $block_name =
    #     $run_id = <synth_dir_fullpath> # run_id = synth dir name
    for subdir in os.listdir(topdir):
        if os.path.isdir(os.path.join(topdir, subdir)) and subdir.startswith('synth.'):
            run_id      = subdir
            synth_dir   = os.path.join(topdir, subdir, 'regression/synth')
            script_file = os.path.join(synth_dir, 'script/synth.tcl')
            block_name  = ''
            
            # Figure out the block name from the tool script
            if (os.path.isfile(script_file)):
                fh_script = open(script_file, 'r')
                for line in fh_script:
                    match = re.search('current_design\s+(\S+)', line)
                    if match:
                        block_name = match.group(1)
                fh_script.close()

            if block_name != '':
                if block_name not in synth_dirs:
                    synth_dirs[block_name] = dict()
                synth_dirs[block_name][run_id] = synth_dir

    return synth_dirs


# def synth_check_build_id(build_id, sesh):
#     if sesh.query(db.Builds.build_id).filter(db.Builds.build_id==build_id).count() <= 0:
#         # Add new build id
#         b_entry = db.Builds(build_id)
#         sesh.add(b_entry)
#     return


# def synth_check_regr_runs(run_id, regr_id, build_id, block_name, sesh):
#     if sesh.query(db.RegrRuns.run_id).filter(db.RegrRuns.run_id==run_id).count() <= 0:
#         # Add new run id
#         rr_entry = db.RegrRuns(run_id, regr_id, build_id, block_name, 'synth')
#         sesh.add(rr_entry)
#         return True
#     else:
#         return False
