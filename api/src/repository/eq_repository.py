import httpx

def eq_repository(timestamp:int):
    url = "https://www.kmoni.bosai.go.jp/webservice/hypo/eew/"
    with httpx.Client() as client:
        response = client.get(f"{url}{timestamp}")
    return response