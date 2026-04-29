def error_handler(e):
    return {
        "status":"500",
        "error": str(e)
    }