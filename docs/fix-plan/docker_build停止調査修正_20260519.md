# docker_build.sh 停止調査・修正計画

## 1. 現象
`app/docker_build.sh` を実行してもビルドが進まない、または進捗が見えない状態になる。

## 2. 考えられる原因

### 毎回キャッシュを無効化している
`app/docker_build.sh` の `docker build --no-cache` により、Docker レイヤーキャッシュが毎回無効化されています。
そのため、`apt-get install`、Flutter SDK の `git clone`、`flutter precache --linux`、`flutter pub get` が毎回最初から実行され、特にネットワークが遅い場合は止まっているように見えます。

### Flutter SDK を毎回 GitHub から clone している
`app/Dockerfile` では `git clone --depth 1 --branch stable https://github.com/flutter/flutter.git ${FLUTTER_HOME}` を実行しています。
`--no-cache` と組み合わさると、この重い処理が毎回発生します。

### ビルドコンテキストが大きい
`app` 配下には `build/`、`build_output/`、`linux_app.zip`、`linux_build.zip` などの生成物があります。
`.dockerignore` がないため、これらが Docker ビルドコンテキストに含まれ、ビルド開始前の送信処理が重くなる可能性があります。

### Docker の進捗表示が分かりにくい
現在のスクリプトは通常の `docker build` 表示に任せています。
Docker Desktop や BuildKit の状態によっては、どこで詰まっているのか分かりづらくなります。

## 3. 対策

### キャッシュを使う
- 通常ビルドでは `--no-cache` を外し、Flutter SDK や apt のレイヤーを再利用できるようにします。
- キャッシュを無効化したい場合だけ環境変数で切り替えられるようにします。

### .dockerignore を追加する
- `build/`
- `build_output/`
- `linux_app.zip`
- `linux_build.zip`
- `.dart_tool/`
- `.idea/`
- `macos/Pods/` など、ビルドに不要な生成物やローカル設定を Docker コンテキストから除外します。

### 進捗を見やすくする
- `docker build --progress=plain` を使い、どのステップで止まっているか確認しやすくします。
- スクリプト上でキャッシュ有効・無効の状態を表示します。

## 4. 修正計画

### 対象ファイル
- `app/docker_build.sh`
- `app/.dockerignore`

### 実施内容
1. `app/docker_build.sh` から通常時の `--no-cache` を外す
2. `NO_CACHE=1 ./docker_build.sh` のように指定した場合だけ `--no-cache` を付ける
3. `--progress=plain` を追加し、ビルドログを追いやすくする
4. `app/.dockerignore` を追加して、不要な生成物を Docker コンテキストから除外する

## 5. 確認項目
- `app/docker_build.sh` の Docker build がステップ単位で進捗表示されること
- 2回目以降のビルドで Docker キャッシュが効くこと
- `build/` や zip ファイルが Docker コンテキストに含まれないこと
- 既存の成果物出力先 `app/build_output` と `app/linux_app.zip` が維持されること

> [!IMPORTANT]
> この計画に沿って、背景のビルド処理を速くし、止まっている箇所を見えるようにします。
