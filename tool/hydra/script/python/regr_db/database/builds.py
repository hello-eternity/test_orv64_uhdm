import database as db
from database.regression import Base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import Column, String, BigInteger, Integer, ForeignKeyConstraint

class Builds(Base):
    __tablename__ = 'builds'

    build_id = Column(String(500), nullable=False, primary_key=True)

    def __init__(self, build_id):
        self.build_id = build_id
