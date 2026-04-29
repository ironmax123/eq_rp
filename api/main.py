import sys,os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from api.src.routes.eq_route import eq_root_router
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return "earthquakes api"



@app.get("/v1/eq/{timestamp}")
def get_eq(timestamp:int):
    return eq_root_router(app,timestamp=timestamp)
