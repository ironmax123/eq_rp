import re

def parse_cod(cod: str):
    # e.g. "+40.3+141.2-10000" or "+36.5-137.2-0"
    try:
        matches = re.findall(r'[+-][0-9.]+', cod)
        if len(matches) >= 3:
            lat = float(matches[0])
            lon = float(matches[1])
            depth_m = int(matches[2])
            depth = abs(depth_m) // 1000
            return lat, lon, depth
    except Exception:
        pass
    return 0.0, 0.0, 0

def parse_jma_json(data: list) -> list:
    history_list = []
    for item in data:
        if item.get("ttl") in ["震源・震度情報", "遠地地震に関する情報"]:
            lat, lon, depth = parse_cod(item.get("cod", ""))
            mag_str = item.get("mag", "0")
            try:
                mag = float(mag_str)
            except ValueError:
                mag = 0.0

            eq = {
                "id": item.get("eid", ""),
                "occurredAt": item.get("at", ""),
                "epicenter": {
                    "name": item.get("anm", ""),
                    "latitude": lat,
                    "longitude": lon,
                    "depth": depth
                },
                "magnitude": mag,
                "maxIntensity": item.get("maxi", "0"),
                "tsunami": False,
                "areas": []
            }
            history_list.append(eq)
    return history_list

def parse_jma_csv(data: list) -> list:
    history_list = []
    for row in data:
        try:
            depth_str = row.get("深さ", "0").replace("km", "").strip()
            depth = int(depth_str) if depth_str.isdigit() else 0
            mag = float(row.get("Ｍ", 0))
        except ValueError:
            depth = 0
            mag = 0.0

        lat_str = row.get("緯度", "")
        lon_str = row.get("経度", "")
        lat = 0.0
        lon = 0.0
        try:
            if '°' in lat_str:
                p = lat_str.replace('N', '').split('°')
                lat = float(p[0]) + (float(p[1].replace('′', '')) / 60.0 if p[1] else 0)
            if '°' in lon_str:
                p = lon_str.replace('E', '').split('°')
                lon = float(p[0]) + (float(p[1].replace('′', '')) / 60.0 if p[1] else 0)
        except Exception:
            pass

        eq = {
            "id": f"hist_{row.get('地震の発生日')} {row.get('地震の発生時刻')}",
            "occurredAt": f"{row.get('地震の発生日')} {row.get('地震の発生時刻')}",
            "epicenter": {
                "name": row.get("震央地名", ""),
                "latitude": lat,
                "longitude": lon,
                "depth": depth
            },
            "magnitude": mag,
            "maxIntensity": row.get("最大震度", "").replace("震度", ""),
            "tsunami": False,
            "areas": []
        }
        history_list.append(eq)
    return history_list
