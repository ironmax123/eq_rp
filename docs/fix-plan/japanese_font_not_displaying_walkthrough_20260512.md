# ラズパイでの日本語文字化け修正完了

## 実施内容
Raspberry Pi環境でFlutterアプリの日本語が文字化けする問題（豆腐表示）を解決するため、システムへの日本語フォントのインストールを推奨する手順をドキュメントに追加しました。

### ドキュメントの修正
`docs/linux_run_guide.md` の「必要なライブラリのインストール」セクションにおいて、`apt install` コマンドのインストール対象に `fonts-noto-cjk` パッケージを追加し、日本語を正しく表示するために必要な旨を追記しました。

```diff
- sudo apt install libgtk-3-0 libblkid1 liblzma5
+ sudo apt install libgtk-3-0 libblkid1 liblzma5 fonts-noto-cjk
```

## 検証結果・次のステップ
ドキュメントの修正が完了しました。
Raspberry Piのターミナルにて、以下のコマンドを実行し、フォントをインストールしてください。

```bash
sudo apt update
sudo apt install fonts-noto-cjk
```

インストールが完了したら、Flutterアプリ（`./app`）を再起動していただき、日本語のテキストが正しく表示されることを確認してください。
