def eq_schemas(response):
    try:
        data = response.json()
    except Exception:
        return {"earthquakes": []}

    if data.get("result", {}).get("status") != "success":
        return {"earthquakes": []}

    # 地震が発生していない場合 ("データがありません" など)
    if not data.get("report_id"):
        return {"earthquakes": []}

    # 値のパース
    try:
        depth_str = str(data.get("depth", "0")).replace("km", "")
        depth = int(depth_str) if depth_str.isdigit() else 0
    except ValueError:
        depth = 0

    try:
        lat = float(data.get("latitude", 0))
    except ValueError:
        lat = 0.0

    try:
        lon = float(data.get("longitude", 0))
    except ValueError:
        lon = 0.0

    try:
        # 強震モニタは "magunitude" というキーを使用する
        mag = float(data.get("magunitude", 0))
    except ValueError:
        mag = 0.0

    eq = {
        "id": data.get("report_id", ""),
        "occurredAt": data.get("origin_time", ""),
        "epicenter": {
            "name": data.get("region_name", ""),
            "latitude": lat,
            "longitude": lon,
            "depth": depth
        },
        "magnitude": mag,
        "maxIntensity": data.get("calcintensity", ""),
        "tsunami": False,
        "areas": []
    }

    return {"earthquakes": [eq]}