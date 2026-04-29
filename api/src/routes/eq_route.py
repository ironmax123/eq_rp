from fastapi import FastAPI
from .handler.eq_handler import eq_handler

def eq_root_router(app:FastAPI,timestamp:int):
    return eq_handler(timestamp)
