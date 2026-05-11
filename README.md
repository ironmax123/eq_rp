# eq_rp (Earthquake Raspberry Pi)

## プロジェクト概要
本プロジェクトは、地震情報をリアルタイムに取得し表示するためのRaspberry Pi（ラズパイ）向けアプリケーションです。
バックエンドにFastAPI、フロントエンドにFlutterを採用しています。

- **バックエンド (`/api`)**: Python/FastAPIを利用して構築されています。国立研究開発法人防災科学技術研究所（NIED）の強震モニタ（Kmoni）APIから地震情報を取得します。APIへのリクエスト負荷を軽減するため、地震発生時は自動的に「地震モード（10分間）」に移行し、適切なキャッシュ制御を行いつつ最新データをクライアントに提供します。ローカル起動のみを想定しています。
- **フロントエンド (`/app`)**: Flutterを利用して構築されています。バックエンドから取得した地震情報（EEW等）を日本地図上にマッピングし、視覚的に分かりやすく表示します。状態管理にはRiverpodを使用しています。

## データソース
本アプリケーションは、以下の外部データソースを利用して地震情報を取得しています。

- **強震モニタ (Kyoshin Monitor)**
  - **提供元**: [国立研究開発法人 防災科学技術研究所 (NIED)](https://www.bosai.go.jp/)
  - **API Endpoint (EEW)**: `http://www.kmoni.bosai.go.jp/webservice/hypo/eew/`
  - **概要**: 日本全国の強震観測網（K-NET, KiK-net）のデータをリアルタイムに提供するサービスです。本プロジェクトでは緊急地震速報（EEW）の情報を取得し、各都道府県の震度などの表示に活用しています。

- **気象庁 防災情報JSON / 履歴用CSV**
  - **提供元**: [気象庁 (JMA)](https://www.jma.go.jp/)
  - **API Endpoint**: `https://www.jma.go.jp/bosai/quake/data/list.json`
  - **フォールバック**: `api/data/hist.csv` (ローカル保存の履歴CSV)
  - **概要**: 過去の地震履歴（History）の初期データを取得するために気象庁のAPIを利用しています。API通信に失敗した場合は、フォールバックとしてローカルに保存されている `hist.csv` を読み込んで履歴データを構築します。

## 主要な利用パッケージ (OSS / pub.dev)

Flutterアプリケーション(`/app`)では、以下の主要なパッケージを利用しています。

### 状態管理・アーキテクチャ
- **[riverpod_annotation](https://pub.dev/packages/riverpod_annotation) / [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)**
  - 予測可能で安全な状態管理と依存性の注入（DI）のために利用。
- **[flutter_hooks](https://pub.dev/packages/flutter_hooks)**
  - ウィジェットのライフサイクルやローカルな状態（コントローラーなど）を簡潔に管理するために利用。

### モデル生成・シリアライズ
- **[freezed_annotation](https://pub.dev/packages/freezed_annotation) / [freezed](https://pub.dev/packages/freezed)**
  - イミュータブルなデータクラスの自動生成と、パターンマッチング等の機能拡張のために利用。
- **[json_annotation](https://pub.dev/packages/json_annotation) / [json_serializable](https://pub.dev/packages/json_serializable)**
  - APIから取得するJSONデータのシリアライズ・デシリアライズ処理の自動生成に利用。

### 通信関連
- **[http](https://pub.dev/packages/http)**
  - FastAPIバックエンドとのHTTP通信に利用。
- **[web_socket_channel](https://pub.dev/packages/web_socket_channel)**
  - リアルタイムでのデータストリーミング（WebSocket通信）に利用。

### ルーティング・UI
- **[go_router](https://pub.dev/packages/go_router)**
  - アプリ内の画面遷移を宣言的に定義・管理するために利用。
- **[japan_maps](https://pub.dev/packages/japan_maps)**
  - 取得した地震情報に基づいて、日本地図上の都道府県ごとに色分け表示（震度別の可視化など）を行うために利用。
- **[cupertino_icons](https://pub.dev/packages/cupertino_icons)**
  - アプリ内でiOSスタイルのアイコンを利用するために組み込み。

## 起動方法

### バックエンド (FastAPI)
```bash
cd api
fastapi dev
```
> **Note:** プロジェクトルールに従い、FastAPIはローカル起動のみを想定しています。

### フロントエンド (Flutter)
```bash
cd app
flutter pub get
flutter run
```
