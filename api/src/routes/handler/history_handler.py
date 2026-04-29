from src.services.history_service import get_history_service
from .error_handler import error_handler

def get_history_handler():
    try:
        return get_history_service()
    except Exception as e:
        return error_handler(e)
