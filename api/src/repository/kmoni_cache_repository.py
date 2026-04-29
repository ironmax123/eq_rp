from datetime import datetime

class KmoniCache:
    def __init__(self):
        self.is_eq_mode = False
        self.eq_mode_end_time = None
        self.last_kmoni_fetch_time = None
        self.kmoni_cache_data = None
        self.eq_detected_time = None
        self.added_to_history = False

# グローバルインスタンスとしてキャッシュ状態を保持
cache_state = KmoniCache()

def get_cache_state():
    return cache_state
