# In-memory history state
HISTORY_DATA = []

def get_history_data():
    global HISTORY_DATA
    return HISTORY_DATA[:60]

def set_history_data(data: list):
    global HISTORY_DATA
    HISTORY_DATA = data

def insert_to_history(eq: dict):
    global HISTORY_DATA
    HISTORY_DATA.insert(0, eq)
