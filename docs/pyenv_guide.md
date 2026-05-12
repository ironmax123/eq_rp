# pyenv 実行方法ガイド

本ドキュメントでは、本プロジェクトの開発環境（macOS および Raspberry Pi OS）で推奨される Python バージョン管理ツール `pyenv` の利用方法について解説します。

---

## 1. インストール手順

利用する OS に合わせて、以下の手順を実行してください。

### macOS (Homebrew)

```bash
brew update
brew install pyenv
```

### Linux (Raspberry Pi OS / Debian系)

1. **ビルドに必要な依存パッケージのインストール**
   Linux では Python をソースからビルドするため、以下のパッケージが必要です。
   ```bash
   sudo apt update
   sudo apt install -y build-essential libssl-dev zlib1g-dev \
   libbz2-dev libreadline-dev libsqlite3-dev curl git \
   libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
   ```

2. **pyenv 本体のインストール**
   自動インストーラーを使用します。
   ```bash
   curl https://pyenv.run | bash
   ```

---

## 2. シェルの設定

`pyenv` を有効にするため、設定ファイルに以下の内容を追記します。

### macOS (zsh) の場合
`~/.zshrc` に追記：
```bash
# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```
反映： `source ~/.zshrc`

### Linux / Raspberry Pi OS (bash) の場合
`~/.bashrc` に追記：
```bash
# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```
反映： `source ~/.bashrc`

---

## 3. 基本的なコマンド (共通)

### 利用可能なバージョンを確認する
```bash
pyenv install --list
```

### 特定のバージョンをインストールする
本プロジェクト（`api` ディレクトリ）では **3.11.10** を使用しています。
```bash
pyenv install 3.11.10
```

### インストール済みのバージョンを確認する
```bash
pyenv versions
```

### バージョンを切り替える
- **システム全体 (Global)**
  ```bash
  pyenv global 3.11.10
  ```
- **ディレクトリ単位 (Local)**
  ```bash
  pyenv local 3.11.10
  ```

---

## 4. 本プロジェクトでの利用

本プロジェクトの `api` ディレクトリには `.python-version` ファイルが配置されています。

```text
api/
  └── .python-version (内容: 3.11.10)
```

`pyenv` が正しく設定されていれば、`api` ディレクトリに移動するだけで自動的に Python 3.11.10 が使用されます。

### 確認方法
```bash
cd api
python --version
# 出力: Python 3.11.10
```

もし切り替わらない場合は、`which python` を実行してパスが `~/.pyenv/shims/python` を指しているか確認してください。
