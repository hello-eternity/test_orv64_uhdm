import os
import re
from datetime import datetime
import database as db
import utils

def rtl_power_to_db(topdir, regr_id, regr):
    print('INFO: Gathering rtl power data from dir: %s' % topdir, flush=True)
    rtl_power_dirs = get_rtl_power_dirs(topdir)

    rtl_power_data = dict()
    for block_name in rtl_power_dirs:
        for run_id in rtl_power_dirs[block_name]:
            print('INFO: Processing rtl_power run %s' % run_id, flush=True)
            rtl_power_dir = rtl_power_dirs[block_name][run_id]
            rtl_report = os.path.join(rtl_power_dir, 'rpt/rtl_files.list')
            log_file   = os.path.join(rtl_power_dir, 'log/rtl_power.log')

            build_id = utils.get_build_id(rtl_report)
            if build_id is None:
                # Skip this run if build_id cannot be determined
                continue

            # Check build_id against repo and add if needed
            utils.check_build_id(build_id, regr.new_session())
            regr.commit()
            regr.close_session()

            # Add entry to regr_runs table
            is_new_run = utils.check_regr_runs(run_id, regr_id, build_id, block_name, 'rtl_power', regr.new_session())
            regr.commit()
            regr.close_session()

            if not is_new_run:
                # Skip this run if it already exists in the database
                continue

            # Create database entry
            run_entry = db.RtlPowerRuns(run_id)

            # Get power data and end date
            if os.path.isfile(log_file):
                fh_log = open(log_file, 'r')
                for line in fh_log:
                    match = re.search('^\s*RUN ENDED AT\s+(\S+)\s+(\S+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)\s+(\d+)', line)
                    if match:
                        time_string = '%s %s %s %s %s %s %s' % (match.group(1), match.group(2), match.group(3), match.group(4), 
                                                                match.group(5), match.group(6), match.group(7))
                        end_time = datetime.strptime(time_string, '%a %b %d %H %M %S %Y')
                        run_entry.set_ended_at(end_time)
                    
                    match = re.search('^\s*Total Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_total_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_total_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_total_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_total_total(normalize_units_to_nw(match.group(4)))
                    
                    match = re.search('^\s*Combinational Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_comb_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_comb_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_comb_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_comb_total(normalize_units_to_nw(match.group(4)))

                    match = re.search('^\s*Sequential Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_seq_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_seq_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_seq_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_seq_total(normalize_units_to_nw(match.group(4)))

                    match = re.search('^\s*Black Box Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_bb_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_bb_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_bb_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_bb_total(normalize_units_to_nw(match.group(4)))

                    match = re.search('^\s*Memory Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_mem_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_mem_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_mem_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_mem_total(normalize_units_to_nw(match.group(4)))

                    match = re.search('^\s*IO PAD Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_io_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_io_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_io_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_io_total(normalize_units_to_nw(match.group(4)))

                    match = re.search('^\s*Clock Power=\s+(\S+)\s+\(Leakage\)\s+(\S+)\s+\(Internal\)\s+(\S+)\s+\(Switching\)\s+(\S+)\s+\(Total\)', line)
                    if match:
                        run_entry.set_clock_leakage(normalize_units_to_nw(match.group(1)))
                        run_entry.set_clock_internal(normalize_units_to_nw(match.group(2)))
                        run_entry.set_clock_switching(normalize_units_to_nw(match.group(3)))
                        run_entry.set_clock_total(normalize_units_to_nw(match.group(4)))

                fh_log.close()

            # Commit data
            sesh = regr.new_session()
            sesh.add(run_entry)
            regr.commit()
            regr.close_session()

def normalize_units_to_nw(string):
    val   = None
    match = re.search('([\d\.]+)(\S+)', string)
    if match:
        val  = float(match.group(1))
        unit = match.group(2)
        if unit == 'W':
            val *= 1000000000
        elif unit == 'mW':
            val *= 1000000
        elif unit == 'uW':
            val *= 1000
        elif unit == 'pW':
            val /= 1000
    
    return val

def get_rtl_power_dirs(topdir):
    # Scrape all directories to find rtl_power dirs for each block
    rtl_power_dirs = dict()
    # %rtl_power_dirs =
    #   $block_name =
    #     $run_id = <rtl_power_dir_fullpath> # run_id = rtl_power dir name
    for subdir in os.listdir(topdir):
        if os.path.isdir(os.path.join(topdir, subdir)) and subdir.startswith('rtl_power.'):
            run_id        = subdir
            rtl_power_dir = os.path.join(topdir, subdir, 'regression/rtl_power')
            script_file   = os.path.join(rtl_power_dir, 'script/rtl_power.tcl')
            block_name    = ''
            
            # Figure out the block name from the tool script
            if (os.path.isfile(script_file)):
                fh_script = open(script_file, 'r')
                for line in fh_script:
                    match = re.search('set_option top\s+(\S+)', line)
                    if match:
                        block_name = match.group(1)
                fh_script.close()

            if block_name != '':
                if block_name not in rtl_power_dirs:
                    rtl_power_dirs[block_name] = dict()
                rtl_power_dirs[block_name][run_id] = rtl_power_dir

    return rtl_power_dirs
