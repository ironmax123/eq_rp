import sys,os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from api.src.routes.eq_route import eq_root_router
from api.src.routes.history_route import history_router
from fastapi import FastAPI
from contextlib import asynccontextmanager
from api.src.services.history_service import initialize_history

@asynccontextmanager
async def lifespan(app: FastAPI):
    initialize_history()
    yield

app = FastAPI(lifespan=lifespan)

app.include_router(history_router, prefix="/v1")

@app.get("/")
def read_root():
    return "earthquakes api"

@app.get("/v1/eq/{timestamp}")
def get_eq(timestamp:int):
    return eq_root_router(app,timestamp=timestamp)

## --- 以下Rasberry Pi ---