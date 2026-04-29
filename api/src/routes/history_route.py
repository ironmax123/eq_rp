from fastapi import APIRouter
from .handler.history_handler import get_history_handler

history_router = APIRouter()

@history_router.get("/history")
def history_endpoint():
    return get_history_handler()
