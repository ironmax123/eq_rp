# GET /earthquakes

擬似地震データを取得するAPI。

## Request

### Headers

| ヘッダ名 | 必須 | 形式 | 説明 |
|----------|------|------|------|
| `X-Request-Time` | 任意 | `YYYYMMDDHHmmss`（14桁） | 指定日時以前のデータのみ返す。省略時は全件取得。 |

### Example

```
GET /earthquakes
X-Request-Time: 20260427090000
```

---

## Response

### `EarthquakeResponse`

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `earthquakes` | `Earthquake[]` | 地震データの配列 |

### `Earthquake`

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `id` | `string` | 地震ID（`YYYYMMDDHHmmss` 形式） |
| `occurredAt` | `string` | 発生日時（ISO 8601） |
| `epicenter` | `Epicenter` | 震源情報 |
| `magnitude` | `number` | マグニチュード |
| `maxIntensity` | `string` | 最大震度（`"1"` 〜 `"7"`, `"5-"`, `"5+"`, `"6-"`, `"6+"`） |
| `tsunami` | `boolean` | 津波の有無 |
| `areas` | `Area[]` | 観測地域ごとの震度 |

### `Epicenter`

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `name` | `string` | 震源地名 |
| `latitude` | `number` | 緯度 |
| `longitude` | `number` | 経度 |
| `depth` | `number` | 深さ（km） |

### `Area`

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `name` | `string` | 地域名 |
| `intensity` | `string` | 震度 |

---

## Example Response

```json
{
  "earthquakes": [
    {
      "id": "20260427140000",
      "occurredAt": "2026-04-27T14:00:00+09:00",
      "epicenter": {
        "name": "茨城県南部",
        "latitude": 36.1,
        "longitude": 140.1,
        "depth": 50
      },
      "magnitude": 4.5,
      "maxIntensity": "4",
      "tsunami": false,
      "areas": [
        { "name": "茨城県", "intensity": "4" },
        { "name": "栃木県", "intensity": "3" },
        { "name": "埼玉県", "intensity": "2" }
      ]
    }
  ]
}
```
