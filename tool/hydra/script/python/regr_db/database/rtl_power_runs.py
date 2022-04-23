import database as db
from database.regression import Base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import Column, String, BigInteger, Integer, Float, ForeignKeyConstraint, DateTime

class RtlPowerRuns(Base):
    __tablename__= 'rtl_power_runs'

    run_id           = Column(String(100), nullable=False, primary_key=True)
    total_leakage    = Column(Float, nullable=True)
    total_internal   = Column(Float, nullable=True)
    total_switching  = Column(Float, nullable=True)
    total_total      = Column(Float, nullable=True)
    comb_leakage     = Column(Float, nullable=True)
    comb_internal    = Column(Float, nullable=True)
    comb_switching   = Column(Float, nullable=True)
    comb_total       = Column(Float, nullable=True)
    seq_leakage      = Column(Float, nullable=True)
    seq_internal     = Column(Float, nullable=True)
    seq_switching    = Column(Float, nullable=True)
    seq_total        = Column(Float, nullable=True)
    bb_leakage       = Column(Float, nullable=True)
    bb_internal      = Column(Float, nullable=True)
    bb_switching     = Column(Float, nullable=True)
    bb_total         = Column(Float, nullable=True)
    mem_leakage      = Column(Float, nullable=True)
    mem_internal     = Column(Float, nullable=True)
    mem_switching    = Column(Float, nullable=True)
    mem_total        = Column(Float, nullable=True)
    io_leakage       = Column(Float, nullable=True)
    io_internal      = Column(Float, nullable=True)
    io_switching     = Column(Float, nullable=True)
    io_total         = Column(Float, nullable=True)
    clock_leakage    = Column(Float, nullable=True)
    clock_internal   = Column(Float, nullable=True)
    clock_switching  = Column(Float, nullable=True)
    clock_total      = Column(Float, nullable=True)
    ended_at         = Column(DateTime, nullable=True)

    __table_args__ = (ForeignKeyConstraint([run_id], [db.RegrRuns.run_id]), )

    # Relationship for foreign keys
    regr_runs = relationship("RegrRuns", backref=backref("rtl_power_runs", uselist=False), viewonly=True)

    def __init__(self, run_id):
        self.run_id           = run_id
        self.total_leakage    = None
        self.total_internal   = None
        self.total_switching  = None
        self.total_total      = None
        self.comb_leakage     = None
        self.comb_internal    = None
        self.comb_switching   = None
        self.comb_total       = None
        self.seq_leakage      = None
        self.seq_internal     = None
        self.seq_switching    = None
        self.seq_total        = None
        self.bb_leakage       = None
        self.bb_internal      = None
        self.bb_switching     = None
        self.bb_total         = None
        self.mem_leakage      = None
        self.mem_internal     = None
        self.mem_switching    = None
        self.mem_total        = None
        self.io_leakage       = None
        self.io_internal      = None
        self.io_switching     = None
        self.io_total         = None
        self.clock_leakage    = None
        self.clock_internal   = None
        self.clock_switching  = None
        self.clock_total      = None
        self.ended_at         = None

    def set_total_leakage(self, val):
        self.total_leakage = float(val)

    def set_total_internal(self, val):
        self.total_internal = float(val)

    def set_total_switching(self, val):
        self.total_switching = float(val)
        
    def set_total_total(self, val):
        self.total_total = float(val)

    def set_comb_leakage(self, val):
        self.comb_leakage = float(val)

    def set_comb_internal(self, val):
        self.comb_internal = float(val)

    def set_comb_switching(self, val):
        self.comb_switching = float(val)

    def set_comb_total(self, val):
        self.comb_total = float(val)

    def set_seq_leakage(self, val):
        self.seq_leakage = float(val)

    def set_seq_internal(self, val):
        self.seq_internal = float(val)

    def set_seq_switching(self, val):
        self.seq_switching = float(val)

    def set_seq_total(self, val):
        self.seq_total = float(val)

    def set_bb_leakage(self, val):
        self.bb_leakage = float(val)

    def set_bb_internal(self, val):
        self.bb_internal = float(val)

    def set_bb_switching(self, val):
        self.bb_switching = float(val)

    def set_bb_total(self, val):
        self.bb_total = float(val)

    def set_mem_leakage(self, val):
        self.mem_leakage = float(val)

    def set_mem_internal(self, val):
        self.mem_internal = float(val)

    def set_mem_switching(self, val):
        self.mem_switching = float(val)

    def set_mem_total(self, val):
        self.mem_total = float(val)

    def set_io_leakage(self, val):
        self.io_leakage = float(val)

    def set_io_internal(self, val):
        self.io_internal = float(val)
    
    def set_io_switching(self, val):
        self.io_switching = float(val)

    def set_io_total(self, val):
        self.io_total = float(val)

    def set_clock_leakage(self, val):
        self.clock_leakage = float(val)

    def set_clock_internal(self, val):
        self.clock_internal = float(val)
    
    def set_clock_switching(self, val):
        self.clock_switching = float(val)

    def set_clock_total(self, val):
        self.clock_total = float(val)

    def set_ended_at(self, val):
        self.ended_at = val

