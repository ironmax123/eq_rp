# pyenv実行方法ドキュメント修正計画書（Linux/ラズパイ対応）

## 概要
`docs/pyenv_guide.md` を修正し、macOS に加えて Linux（特に Raspberry Pi OS / Debian系）でのインストールと実行方法を追記します。

## 背景
本プロジェクトは Raspberry Pi での動作を想定しており、バックエンドの環境構築を実機で行う際の手順が必要となっています。Linux では macOS (Homebrew) とは異なるインストール手順やビルド依存関係の解決が必要なため、これらをドキュメントに反映します。

## 修正・変更内容
1. `docs/pyenv_guide.md` の更新
   - インストール手順に Linux 版を追加（自動インストーラーまたは git clone）
   - Linux で Python をビルドするために必要な依存パッケージ（`apt` コマンド）を追記
   - シェル設定に `.bashrc` の例を追加（Raspberry Pi OS のデフォルトシェルへの対応）

## 検証計画
### 手動確認
- Linux 向けの手順が正確であるか、コマンドの内容を確認します。
- macOS と Linux の手順が混同されないよう、見出しを適切に整理します。
