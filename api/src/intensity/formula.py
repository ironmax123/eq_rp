"""
司・翠川（1999）距離減衰式による都道府県別震度予測モジュール

採用式:
  Step1: log10(PGVb600) = 0.58*Mw + 0.0038*D + d - 1.29
                          - log10(X + 0.0028 * 10^(0.50*Mw)) - 0.002*X
  Step2: PGVb400 = PGVb600 * 1.31
  Step3: PGVs    = PGVb400 * ARV  (ARV: 表層地盤増幅率、フェーズ1では固定値)
  Step4: I       = 2.68 + 1.72 * log10(PGVs)  → 計測震度
  Step5: 計測震度 → 震度階級（気象庁スケール）にマッピング

参考文献:
  - 司 宏俊, 翠川 三郎 (1999): 断層最短距離を用いた最大加速度・最大速度の
    距離減衰式, 日本建築学会構造系論文集, Vol.64, No.523, pp.63-70.
  - 翠川 三郎 他 (1999): 計測震度と最大地動速度・最大地動加速度の関係
  - 防災科学技術研究所 (NIED) J-SHIS 地震動予測地図 計算手法
"""

import math
from typing import TypedDict


# ---------------------------------------------------------------------------
# 47都道府県の代表座標（県庁所在地）と地盤増幅率（ARV）
# ARVはフェーズ1では一律1.5（全国平均的な値）を使用。
# 参考: 防災科研 J-SHISの全国平均ARVは平野部で1.3〜2.0、山間部で0.8〜1.2程度。
# ---------------------------------------------------------------------------
class PrefectureInfo(TypedDict):
    lat: float
    lon: float
    arv: float  # 表層地盤増幅率（フェーズ1固定値）


PREFECTURE_DATA: dict[str, PrefectureInfo] = {
    "hokkaido":  {"lat": 43.0642, "lon": 141.3469, "arv": 1.3},
    "aomori":    {"lat": 40.8246, "lon": 140.7400, "arv": 1.3},
    "iwate":     {"lat": 39.7036, "lon": 141.1527, "arv": 1.3},
    "miyagi":    {"lat": 38.2688, "lon": 140.8721, "arv": 1.5},
    "akita":     {"lat": 39.7186, "lon": 140.1024, "arv": 1.4},
    "yamagata":  {"lat": 38.2404, "lon": 140.3634, "arv": 1.3},
    "fukushima": {"lat": 37.7500, "lon": 140.4676, "arv": 1.4},
    "ibaraki":   {"lat": 36.3418, "lon": 140.4468, "arv": 1.6},
    "tochigi":   {"lat": 36.5657, "lon": 139.8836, "arv": 1.4},
    "gunma":     {"lat": 36.3911, "lon": 139.0608, "arv": 1.3},
    "saitama":   {"lat": 35.8570, "lon": 139.6489, "arv": 1.8},
    "chiba":     {"lat": 35.6047, "lon": 140.1233, "arv": 1.8},
    "tokyo":     {"lat": 35.6895, "lon": 139.6917, "arv": 1.7},
    "kanagawa":  {"lat": 35.4478, "lon": 139.6425, "arv": 1.6},
    "niigata":   {"lat": 37.9022, "lon": 139.0235, "arv": 1.5},
    "toyama":    {"lat": 36.6953, "lon": 137.2113, "arv": 1.4},
    "ishikawa":  {"lat": 36.5944, "lon": 136.6256, "arv": 1.4},
    "fukui":     {"lat": 36.0652, "lon": 136.2219, "arv": 1.4},
    "yamanashi": {"lat": 35.6635, "lon": 138.5685, "arv": 1.3},
    "nagano":    {"lat": 36.6513, "lon": 138.1810, "arv": 1.3},
    "gifu":      {"lat": 35.3912, "lon": 136.7223, "arv": 1.4},
    "shizuoka":  {"lat": 34.9769, "lon": 138.3831, "arv": 1.5},
    "aichi":     {"lat": 35.1802, "lon": 136.9066, "arv": 1.6},
    "mie":       {"lat": 34.7303, "lon": 136.5086, "arv": 1.4},
    "shiga":     {"lat": 35.0045, "lon": 135.8686, "arv": 1.4},
    "kyoto":     {"lat": 35.0116, "lon": 135.7681, "arv": 1.5},
    "osaka":     {"lat": 34.6937, "lon": 135.5022, "arv": 1.7},
    "hyogo":     {"lat": 34.6913, "lon": 135.1830, "arv": 1.5},
    "nara":      {"lat": 34.6851, "lon": 135.8327, "arv": 1.3},
    "wakayama":  {"lat": 34.2260, "lon": 135.1675, "arv": 1.3},
    "tottori":   {"lat": 35.5039, "lon": 134.2379, "arv": 1.3},
    "shimane":   {"lat": 35.4722, "lon": 133.0505, "arv": 1.3},
    "okayama":   {"lat": 34.6618, "lon": 133.9344, "arv": 1.4},
    "hiroshima": {"lat": 34.3963, "lon": 132.4596, "arv": 1.5},
    "yamaguchi": {"lat": 34.1861, "lon": 131.4706, "arv": 1.3},
    "tokushima": {"lat": 34.0658, "lon": 134.5593, "arv": 1.4},
    "kagawa":    {"lat": 34.3402, "lon": 134.0434, "arv": 1.4},
    "ehime":     {"lat": 33.8417, "lon": 132.7657, "arv": 1.3},
    "kochi":     {"lat": 33.5597, "lon": 133.5311, "arv": 1.4},
    "fukuoka":   {"lat": 33.6064, "lon": 130.4181, "arv": 1.5},
    "saga":      {"lat": 33.2494, "lon": 130.2988, "arv": 1.4},
    "nagasaki":  {"lat": 32.7503, "lon": 129.8777, "arv": 1.3},
    "kumamoto":  {"lat": 32.7898, "lon": 130.7417, "arv": 1.4},
    "oita":      {"lat": 33.2382, "lon": 131.6126, "arv": 1.3},
    "miyazaki":  {"lat": 31.9110, "lon": 131.4239, "arv": 1.3},
    "kagoshima": {"lat": 31.5602, "lon": 130.5581, "arv": 1.3},
    "okinawa":   {"lat": 26.2124, "lon": 127.6809, "arv": 1.3},
}


