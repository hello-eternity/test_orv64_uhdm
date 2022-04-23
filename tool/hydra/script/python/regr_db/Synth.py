import database as db
import re
from sqlalchemy import desc

class Synth:
    def __init__(self, num_runs):
        self.regr = db.regression.Regression()
        self.regr.set_timeout(54000)

        self.runs = self.get_runs(num_runs, self.regr.new_session())
        self.regr.close_session()

    def get_runs(self, num_runs, sesh):
        return sesh.query(db.SynthRuns).order_by(desc(db.SynthRuns.ended_at)).limit(num_runs)

    def __str__(self):
        report = ''
        col_list = db.SynthRuns.get_column_list()
        max_len  = dict()

        # Find max len for each column
        for col in col_list:
            edited_col = col
            edited_col = re.sub('_', '', edited_col)
            max_len[col] = len(edited_col)
        for row in self.runs:
            for col in col_list:
                if len(str(getattr(row, col))) > max_len[col]:
                    max_len[col] = len(str(getattr(row, col)))

        # Determine length of divider line
        total_col_len = 0
        for col in col_list:
            total_col_len += max_len[col] + 3
        divider = '-' * (total_col_len + 1);

        # Print header
        report += '%s\n' % divider
        for col in col_list:
            col_title = col
            col_title = re.sub('^(.)', self.__capitalize, col_title)
            col_title = re.sub('_(.)', self.__capitalize, col_title)
            report += '| {0:{1}} '.format(col_title, max_len[col])
        report += '|\n'
        report += '%s\n' % divider
        
        # Print rows
        for row in self.runs:
            for col in col_list:
                report += '| {0:{1}} '.format(str(getattr(row, col)), max_len[col])
            report += '|\n'
        report += '%s\n' % divider
        return report

    def __capitalize(self, match):
        return match.group(1).upper()
