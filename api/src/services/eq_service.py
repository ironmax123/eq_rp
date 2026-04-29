from ..repository.eq_repository import eq_repository
from ..schemas.eq_schemas import eq_schemas

def eq_service(timestamp:int):
    response = eq_repository(timestamp)
    parsed=eq_schemas(response)
    return parsed