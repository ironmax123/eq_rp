from src.services.eq_service import eq_service
from .error_handler import error_handler

def eq_handler(timestamp:int):
    try:
        result = eq_service(timestamp)
        return result
    except Exception as e:
        return error_handler(e)