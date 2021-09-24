from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Regression:

  def __init__(self):
    self.engine = create_engine('mysql+mysqlconnector://root:ours@192.168.0.131/regression', pool_pre_ping=True, pool_recycle=1)
    self.sessionmaker = sessionmaker(bind=self.engine)
    Base.metadata.create_all(self.engine)

  def close_session(self):
    self.session.close()

  def execute(self, command):
    return self.engine.execute(command)

  def set_timeout(self, timeout):
    self.engine.execute('SET wait_timeout=' + str(timeout))
    self.engine.execute('SET interactive_timeout=' + str(timeout))

  def new_session(self):
    #self.session = sessionmaker(bind=self.engine)()
    self.session = self.sessionmaker()
    return self.session

  def commit(self):
    self.session.commit()

