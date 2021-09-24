import database as db
from database.regression import Base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import Column, String, BigInteger, Integer, ForeignKeyConstraint

class CovRuns(Base):
    __tablename__ = "cov_runs"

    run_id      = Column(String(100), nullable=False, primary_key=True)    
    inst_hier   = Column(String(500), nullable=False, primary_key=True)
    line_index  = Column(Integer, nullable=False, primary_key=True)
    file_name   = Column(String(500), nullable=False, primary_key=True)
    line_num    = Column(Integer, nullable=False, primary_key=True)
    module_name = Column(String(100), nullable=False)
    cov_value   = Column(String(100), nullable=False)
    line_ignore = Column(Integer, nullable=False)
    line_type   = Column(Integer, nullable=False)
    line_group  = Column(Integer, nullable=False)

    __table_args__ = (ForeignKeyConstraint([run_id], [db.RegrRuns.run_id]), )

    # Relationship for foreign keys
    regr_runs = relationship("RegrRuns", backref=backref("cov_runs", uselist=False), viewonly=True)

    def __init__(self, run_id, inst_hier, line_index, file_name, line_num, module_name, cov_value, line_ignore, line_type, line_group):
        self.run_id      = run_id
        self.inst_hier   = inst_hier
        self.line_index  = line_index
        self.file_name   = file_name
        self.line_num    = int(line_num)
        self.module_name = module_name
        self.cov_value   = cov_value
        self.line_ignore = int(line_ignore)
        self.line_type   = int(line_type)
        self.line_group  = int(line_group)
