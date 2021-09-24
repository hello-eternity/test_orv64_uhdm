import os
import re
from datetime import datetime
import database as db

def check_build_id(build_id, sesh):
    if sesh.query(db.Builds.build_id).filter(db.Builds.build_id==build_id).count() <= 0:
        # Add new build id
        b_entry = db.Builds(build_id)
        sesh.add(b_entry)
    return

def check_regr_runs(run_id, regr_id, build_id, block_name, run_type, sesh):
    if sesh.query(db.RegrRuns.run_id).filter(db.RegrRuns.run_id==run_id).count() <= 0:
        # Add new run id
        rr_entry = db.RegrRuns(run_id, regr_id, build_id, block_name, run_type)
        sesh.add(rr_entry)
        return True
    else:
        return False

def get_build_id(rtl_report):
    build_id = None

    # Get git hashes
    git_hashes = dict()
    if os.path.isfile(rtl_report):
        fh_files = open(rtl_report, 'r')
        for line in fh_files:
            match = re.search('^\# (\S+) ([a-f0-9]{40})\s*$', line)
            if match:
                git_hashes[match.group(1)] = match.group(2)
        fh_files.close()

        # Create build_id from all git hashes appended
        for repo in sorted(git_hashes.keys()):
            if build_id is None:
                build_id = ''
            build_id += '%s:%s,' % (repo, git_hashes[repo])

        if build_id is not None:
            build_id = re.sub(',$', '', build_id)

    return build_id
