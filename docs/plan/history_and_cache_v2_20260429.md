# history機能とK-moniキャッシュ機能の実装計画 (v2)

## 概要と前回からの修正点
前回の計画および実装において、以下の問題点をご指摘いただき、深く反省しております。
1. **計画書の承認前に実装を進めてしまった点**
   今回はまず計画書として方針をご提示し、ご了承いただいた上で実装フェーズに移ります。
2. **アーキテクチャの破綻**
   Handler層にビジネスロジックや状態管理が混在していました。本計画では Repository / Service / Handler / Route の各層の責務を正しく分割します。
3. **スクレイピングの排除と正確なAPI仕様の調査**
   JMAの震度データベースは `index.html` をスクレイピングするのではなく、バックエンドにある公式API（`api/api.php`）に対して適切なPOSTリクエスト（検索条件等のパラメータ）を送信することで、直接データをダウンロードできる仕様です。この手法を用いてデータを取得します。

---

## 責務分割とアーキテクチャ設計

### 1. Route層 (`api/src/routes/`)
- **責務**: エンドポイントの定義と、対応するHandlerの呼び出しのみを行う。
- **追加ファイル**: `history_route.py`
  - `@app.get("/v1/history")` を定義し、`history_handler` を呼び出す。

### 2. Handler層 (`api/src/routes/handler/`)
- **責務**: リクエスト/レスポンスの受け渡し、およびエラーハンドリングを行う。
- **追加/修正ファイル**: 
  - `history_handler.py` (新規作成)
  - `eq_handler.py` (既存修正: 前回混入させたキャッシュロジック等をすべてService層に移譲し、シンプルに `eq_service` を呼ぶだけに修正)

### 3. Service層 (`api/src/services/`)
- **責務**: アプリケーションのビジネスロジック、状態遷移、キャッシュの判定、3分後の履歴追加ロジックなどを統括する。
- **追加/修正ファイル**:
  - `history_service.py` (新規作成: 履歴データのフォーマット変換や、取得ロジックの統括)
  - `eq_service.py` (既存修正: K-moniリクエスト時のキャッシュ状態の判定、および地震検知から3分経過時の履歴追加（`history_service`経由）を制御する)

### 4. Repository層 (`api/src/repository/`)
- **責務**: 外部API通信、および状態（メモリキャッシュ、履歴リスト）の保存・取得を純粋に行う。
- **追加/修正ファイル**:
  - `jma_repository.py` (新規作成: JMAの `api.php` に対してPOSTリクエストを行い、過去の地震履歴（CSV/JSONデータ）をダウンロードしてパースする)
  - `history_repository.py` (新規作成: アプリケーション実行中の履歴データリストのインメモリ保持と、先頭への追記を行う)
  - `kmoni_cache_repository.py` (新規作成: K-moniのキャッシュ状態、最後にフェッチした時刻、地震モードの判定状態を保持する)

---

## 具体的な機能フロー

### A. 起動時のJMA履歴データダウンロード
1. `main.py` の lifespan イベント内で `history_service.initialize_history()` を呼び出す。
2. Serviceは `jma_repository.fetch_recent_earthquakes()` を呼び出し、JMAのAPIエンドポイント(`https://www.data.jma.go.jp/eqdb/data/shindo/api/api.php`)に直接POSTパラメータを送信してデータを取得する（スクレイピングは行わない）。
3. 取得した直近60件のデータを `history_repository` のインメモリリストに保存する。

### B. `/v1/history` の呼び出し
1. Route -> Handler -> `history_service.get_history()` を経由。
2. `history_repository` から現在の履歴リスト（最大60件）を取得し、指定のデモAPIフォーマットで返却する。

### C. K-moni キャッシュと履歴追加制御 (`/v1/eq/{timestamp}`)
1. `eq_service` は `kmoni_cache_repository` から現在の状態を取得する。
2. **通常時**: K-moniからデータ取得。結果にデータが含まれれば、「10分間の地震モード」へ移行する状態をリポジトリに保存。
3. **地震モード時**: 
   - 最終取得時刻から1分未満であれば、リポジトリに保存されているキャッシュデータを即座に返す（K-moniへはリクエストしない）。
   - 1分以上経過していれば、再度K-moniへ通信。
   - 同時に「地震検知から3分経過」しているかを判定し、まだ履歴に追加されていなければ `history_service.add_to_history()` を呼び出して履歴の先頭に速報値を追加する。

---

## 作業手順
1. 前回私が誤って `eq_handler.py` や `main.py` に直接書き込んでしまった実装を一旦ロールバック（クリーンアップ）します。
2. 本計画の内容に問題がないか、アーキテクチャの責務分割が適切かをご判断いただき、フィードバックをお願いいたします。
3. 承認をいただけた後に、各層のファイル作成およびJMA APIの詳細なダウンロード実装に着手いたします。
