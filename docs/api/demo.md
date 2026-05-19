# 地震デモAPI仕様

`api/main_demo.py` は、通常の FastAPI API と同じルート、キャッシュ戦略、地震モードを使いながら、起動から10秒後に EEW リポジトリだけをデモデータへ切り替えるデモ用エントリーポイントです。

`api/mian_demo.py` は `api/main_demo.py` の互換ラッパーです。

## 起動方法

```bash
cd api
fastapi dev main_demo.py
```
```

## 通常APIとの差分

- ルート構成は `api/main.py` と同じです。
- `/v1/eq/{timestamp}` のキャッシュ戦略は `api/src/services/eq_service.py` の既存実装をそのまま使います。
- 地震モードの継続時間、1分キャッシュ、3分後の履歴追加判定も既存実装と同じです。
- 起動後10秒経過すると、`eq_service` が参照する EEW リポジトリ関数だけをデモ用に差し替えます。
- デモ切り替え時に既存の Kmoni キャッシュ状態はクリアします。

## デモデータ

10秒経過後、次回以降の `/v1/eq/{timestamp}` は以下の EEW 相当データを返します。

| 項目 | 値 |
| --- | --- |
| 震央地名 | 東京湾 |
| 最大震度 | 5弱 |
| 緯度 | 35.55 |
| 経度 | 139.85 |
| 深さ | 30km |
| マグニチュード | 5.8 |
| 発生時刻 | 2026/05/19 12:00:00 |

## エンドポイント

### `GET /`

デモ API の起動確認用です。

レスポンス:

```json
"earthquakes api demo"
```

### `GET /v1/eq/{timestamp}`

通常 API と同じ形式で地震情報を返します。

起動から10秒未満:

- 通常の EEW リポジトリを使います。
- 実際の Kmoni レスポンスに従います。

起動から10秒後:

- デモ EEW リポジトリを使います。
- 東京湾で最大震度5弱のデモ地震として処理されます。
- `eq_service` の通常処理に通すため、デモデータ取得後は既存ロジックにより地震モードへ移行します。

レスポンス例:

```json
{
  "earthquakes": [
    {
      "id": "demo_tokyo_bay_5",
      "occurredAt": "2026/05/19 12:00:00",
      "epicenter": {
        "name": "東京湾",
        "latitude": 35.55,
        "longitude": 139.85,
        "depth": 30
      },
      "magnitude": 5.8,
      "maxIntensity": "5-",
      "tsunami": false,
      "areas": []
    }
  ]
}
```

`areas` は既存の震度予測ロジックにより実行時に計算されます。
