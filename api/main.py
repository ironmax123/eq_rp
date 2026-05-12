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
except ImportError:
    # 開発環境等でモジュールがない場合はNoneにしておく
    LCD1602 = None

from src.routes.eq_route import eq_root_router
from src.routes.history_route import history_router
from fastapi import FastAPI
from contextlib import asynccontextmanager
from src.services.history_service import initialize_history
from src.repository.kmoni_cache_repository import get_cache_state

async def lcd_update_loop():
    """LCD表示を定期的に更新するバックグラウンドタスク"""
    if not LCD1602:
        return
    
    # LCD初期化（自動検知に任せるため引数なしで実行）
    lcd_initialized = False
    while not lcd_initialized:
        try:
            # LCD1602.pyのinitは内部でi2cスキャンを行うため、デバイスが見つかるまでリトライ
            LCD1602.init()
            lcd_initialized = True
        except Exception:
            await asyncio.sleep(5) # 5秒待機してリトライ
            continue

    last_mode = None
    while True:
        try:
            state = get_cache_state()
            if state.is_eq_mode:
            # 地震検知モード
                if last_mode != "eq":
                    LCD1602.clear()
                    last_mode = "eq"
                
                # LCD1602は標準で日本語を表示できないため、英字で通知
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
        except Exception:
            pass
        
        await asyncio.sleep(1)

@asynccontextmanager
async def lifespan(app: FastAPI):
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