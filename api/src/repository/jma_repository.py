import httpx
import csv
import os

def fetch_jma_json_api():
    """JMA公式APIから直近の地震情報を取得して生のJSON(dictのリスト)を返す"""
    url = "https://www.jma.go.jp/bosai/quake/data/list.json"
    with httpx.Client(timeout=10.0) as client:
        res = client.get(url)
        res.raise_for_status()
        return res.json()

def fetch_local_csv():
    """フォールバック用のローカルCSVから生データを取得してdictのリストを返す"""
    csv_path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), "data", "hist.csv")
    raw_data = []
    with open(csv_path, "r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            raw_data.append(row)
    return raw_data
