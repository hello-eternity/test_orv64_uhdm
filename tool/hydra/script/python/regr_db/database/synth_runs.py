import database as db
from database.regression import Base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import Column, String, BigInteger, Integer, Float, ForeignKeyConstraint, DateTime

class SynthRuns(Base):
    __tablename__ = 'synth_runs'

    run_id       = Column(String(100), nullable=False, primary_key=True)
    total_area   = Column(Float, nullable=True)
    cell_area    = Column(Float, nullable=True)
    comb_area    = Column(Float, nullable=True)
    buf_area     = Column(Float, nullable=True)
    noncomb_area = Column(Float, nullable=True)
    macro_area   = Column(Float, nullable=True)
    net_area     = Column(Float, nullable=True)
    port_count   = Column(Integer, nullable=True)
    net_count    = Column(Integer, nullable=True)
    cell_count   = Column(Integer, nullable=True)
    comb_count   = Column(Integer, nullable=True)
    seq_count    = Column(Integer, nullable=True)
    macro_count  = Column(Integer, nullable=True)
    buf_count    = Column(Integer, nullable=True)
    ref_count    = Column(Integer, nullable=True)
    freq         = Column(Float, nullable=True)
    setup_wns    = Column(Float, nullable=True)
    setup_tns    = Column(Float, nullable=True)
    setup_count  = Column(Integer, nullable=True)
    hold_wns     = Column(Float, nullable=True)
    hold_tns     = Column(Float, nullable=True)
    hold_count   = Column(Integer, nullable=True)
    ended_at     = Column(DateTime, nullable=True)

    __table_args__ = (ForeignKeyConstraint([run_id], [db.RegrRuns.run_id]), )

    # Relationship for foreign keys
    regr_runs = relationship("RegrRuns", backref=backref("synth_runs", uselist=False), viewonly=True)

    def __init__(self, run_id):
        self.run_id       = run_id
        self.total_area   = None
        self.cell_area    = None
        self.comb_area    = None
        self.buf_area     = None
        self.noncomb_area = None
        self.macro_area   = None
        self.net_area     = None
        self.port_count   = None
        self.net_count    = None
        self.cell_count   = None
        self.comb_count   = None
        self.seq_count    = None
        self.macro_count  = None
        self.buf_count    = None
        self.ref_count    = None
        self.freq         = None
        self.setup_wns    = None
        self.setup_tns    = None
        self.setup_count  = None
        self.hold_wns     = None
        self.hold_tns     = None
        self.hold_count   = None
        self.ended_at     = None
        
    def get_column_list():
        return ['run_id', 'total_area', 'cell_area', 'comb_area',
                'buf_area', 'noncomb_area', 'macro_area', 'net_area',
                'port_count', 'net_count', 'cell_count', 'comb_count',
                'seq_count', 'macro_count', 'buf_count', 'ref_count',
                'freq', 'setup_wns', 'setup_tns', 'setup_count', 
                'hold_wns', 'hold_tns', 'hold_count', 'ended_at']

    def set_total_area(self, total_area):
        if total_area is not None:
            self.total_area = float(total_area)

    def set_cell_area(self, cell_area):
        if cell_area is not None:
            self.cell_area = float(cell_area)

    def set_comb_area(self, comb_area):
        if comb_area is not None:
            self.comb_area = float(comb_area)

    def set_buf_area(self, buf_area):
        if buf_area is not None:
            self.buf_area = float(buf_area)

    def set_noncomb_area(self, noncomb_area):
        if noncomb_area is not None:
            self.noncomb_area = float(noncomb_area)

    def set_macro_area(self, macro_area):
        if macro_area is not None:
            self.macro_area = float(macro_area)

    def set_net_area(self, net_area):
        if net_area is not None:
            self.net_area = float(net_area)

    def set_port_count(self, port_count):
        if port_count is not None:
            self.port_count = int(port_count)

    def set_net_count(self, net_count):
        if net_count is not None:
            self.net_count = int(net_count)

    def set_cell_count(self, cell_count):
        if cell_count is not None:
            self.cell_count = int(cell_count)

    def set_comb_count(self, comb_count):
        if comb_count is not None:
            self.comb_count = int(comb_count)

    def set_seq_count(self, seq_count):
        if seq_count is not None:
            self.seq_count = int(seq_count)

    def set_macro_count(self, macro_count):
        if macro_count is not None:
            self.macro_count = int(macro_count)

    def set_buf_count(self, buf_count):
        if buf_count is not None:
            self.buf_count = int(buf_count)

    def set_ref_count(self, ref_count):
        if ref_count is not None:
            self.ref_count = int(ref_count)

    def set_freq(self, freq):
        if freq is not None:
            self.freq = float(freq)

    def set_setup_wns(self, setup_wns):
        if setup_wns is not None:
            self.setup_wns = float(setup_wns)

    def set_setup_tns(self, setup_tns):
        if setup_tns is not None:
            self.setup_tns = float(setup_tns)

    def set_setup_count(self, setup_count):
        if setup_count is not None:
            self.setup_count = int(setup_count)

    def set_hold_wns(self, hold_wns):
        if hold_wns is not None:
            self.hold_wns = float(hold_wns)

    def set_hold_tns(self, hold_tns):
        if hold_tns is not None:
            self.hold_tns = float(hold_tns)

    def set_hold_count(self, hold_count):
        if hold_count is not None:
            self.hold_count = int(hold_count)

    def set_ended_at(self, ended_at):
        if ended_at is not None:
            self.ended_at = ended_at
