# main_demo import error 修正計画書

## 現状
`main_demo.py` 起動時に `No module named main` が発生している。

## 原因
`api/main_demo.py` は先頭で以下を実行している。

```python
from main import lcd_update_loop
```

しかし `fastapi dev api/main_demo.py` のようにプロジェクトルートから起動した場合、Python の import 解決に `api/` ディレクトリが入らず、同じディレクトリにある `api/main.py` を `main` として解決できない。

また、互換用に作ったはずの `api/mian_demo.py` が現在の作業ツリーに存在していないため、必要なら再作成する。

## 対策
1. `api/main_demo.py` の先頭で `api/main.py` と同じように `current_dir` と `parent_dir` を `sys.path` に追加する。
2. その後に `from main import lcd_update_loop` と `src.*` import を行う。
3. `api/mian_demo.py` が存在しない場合は、`from main_demo import app` だけの互換ラッパーとして作成する。
4. `docs/api/demo.md` に、`main_demo.py` と `mian_demo.py` の起動方法を明記する。

## 修正予定ファイル
- `api/main_demo.py`
- `api/mian_demo.py`
- `docs/api/demo.md`

## 確認方法
構文確認:

```bash
PYTHONPYCACHEPREFIX=/private/tmp/eq_rp_pycache python3 -m py_compile api/main_demo.py api/mian_demo.py
```

import 確認:

```bash
PYTHONPYCACHEPREFIX=/private/tmp/eq_rp_pycache python3 -c "import sys; sys.path.insert(0, 'api'); import main_demo; print(main_demo.app)"
```
