# LCD fastapi dev表示不具合 修正計画書

## 現状
`example-code/1_output/1.7_Lcd1602_zero.py` は Thonny で LCD1602 に表示できる一方、FastAPI を `fastapi dev` で起動した場合に `api/main.py` から LCD 表示されない。

また、起動ログに LCD 関連の `print` が何も出ていないため、現在の実装では LCD 処理がどこまで到達しているか判断できない。

## 考えられる原因
1. `LCD1602` の import に失敗しているが、`except ImportError` で握りつぶしている。
2. FastAPI の `lifespan` は動いているが、LCD バックグラウンドタスクが無言で return している。
3. `LCD1602.init(0x27, 1)` が例外ではなく `False` を返して失敗しているが、戻り値を確認していない。
4. LCD 書き込み時の例外は出力されるが、初期化前の状態ログが不足している。

## 対策
`api/main.py` に以下の最小修正を行う。

1. `LCD1602` import 失敗時に例外内容を出力する。
2. `lifespan` 開始時にログを出力する。
3. `lcd_update_loop()` 開始時にログを出力する。
4. `LCD1602` が利用できない場合も無言 return せずログを出力する。
5. `LCD1602.init(0x27, 1)` の戻り値を確認し、`False` の場合は失敗としてログを出して終了する。
6. LCD 初期化成功時にもログを出す。

## 修正範囲
- `api/main.py`

## 確認方法
Raspberry Pi 側で `fastapi dev` を起動し、標準出力に以下のいずれかが出ることを確認する。

- `FastAPI lifespan started.`
- `LCD update loop started.`
- `LCD1602 import failed: ...`
- `LCD1602 module is not available. LCD update skipped.`
- `LCD Init Error: ...`
- `LCD1602 init returned False. LCD update stopped.`
- `LCD1602 initialized successfully.`