def _haversine_km(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    """2点間の球面距離（km）を Haversine 公式で計算する"""
    R = 6371.0
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    dphi = math.radians(lat2 - lat1)
    dlambda = math.radians(lon2 - lon1)
    a = math.sin(dphi / 2) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(dlambda / 2) ** 2
    return R * 2 * math.asin(math.sqrt(a))


def _hypo_dist_km(surface_dist_km: float, depth_km: float) -> float:
    """震源距離（3次元距離）を計算する"""
    return math.sqrt(surface_dist_km ** 2 + depth_km ** 2)


def _pgv_b600(mw: float, depth_km: float, hypo_dist_km: float, d: float = 0.0) -> float:
    """
    司・翠川（1999）: 基準基盤（Vs=600m/s）上の最大速度 PGVb600 (cm/s)
    
    log10(PGVb600) = 0.58*Mw + 0.0038*D + d - 1.29
                     - log10(X + 0.0028 * 10^(0.50*Mw)) - 0.002*X
    
    引数:
        mw: モーメントマグニチュード
        depth_km: 震源深さ (km)
        hypo_dist_km: 震源距離 X (km)
        d: 地震タイプ係数 (地殻内=0, プレート間=-0.02, プレート内=0.12)
    """
    X = max(hypo_dist_km, 1.0)  # ゼロ除算防止
    inner = X + 0.0028 * (10 ** (0.50 * mw))
    log_pgv = (
        0.58 * mw
        + 0.0038 * depth_km
        + d
        - 1.29
        - math.log10(inner)
        - 0.002 * X
    )
    return 10 ** log_pgv


def _instrumental_intensity(pgvs: float) -> float:
    """
    翠川・他（1999）: 地表最大速度(PGVs, cm/s) → 計測震度
    I = 2.68 + 1.72 * log10(PGVs)
    """
    if pgvs <= 0:
        return 0.0
    return 2.68 + 1.72 * math.log10(pgvs)


# 震度階級の順序マップ（小さい値ほど弱い揺れ）
# API の maxIntensity と予測値を比較するために使用する
_INTENSITY_ORDER: dict[str, int] = {
    "0": 0, "1": 1, "2": 2, "3": 3, "4": 4,
    "5-": 5, "5+": 6, "6-": 7, "6+": 8, "7": 9,
}


def _intensity_class(i: float) -> str:
    """
    計測震度 I → 気象庁震度階級（文字列）にマッピング
    気象庁の変換基準:
      I < 0.5       → "0"
      0.5 <= I < 1.5 → "1"
      1.5 <= I < 2.5 → "2"
      2.5 <= I < 3.5 → "3"
      3.5 <= I < 4.5 → "4"
      4.5 <= I < 5.0 → "5-"  (震度5弱)
      5.0 <= I < 5.5 → "5+"  (震度5強)
      5.5 <= I < 6.0 → "6-"  (震度6弱)
      6.0 <= I < 6.5 → "6+"  (震度6強)
      6.5 <= I       → "7"
    """
    if i < 0.5:
        return "0"
    elif i < 1.5:
        return "1"
    elif i < 2.5:
        return "2"
    elif i < 3.5:
        return "3"
    elif i < 4.5:
        return "4"
    elif i < 5.0:
        return "5-"
    elif i < 5.5:
        return "5+"
    elif i < 6.0:
        return "6-"
    elif i < 6.5:
        return "6+"
    else:
        return "7"


def _cap_intensity(predicted: str, max_intensity: str | None) -> str:
    """
    予測震度階級を maxIntensity で上限キャップする。

    maxIntensity が空・不正値・未知の場合はキャップせずそのまま返す。
    """
    if not max_intensity:
        return predicted
    cap = max_intensity.strip()
    if cap not in _INTENSITY_ORDER or predicted not in _INTENSITY_ORDER:
        return predicted
    if _INTENSITY_ORDER[predicted] > _INTENSITY_ORDER[cap]:
        return cap
    return predicted


def _floor_intensity(predicted: str, max_intensity: str | None) -> str:
    """
    予測震度階級を maxIntensity でフロア（下限）補正する。

    震源最近傍の都道府県にのみ適用する想定。
    予測値が maxIntensity より低い場合に引き上げる。
    maxIntensity が空・不正値・未知の場合は補正せずそのまま返す。
    """
    if not max_intensity:
        return predicted
    floor = max_intensity.strip()
    if floor not in _INTENSITY_ORDER or predicted not in _INTENSITY_ORDER:
        return predicted
    if _INTENSITY_ORDER[predicted] < _INTENSITY_ORDER[floor]:
        return floor
    return predicted


def predict_prefecture_intensity(
    eq_lat: float,
    eq_lon: float,
    depth_km: float,
    magnitude: float,
    max_intensity: str | None = None,
) -> list[dict]:
    """
    震源情報から47都道府県の予測震度を計算して返す。

    引数:
        eq_lat: 震源緯度 (度)
        eq_lon: 震源経度 (度)
        depth_km: 震源深さ (km)
        magnitude: マグニチュード（気象庁Mj、Mwとして近似使用）
        max_intensity: APIから取得した最大震度。
                       - 上限キャップ: 全都道府県に適用（予測が超えないよう制限）
                       - 下限フロア : 震源最近傍の1都道府県のみ適用
                         （内陸地震などで予測が過小になるケースを補正）
                       例: "3", "5-", "6+" など。空の場合は両補正ともスキップ。

    戻り値:
        [{"pref": "tokyo", "intensity": "3"}, ...] の形式のリスト
        震度0の地域は除外する（Flutterでの色塗り不要のため）
    """
    if eq_lat == 0.0 and eq_lon == 0.0:
        return []
    if magnitude <= 0:
        return []

    mw = magnitude  # 気象庁Mjをそのままモーメントマグニチュードとして近似
    depth = max(depth_km, 1.0)  # 浅すぎる地震の安全処理

    # --- Step1〜6: 全都道府県の予測震度を計算し一時リストに格納 ---
    # surface_dist（震央距離）も保持して最近傍特定に使う
    tmp: list[dict] = []  # {pref, intensity, surface_dist}
    for pref_key, info in PREFECTURE_DATA.items():
        surface_dist = _haversine_km(eq_lat, eq_lon, info["lat"], info["lon"])
        hypo_dist = _hypo_dist_km(surface_dist, depth)

        pgv_b600 = _pgv_b600(mw, depth, hypo_dist)
        pgv_b400 = pgv_b600 * 1.31               # Step2: 工学的基盤への増幅
        pgv_s = pgv_b400 * info["arv"]           # Step3: 表層地盤増幅
        instr_i = _instrumental_intensity(pgv_s) # Step4: 計測震度
        cls = _intensity_class(instr_i)          # Step5: 震度階級
        cls = _cap_intensity(cls, max_intensity) # Step6: maxIntensity で上限キャップ

        tmp.append({"name": pref_key, "intensity": cls, "surface_dist": surface_dist})

    # --- Step7: 震源最近傍の都道府県に maxIntensity のフロアを適用 ---
    # 内陸地震など、県庁所在地が震源から遠い場合の過小推定を補正する。
    if tmp and max_intensity:
        closest = min(tmp, key=lambda x: x["surface_dist"])
        closest["intensity"] = _floor_intensity(closest["intensity"], max_intensity)

    # --- 震度0を除外して返す ---
    return [
        {"name": item["name"], "intensity": item["intensity"]}
        for item in tmp
        if item["intensity"] != "0"
    ]
