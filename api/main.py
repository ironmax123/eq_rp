import sys, os
import asyncio
import importlib.util
import time

# 実行環境に合わせてインポートパスを調整
current_dir = os.path.dirname(os.path.abspath(__file__))
if current_dir not in sys.path:
    sys.path.append(current_dir)
parent_dir = os.path.dirname(current_dir)
if parent_dir not in sys.path:
    sys.path.append(parent_dir)

def load_lcd1602():
    """Load LCD1602.py placed next to this file without depending on cwd."""
    module_path = os.path.join(current_dir, "LCD1602.py")
    if not os.path.exists(module_path):
        print(f"LCD1602 file not found: {module_path}")
        return None

    try:
        spec = importlib.util.spec_from_file_location("LCD1602", module_path)
        if spec is None or spec.loader is None:
            print(f"LCD1602 import spec could not be created: {module_path}")
            return None
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        print(f"LCD1602 loaded from: {module_path}")
        return module
    except Exception as e:
        print(f"LCD1602 import failed from {module_path}: {type(e).__name__}: {e}")
        return None


LCD1602 = load_lcd1602()

try:
    from gpiozero import TonalBuzzer
except ImportError as e:
    print(f"TonalBuzzer import failed: {e}")
    TonalBuzzer = None

from src.routes.eq_route import eq_root_router
from src.routes.history_route import history_router
from fastapi import FastAPI
from contextlib import asynccontextmanager
from src.services.history_service import initialize_history
from src.repository.kmoni_cache_repository import get_cache_state

BUZZER_PIN = 17
BUZZER_TUNE = [
    ("C#4", 0.2),
    ("D4", 0.2),
    (None, 0.2),
    ("Eb4", 0.2),
    ("E4", 0.2),
    (None, 0.6),
    ("F#4", 0.2),
    ("G4", 0.2),
    (None, 0.6),
    ("Eb4", 0.2),
    ("E4", 0.2),
    (None, 0.2),
    ("F#4", 0.2),
    ("G4", 0.2),
    (None, 0.2),
    ("C4", 0.2),
    ("B4", 0.2),
    (None, 0.2),
    ("F#4", 0.2),
    ("G4", 0.2),
    (None, 0.2),
    ("B4", 0.2),
    ("Bb4", 0.5),
    (None, 0.6),
    ("A4", 0.2),
    ("G4", 0.2),
    ("E4", 0.2),
    ("D4", 0.2),
    ("E4", 0.2),
]


def play_buzzer_tune():
    if TonalBuzzer is None:
        print("Buzzer alert skipped because TonalBuzzer is not available.")
        return

    buzzer = None
    try:
        buzzer = TonalBuzzer(BUZZER_PIN)
        for note, duration in BUZZER_TUNE:
            buzzer.play(note)
            time.sleep(float(duration))
    except Exception as e:
        print(f"Buzzer play error: {e}")
    finally:
        if buzzer is not None:
            try:
                buzzer.stop()
                buzzer.close()
            except Exception as e:
                print(f"Buzzer stop error: {e}")


async def play_buzzer_alert():
    await asyncio.to_thread(play_buzzer_tune)


async def lcd_update_loop():
    """LCD表示を定期的に更新するバックグラウンドタスク"""
    print("LCD update loop started.")
    lcd_ready = False
    if not LCD1602:
        print("LCD1602 module is not available. LCD update skipped.")
    else:
        # 参考コード (1.7_Lcd1602_zero.py) の通りに初期化
        try:
            initialized = LCD1602.init(0x27, 1)
        except Exception as e:
            print(f"LCD Init Error: {e}")
        else:
            if initialized is False:
                print("LCD1602 init returned False. LCD update stopped.")
            else:
                lcd_ready = True
                print("LCD1602 initialized successfully.")

    last_mode = None
    
    while True:
        try:
            state = get_cache_state()
            
            if state.is_eq_mode:
                # 地震検知モード
                if last_mode != "eq":
                    if lcd_ready:
                        LCD1602.clear()
                    asyncio.create_task(play_buzzer_alert())
                    last_mode = "eq"
                
                # 1行目(y=0)にメッセージ、2行目(y=1)に震度を表示
                if lcd_ready:
                    LCD1602.write(0, 0, "EARTHQUAKE!")
                
                intensity = "-"
                if state.kmoni_cache_data and state.kmoni_cache_data.get("earthquakes"):
                    eq = state.kmoni_cache_data["earthquakes"][0]
                    intensity = eq.get("maxIntensity", "-")
                
                if lcd_ready:
                    LCD1602.write(0, 1, f"MAX INT: {intensity}")
            else:
                # 待機モード
                if last_mode != "standby":
                    if lcd_ready:
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
