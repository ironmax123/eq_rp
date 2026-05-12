import sys, os

# 実行環境に合わせてインポートパスを調整
current_dir = os.path.dirname(os.path.abspath(__file__))
if current_dir not in sys.path:
    sys.path.append(current_dir)
parent_dir = os.path.dirname(current_dir)
if parent_dir not in sys.path:
    sys.path.append(parent_dir)

import asyncio
try:
    import LCD1602
    HAS_LCD = True
except ImportError:
    HAS_LCD = False
from src.routes.eq_route import eq_root_router
from src.routes.history_route import history_router
from fastapi import FastAPI
from contextlib import asynccontextmanager
from src.services.history_service import initialize_history
from src.repository.kmoni_cache_repository import get_cache_state

async def lcd_update_loop():
    if not HAS_LCD:
        print("LCD1602 module not found or failed to import. LCD update skipped.")
        return
    
    print("Initializing LCD1602...")
    try:
        # LCD初期化（失敗時に例外を投げる可能性があるためtry-exceptで囲む）
        LCD1602.init(0x27, 1)
        print("LCD1602 initialized successfully.")
    except Exception as e:
        print(f"LCD1602 initialization failed: {e}")
        return

    last_mode = None
    while True:
        try:
            state = get_cache_state()
            if state.is_eq_mode:
                if last_mode != "eq":
                    LCD1602.clear()
                    last_mode = "eq"
                
                # 地震検知時：日本語を避け、ASCII文字のみを表示
                # LCD1602は標準で日本語（UTF-8）をサポートしていないため
                LCD1602.write(0, 0, "EQ DETECTED!")
                
                intensity = "-"
                if state.kmoni_cache_data and state.kmoni_cache_data.get("earthquakes"):
                    eq = state.kmoni_cache_data["earthquakes"][0]
                    intensity = eq.get("maxIntensity", "-")
                
                LCD1602.write(0, 1, f"Max Int: {intensity}")
            else:
                if last_mode != "standby":
                    LCD1602.clear()
                    LCD1602.write(0, 0, "Status:")
                    LCD1602.write(0, 1, "Standby")
                    last_mode = "standby"
        except Exception as e:
            print(f"LCD update error: {e}")
        
        await asyncio.sleep(1)


@asynccontextmanager
async def lifespan(app: FastAPI):
    initialize_history()
    # LCD更新タスクをバックグラウンドで開始
    asyncio.create_task(lcd_update_loop())
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