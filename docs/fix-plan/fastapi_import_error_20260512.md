# FastAPIインポートエラー（api.src）修正計画書

## 概要
Raspberry Pi上で `fastapi dev` を実行した際、`api.src` に関連するインポートエラーが発生する問題を解決します。

## 背景
ユーザーが `api/main.py` を実行（または `fastapi dev` で起動）した際、`api.src` 関連のエラーが発生しました。
現在のディレクトリ構成では `api/` ディレクトリ内に `main.py` 和 `src/` ディレクトリがありますが、`__init__.py` が存在しないため、Pythonのパッケージとして正しく認識されていない可能性があります。また、`main.py` 内で `sys.path.append` を用いて親ディレクトリをパスに追加しているため、インポートパスの解釈に齟齬が生じていると考え替えられます。

## 原因の分析
1. **__init__.py の欠如**: `api/` および `api/src/` 以下に `__init__.py` がないため、環境によってはパッケージとして正しく認識されません。
2. **実行ディレクトリとインポートパスの不一致**:
   - `cd api && fastapi dev` で実行する場合、本来は `from src...` で動作するはずですが、`main.py` で親ディレクトリをパスに追加しているため、`from api.src...` という形式が期待される場合があります。
   - 逆に、`api.src` というエラーが出ている場合、Pythonが `api` をパッケージのルートとして認識しようとしていますが、設定が不完全です。

## 修正計画

### 1. パッケージの初期化ファイルの作成
以下の場所に空の `__init__.py` を作成し、ディレクトリをパッケージとして明示します。
- `api/__init__.py`
- `api/src/__init__.py`
- `api/src/routes/__init__.py`
- `api/src/routes/handler/__init__.py`
- `api/src/services/__init__.py`
- `api/src/repository/__init__.py`
- `api/src/schemas/__init__.py`

### 2. main.py のインポートパス修正
`api/main.py` 内のパス追加処理を整理し、カレントディレクトリからのインポートが優先されるようにします。

## 変更内容詳細

#### [NEW] `api/__init__.py` 他
- 各ディレクトリに空の `__init__.py` を作成。

#### [MODIFY] [main.py](file:///Users/eitanakgaichi/eq_rp/api/main.py)
- `sys.path.append` の処理を見直し。

## 検証計画
### 手動確認
1. 修正後、`cd api && fastapi dev` を実行し、エラーなく起動することを確認。
2. インポートエラーが解消され、APIの各エンドポイントが動作することを確認。
