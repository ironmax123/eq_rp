# App側: historyおよびリアルタイム機能対応 実装計画 (v4: 責務分離・プロバイダー新設)

## 概要と修正点
履歴データ（history）とリアルタイムデータ（eq）は責務が全く異なるため、1つのプロバイダーにまとめるのは設計上不適切であるというご指摘の通りです。
履歴取得用の新しいプロバイダーを新設し、既存の `eqProvider` はリアルタイム速報の定期取得（Timerによるシンプル実装）専用として責務を完全に分離します。その上でViewModel側でこれらを統合します。

## 変更対象ファイルと作業内容

### 1. `app/lib/provider/history/provider.dart` (新規作成)
- **`HistoryEq` クラス (`@riverpod`)**
  - 起動時に1回だけ `/v1/history` をフェッチし、過去の地震履歴（`EarthquakeResponse`）を返します。

### 2. `app/lib/provider/eq/provider.dart` (既存ファイルの改修)
- **`Eq` クラス (`@riverpod`)**
  - リアルタイムデータの取得専用とします。
  - `build()` では `Timer.periodic` を用いて数秒（2秒など）ごとにポーリングを開始し、初期値は `null` を返します。
  - タイマー処理内で `/v1/eq/{yyyyMMddHHmmss}` をフェッチし、速報（新規データ）を受信した場合のみ `state = 新しいデータ` として更新します。

### 3. `app/lib/ui/home/view_model.dart`
- `HomeScreenViewModel` の `build()` 内で上記2つのプロバイダーを `ref.watch` します。
- **データ統合ロジック**:
  - `historyProvider` からのデータ（AsyncValue）を基本のリストとして扱います。
  - `eqProvider`（リアルタイム）にデータが存在する場合は、その速報データを履歴データの先頭にマージして `HomeScreenState` にセットします。
  - これにより、UIの既存ウィジェット（`EqListWidget` や `JapanColorMapsWidget`）には一切手を加えることなく、最新の地震情報がマップおよびリストに反映されます。

---

**ユーザー様へ:**
私の設計に対する見通しが甘く、責務を混ぜ込むような愚かな提案を何度もしてしまい、本当に申し訳ありませんでした。ご指摘の通り、履歴用のプロバイダーを新設して責務を分けるのが真っ当な設計です。
この設計方針（v4）にて実装を進めてもよろしいでしょうか？
