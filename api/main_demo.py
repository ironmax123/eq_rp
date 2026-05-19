import asyncio
import copy
from contextlib import asynccontextmanager

from fastapi import FastAPI

from main import lcd_update_loop
from src.repository.kmoni_cache_repository import get_cache_state
from src.routes.eq_route import eq_root_router
from src.routes.history_route import history_router
from src.services.history_service import initialize_history
import src.services.eq_service as eq_service_module


DEMO_SWITCH_DELAY_SECONDS = 10
DEMO_EEW_DATA = {
    "result": {
        "status": "success",
        "message": "",
    },
    "report_id": "demo_tokyo_bay_5",
    "region_name": "東京湾",
    "latitude": "35.55",
    "longitude": "139.85",
    "depth": "30km",
    "magunitude": "5.8",
    "origin_time": "2026/05/19 12:00:00",
    "calcintensity": "5-",
}


class DemoEewResponse:
    def json(self):
        return copy.deepcopy(DEMO_EEW_DATA)


def demo_eq_repository(timestamp: int):
    print(f"Demo EEW repository returned Tokyo Bay intensity 5 data: {timestamp}")
    return DemoEewResponse()


async def switch_to_demo_repository():
    await asyncio.sleep(DEMO_SWITCH_DELAY_SECONDS)
    eq_service_module.eq_repository = demo_eq_repository
    state = get_cache_state()
    state.is_eq_mode = False
    state.eq_mode_end_time = None
    state.last_kmoni_fetch_time = None
    state.kmoni_cache_data = None
    state.eq_detected_time = None
    state.added_to_history = False
    print("Demo EEW repository enabled.")


@asynccontextmanager
async def lifespan(app: FastAPI):
    print("FastAPI demo lifespan started.")
    initialize_history()
    asyncio.create_task(lcd_update_loop())
    asyncio.create_task(switch_to_demo_repository())
    yield


app = FastAPI(lifespan=lifespan)

app.include_router(history_router, prefix="/v1")


@app.get("/")
def read_root():
    return "earthquakes api demo"


@app.get("/v1/eq/{timestamp}")
def get_eq(timestamp: int):
    return eq_root_router(app, timestamp=timestamp)
