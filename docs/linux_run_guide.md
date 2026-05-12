# Linux アプリ実行手順書

Docker でビルドされた Linux 向け Flutter アプリケーション（ARM64）の実行方法について説明します。

## 構成
配布パッケージ（`linux_build.zip`）を展開すると、以下のファイルが含まれています。
- `app`: 実行バイナリ
- `data/`: アセットファイル（フォント、画像など）
- `lib/`: 共有ライブラリ（Flutter エンジンなど）

## 実行準備
1. **ファイルの展開**
   配布された `linux_app.zip` を Linux 環境で展開します。
   ```bash
   unzip linux_app.zip -d eq_app
   cd eq_app
   ```

2. **実行権限の付与**
   バイナリに実行権限を付与してください。
   ```bash
   chmod +x app
   ```

3. **必要なライブラリのインストール**
   Ubuntu 等の Debian 系 OS の場合、動作に以下のパッケージが必要な場合があります。
   ```bash
   sudo apt update
   sudo apt install libgtk-3-0 libblkid1 liblzma5
   ```

## 起動方法
ターミナルから以下のコマンドを実行します。
```bash
./app
```

## 注意事項
- **CPU アーキテクチャ**: このバイナリは **ARM64 (AArch64)** 用です。Raspberry Pi や ARM ベースのクラウドサーバー、Apple Silicon Mac 上の Linux 仮想マシン等で動作します。
- **GUI 環境**: このアプリはデスクトップアプリ（GTK）であるため、X11 または Wayland が動作している GUI 環境が必要です。

```
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

sudo rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

```