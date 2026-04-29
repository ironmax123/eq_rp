from ..repository.eq_repository import eq_repository
from ..schemas.eq_schemas import eq_schemas
from src.repository.kmoni_cache_repository import get_cache_state
from src.services.history_service import add_to_history
from datetime import datetime, timedelta

def fetch_kmoni(timestamp: int):
    response = eq_repository(timestamp)
    return eq_schemas(response)

def eq_service(timestamp: int):
    state = get_cache_state()
    current_time = datetime.now()
    
    # キャッシュモード終了判定（10分経過）
    if state.is_eq_mode and state.eq_mode_end_time and current_time > state.eq_mode_end_time:
        state.is_eq_mode = False
        state.kmoni_cache_data = None
        
    if state.is_eq_mode:
        # 1分間はキャッシュを返す
        if state.last_kmoni_fetch_time and (current_time - state.last_kmoni_fetch_time) < timedelta(minutes=1):
            return state.kmoni_cache_data
        else:
            # 1分経過したので再フェッチ
            result = fetch_kmoni(timestamp)
            state.kmoni_cache_data = result
            state.last_kmoni_fetch_time = current_time
            
            # 地震検知から3分経過かつ未追加なら履歴に追加
            if state.eq_detected_time and (current_time - state.eq_detected_time) >= timedelta(minutes=3) and not state.added_to_history:
                if result.get("earthquakes") and len(result["earthquakes"]) > 0:
                    add_to_history(result["earthquakes"][0])
                state.added_to_history = True
                
            return result
    else:
        # 通常モード：常にフェッチ
        result = fetch_kmoni(timestamp)
        
        # データが入っていたら地震モード（キャッシュモード）に移行
        if result and result.get("earthquakes") and len(result["earthquakes"]) > 0:
            state.is_eq_mode = True
            state.eq_mode_end_time = current_time + timedelta(minutes=10)
            state.last_kmoni_fetch_time = current_time
            state.eq_detected_time = current_time
            state.added_to_history = False
            state.kmoni_cache_data = result
            
        return result