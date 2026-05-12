# Raspberry Pi環境で areas が空になる問題の修正計画

## 考えられる原因

Mac上では正常に動作し、Linux (Raspberry Pi) 環境でのみ `"areas": []` となる原因は、**Raspberry Pi環境においてJMA APIの通信エラー（SSL証明書の問題やタイムアウト等）が発生し、フォールバックとしてローカルのCSV (`data/hist.csv`) を読み込んでいるため**です。

フォールバック用のCSVの読み込み処理において、以下の2つの不具合が重なっているため `areas` が空になっています。

1. **UTF-8 BOMの未処理**:
   `data/hist.csv` はUTF-8 (BOM付き) で保存されています。しかし、`src/repository/jma_repository.py` では `encoding="utf-8"` として読み込んでいるため、最初のカラム名が `\ufeff地震の発生日` となり、正しくデータを取得できていません。
2. **全角・半角の差異と「弱・強」表記**:
   CSVデータの「最大震度」カラムには「震度１」のように全角数字が使用されています（また、震度5弱などは「震度５弱」）。
   `jma_schemas.py` では `row.get("最大震度", "").replace("震度", "")` としていますが、これだと `１` (全角) や `５弱` が残ります。
   震度を計算する `predict_prefecture_intensity` 内の `_INTENSITY_ORDER` (震度階級マップ) は半角数字 (`"1"`, `"5-"`, `"5+"`) を期待しているため、マップにマッチせず、下限補正 (`_floor_intensity`) が適用されません。
   結果として小規模な地震などで計算震度が0になった場合、補正が効かずに全ての都道府県が除外され `"areas": []` になってしまいます。

## 対策と修正計画

### 1. CSV読み込み時のBOM対応
`api/src/repository/jma_repository.py`
```python
- with open(csv_path, "r", encoding="utf-8") as f:
+ with open(csv_path, "r", encoding="utf-8-sig") as f:
```

### 2. 震度文字列の正規化 (全角→半角、弱・強→ -, +)
`api/src/schemas/jma_schemas.py` の `parse_jma_csv` において
```python
- "maxIntensity": row.get("最大震度", "").replace("震度", "").strip(),
+ max_int_str = row.get("最大震度", "").replace("震度", "").translate(str.maketrans('０１２３４５６７８９', '0123456789')).strip()
+ max_int_str = max_int_str.replace("弱", "-").replace("強", "+")
```
とし、`eq` 辞書の作成時に正規化された `max_int_str` を使用します。

---

上記対応を行うことで、Raspberry Pi上でAPI取得がタイムアウトやエラーでCSVにフォールバックした際にも、Mac上と同じように正常に `areas` を計算・返却できるようになります。
