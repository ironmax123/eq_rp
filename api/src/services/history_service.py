from src.repository.jma_repository import fetch_jma_json_api, fetch_local_csv
from src.repository.history_repository import set_history_data, get_history_data, insert_to_history
from src.schemas.jma_schemas import parse_jma_json, parse_jma_csv

def initialize_history():
    try:
        raw_json = fetch_jma_json_api()
        parsed_data = parse_jma_json(raw_json)
        if parsed_data:
            set_history_data(parsed_data)
            return
    except Exception as e:
        print(f"JMA API fetch failed, falling back to CSV: {e}")
        
    try:
        raw_csv = fetch_local_csv()
        parsed_data = parse_jma_csv(raw_csv)
        if parsed_data:
            set_history_data(parsed_data)
    except Exception as e:
        print(f"Fallback CSV parse failed: {e}")

def get_history_service():
    return {"earthquakes": get_history_data()}

def add_to_history(eq_data: dict):
    insert_to_history(eq_data)
