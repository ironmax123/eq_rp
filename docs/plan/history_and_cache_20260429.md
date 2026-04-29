# history機能とK-moniキャッシュ機能の実装計画

## 概要
- AGENTS.mdに指定の文言を追記する
- `/v1/history` エンドポイントを新設し、過去の地震履歴（直近60件）を返すようにする
- 起動時に指定のJMAサイトの情報を取得する（※実際にはHTMLページのため、既に存在する `api/data/hist.csv` をメモリに読み込む、またはスクレイピングの代替としてローカルの履歴データを初期状態とする）
- 強震モニタAPI（K-moni）から地震データを取得した際、10分間はキャッシュモード（1分間に1回のみ更新）に移行し、不要なリクエストを防ぐ
- 地震検知から3分経過後に、取得した地震データを履歴（history）の先頭に追加する

## 変更対象ファイルと作業内容

### 1. `AGENTS.md` (新規作成または追記)
- 以下の文言を記載する: `"このプロジェクトのFastAPIはローカル起動のみを想定しいます"`

### 2. `api/main.py`
- FastAPIの `lifespan` イベント（または `@app.on_event("startup")`）を定義し、起動時に `api/data/hist.csv` を読み込み、履歴データをメモリ上のリスト（`HISTORY_DATA`）に保持する。
- 新規エンドポイント `@app.get("/v1/history")` を作成し、`HISTORY_DATA` の上位60件を返すようにする。

### 3. `api/src/routes/handler/eq_handler.py`
- グローバル変数（またはクラスインスタンス）としてキャッシュの状態を管理する。
  - `is_eq_mode`: 地震検知中フラグ
  - `eq_detected_time`: 地震を検知した時刻
  - `last_fetch_time`: 最後にK-moniにリクエストを飛ばした時刻
  - `kmoni_cache`: キャッシュされたレスポンスデータ
  - `added_to_history`: 履歴に追加済みかどうかのフラグ
- K-moniへのリクエスト制御フロー：
  - もし `is_eq_mode` がTrueの場合、現在の時刻が `eq_detected_time` から10分を超えていればキャッシュモードを解除する。
  - キャッシュモード中の場合、`last_fetch_time` から1分経過していなければ `kmoni_cache` を返す。
  - 1分経過していれば、再度K-moniへリクエストを飛ばす。
  - 同時に、地震検知から3分経過しており、かつ `added_to_history` がFalseであれば、取得した地震データを `HISTORY_DATA` の先頭に追加しフラグをTrueにする。
  - もし `is_eq_mode` がFalseで、K-moniから有効なデータ（`earthquakes` が空ではない）が返ってきた場合、キャッシュモードに移行する。

### 注意事項
- K-moniからのデータと履歴CSVデータのフォーマットの差異を吸収し、`/v1/history` は一貫した構造（デモAPI準拠）で返すようにする。
