from database.regression import Base
from sqlalchemy.orm import relationship
from sqlalchemy import Column, String, BigInteger, Integer, ForeignKey

class Regr(Base):
    __tablename__ = "regr"

    regr_id = Column(String(100), nullable=False, primary_key=True)

    def __init__(self, regr_id):
        self.regr_id = regr_id
