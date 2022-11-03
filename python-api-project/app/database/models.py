from datetime import datetime

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, DateTime

Base = declarative_base()


class Example(Base):
    __tablename__ = "example"
    id = Column(Integer, primary_key=True, index=True)
    created_at = Column(DateTime, default=datetime.now())
    updated_at = Column(DateTime, onupdate=datetime.now)
    deleted_at = Column(DateTime)
