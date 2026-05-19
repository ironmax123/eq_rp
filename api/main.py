import sys, os
import asyncio

# 実行環境に合わせてインポートパスを調整
current_dir = os.path.dirname(os.path.abspath(__file__))
if current_dir not in sys.path:
    sys.path.append(current_dir)
parent_dir = os.path.dirname(current_dir)
if parent_dir not in sys.path:
    sys.path.append(parent_dir)

# LCD1602モジュールのインポート
try:
    import LCD1602
except ImportError as e:
    print(f"LCD1602 import failed: {e}")
    LCD1602 = None

from src.routes.eq_route import eq_root_router
from src.routes.history_route import history_router
from fastapi import FastAPI
from contextlib import asynccontextmanager
from src.services.history_service import initialize_history
from src.repository.kmoni_cache_repository import get_cache_state

async def lcd_update_loop():
    """LCD表示を定期的に更新するバックグラウンドタスク"""
    print("LCD update loop started.")
    if not LCD1602:
        print("LCD1602 module is not available. LCD update skipped.")
        return
    
    # 参考コード (1.7_Lcd1602_zero.py) の通りに初期化
    try:
        initialized = LCD1602.init(0x27, 1)
    except Exception as e:
        print(f"LCD Init Error: {e}")
        return
    if initialized is False:
        print("LCD1602 init returned False. LCD update stopped.")
        return
    print("LCD1602 initialized successfully.")

    last_mode = None
    
    while True:
        try:
            state = get_cache_state()
            
            if state.is_eq_mode:
                # 地震検知モード
                if last_mode != "eq":
                    LCD1602.clear()
                    last_mode = "eq"
                
                # 1行目(y=0)にメッセージ、2行目(y=1)に震度を表示
                LCD1602.write(0, 0, "EARTHQUAKE!")
                
                intensity = "-"
                if state.kmoni_cache_data and state.kmoni_cache_data.get("earthquakes"):
                    eq = state.kmoni_cache_data["earthquakes"][0]
                    intensity = eq.get("maxIntensity", "-")
                
                LCD1602.write(0, 1, f"MAX INT: {intensity}")
            else:
                # 待機モード
                if last_mode != "standby":
                    LCD1602.clear()
                    LCD1602.write(0, 0, "STATUS:")
                    LCD1602.write(0, 1, "STANDBY")
                    last_mode = "standby"
        except Exception as e:
            print(f"LCD Write Error: {e}")
        
        await asyncio.sleep(1)

@asynccontextmanager
async def lifespan(app: FastAPI):
    print("FastAPI lifespan started.")
    # 履歴データの初期化
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
