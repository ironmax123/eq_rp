# バグ修正計画書: 予測震度が maxIntensity を超える問題

## 発生日: 2026-05-12

## 1. バグの概要

`predict_prefecture_intensity()` で算出した各都道府県の予測震度が、
APIから提供される `maxIntensity`（実際に観測された最大震度）を上回るケースがある。

**例:**
- API の `maxIntensity` = "3"（実際の最大観測震度）
- 予測結果で東京: "4"、埼玉: "5-" などが返されてしまう

## 2. 根本原因の分析

### 原因1: 距離減衰式の系統的な過大推定（主因）
司・翠川（1999）の計算式はあくまで統計的な**中央値（50パーセンタイル）推定**です。
気象庁Mj（気象庁マグニチュード）をモーメントマグニチュード Mw としてそのまま使用しているため、
**中小規模地震（M3〜M5）では Mj が Mw より大きくなる傾向**があり、式が実際よりも強い揺れを計算してしまいます。

### 原因2: 表層地盤増幅率（ARV）の固定値による過大評価
フェーズ1では平野部を中心に ARV を 1.5〜1.8 の固定値にしていますが、
実際の観測地点は平野・山間部混在のため、系統的に高めに出る場合があります。

### 原因3: ARV補正の二重適用リスク
計算式自体がある程度の地盤効果を含む経験式のため、ARVを追加で掛けると二重補正になる可能性があります。

## 3. 対策方針

**APIが提供する `maxIntensity` を「上限」として予測結果をキャップする。**

理由:
- `maxIntensity` は気象庁の実際の観測値（または速報値）であり、「この地震で観測された最大震度」として最も信頼性が高い。
- 距離減衰式はあくまで近似であるため、「実際の最大観測値を超えてはならない」という制約を課すことが自然。
- Flutter側の色分けにおいて、報告された最大震度を超える色が塗られることは誤解を生む。

**副次対策: ARV を 1.0 に統一（過大評価の抑制）**
フェーズ1の段階ではARV固定値による過大評価を抑えるため、全都道府県のARVを 1.0 に下げることも同時に検討する。

## 4. 修正箇所

### 修正1: `formula.py` の `predict_prefecture_intensity` に `max_intensity` 引数を追加

```python
def predict_prefecture_intensity(
    eq_lat: float,
    eq_lon: float,
    depth_km: float,
    magnitude: float,
    max_intensity: str | None = None,  # ← 追加: APIからの最大震度上限
) -> list[dict]:
    ...
    # 最後にキャップ処理を適用
```

### 修正2: `eq_schemas.py` と `jma_schemas.py` から `maxIntensity` を `predict_prefecture_intensity` に渡す

```python
# eq_schemas.py
max_i = data.get("calcintensity", "")
"areas": predict_prefecture_intensity(lat, lon, depth, mag, max_i)

# jma_schemas.py (JSON)
max_i = item.get("maxi", "")
"areas": predict_prefecture_intensity(lat, lon, depth, mag, max_i)

# jma_schemas.py (CSV)
max_i = row.get("最大震度", "").replace("震度", "")
"areas": predict_prefecture_intensity(lat, lon, depth, mag, max_i)
```

## 5. キャップロジックの詳細設計

震度階級を数値順序として扱い、`maxIntensity` より大きい階級を `maxIntensity` に丸める。

順序定義:
```
"0" < "1" < "2" < "3" < "4" < "5-" < "5+" < "6-" < "6+" < "7"
```

処理:
- 各都道府県の予測震度階級が `maxIntensity` を超えている場合は `maxIntensity` に置き換える。
- `maxIntensity` が空文字・パース不能の場合はキャップ処理をスキップする（安全側）。

## 6. 修正後の期待動作

| 入力 maxIntensity | 予測結果(埼玉) | 修正後 |
|------------------|--------------|--------|
| "3"              | "5-"         | "3"    |
| "4"              | "6-"         | "4"    |
| ""（不明）        | "5-"         | "5-"（変更なし）|
