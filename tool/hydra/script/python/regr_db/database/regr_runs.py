import database as db
from database.regression import Base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import Column, String, BigInteger, Integer, ForeignKeyConstraint

class RegrRuns(Base):
    __tablename__ = "regr_runs"

    run_id     = Column(String(100), nullable=False, primary_key=True)
    regr_id    = Column(String(100), nullable=False)
    build_id   = Column(String(500), nullable=False)
    block_name = Column(String(100), nullable=False)
    run_type   = Column(String(20), nullable=False)

    __table_args__ = (ForeignKeyConstraint([regr_id], [db.Regr.regr_id]), )

    # Relationship for foreign keys
    regr   = relationship("Regr", backref=backref("regr_runs", uselist=False))

    def __init__(self, run_id, regr_id, build_id, block_name, run_type):
        self.run_id     = run_id
        self.regr_id    = regr_id
        self.build_id   = build_id
        self.block_name = block_name
        self.run_type   = run_type
