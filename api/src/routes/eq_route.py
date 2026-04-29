from fastapi import FastAPI

def eq_root_router(app:FastAPI,timestamp:int):
    return {"timestamp":timestamp,"data":[]}
