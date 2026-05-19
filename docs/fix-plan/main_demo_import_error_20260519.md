# main_demo import error 修正計画書

## 現状
`main_demo.py` 起動時に `No module named main` が発生している。

Mac では `fastapi dev main_demo.py` で起動できるが、Raspberry Pi では動かない。

## 原因
`api/main_demo.py` は先頭で以下を実行している。

```python
from main import lcd_update_loop
```

しかし `fastapi dev api/main_demo.py` のようにプロジェクトルートから起動した場合や、`fastapi` の実行環境差分により、Python の import 解決に `api/` ディレクトリが入らず、同じディレクトリにある `api/main.py` を `main` として解決できない。

`mian_demo.py` は `main_demo.py` のタイポなので、互換ファイルは作成しない。

追加で、`api/main_demo.py` が `from main import lcd_update_loop` に依存しているため、起動方法によっては `main.py` のトップレベル副作用や import 解決に引きずられる。

## 対策
1. `api/main_demo.py` の先頭で `api/main.py` と同じように `current_dir` と `parent_dir` を `sys.path` に追加する。
2. `lcd_update_loop` は package import 時に `from .main import lcd_update_loop`、直下起動時に `from main import lcd_update_loop` で読み込む。
3. `api/mian_demo.py` は作成しない。
4. `docs/api/demo.md` から `mian_demo.py` の記載を削除する。
5. Raspberry Pi 側でまだ動かない場合は、実際のエラー全文を元に追加修正する。

## 修正予定ファイル
- `api/main_demo.py`
- `docs/api/demo.md`

## 確認方法
構文確認:

```bash
PYTHONPYCACHEPREFIX=/private/tmp/eq_rp_pycache python3 -m py_compile api/main_demo.py
```

import 確認:

```bash
PYTHONPYCACHEPREFIX=/private/tmp/eq_rp_pycache python3 -c "import sys; sys.path.insert(0, 'api'); import main_demo; print(main_demo.app)"
```
