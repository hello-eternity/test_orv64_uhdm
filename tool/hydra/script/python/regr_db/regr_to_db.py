import sys
import os
import argparse
import database as db

import synth_to_db
import cov_to_db
import rtl_power_to_db

def write_regr_table(topdir, sesh):
    # Get the regression dir name and populate the regr table
    regr_id = topdir.split('/')[-1]
    if sesh.query(db.Regr.regr_id).filter(db.Regr.regr_id==regr_id).count() <= 0:
        r_entry = db.Regr(regr_id)
        sesh.add(r_entry)

    return regr_id

# Arguments
parser = argparse.ArgumentParser(prog='regr_to_db')
parser.add_argument('-dir',      action = 'store',      required = True,  help = 'Regression Run Directory')

# Parse all arguments
args = parser.parse_args(sys.argv[1:])

regr = db.regression.Regression()
regr.set_timeout(54000)

# Process top regression dir
regr_id = write_regr_table(args.dir, regr.new_session())
regr.commit()
regr.close_session()

# Process coverage
cov_to_db.cov_to_db(args.dir, regr_id, regr)

# Process synthesis
synth_to_db.synth_to_db(args.dir, regr_id, regr)

# Process rtl power
rtl_power_to_db.rtl_power_to_db(args.dir, regr_id, regr)
