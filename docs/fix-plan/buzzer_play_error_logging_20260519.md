# buzzer play error logging 修正計画書

## 現状
Raspberry Pi でブザー再生時に `Buzzer play error` が出ている。

現在の `api/main.py` は以下のように例外内容だけを出している。

```python
print(f"Buzzer play error: {e}")
```

この場合、例外メッセージが空のエラーでは原因が分からない。

## 考えられる原因
1. `TonalBuzzer` が指定ノートを受け付けていない。
2. GPIO17 が他プロセスまたは別の `TonalBuzzer` で使用中。
3. `gpiozero` の pin factory が Raspberry Pi 環境で初期化できていない。
4. `main.py` と `buzzer.py` の再生処理差分により、Thonny では鳴るが FastAPI では失敗している。

## 対策
1. `Buzzer play error` のログに例外クラス名を出す。
2. `Buzzer init error` と `Buzzer note error` を分ける。
3. どの note で失敗したかを出す。
4. `api/buzzer.py` の単体確認と同じ `TonalBuzzer(BUZZER_PIN)` + `play(note)` の流れを維持する。

## 修正予定ファイル
- `api/main.py`

## 確認方法
Raspberry Pi で `fastapi dev main_demo.py` を起動し、ブザー失敗時に以下のように原因が見えること。

```text
Buzzer init error: <ExceptionType>: <message>
Buzzer note error: note=<note>, error=<ExceptionType>: <message>
Buzzer play error: <ExceptionType>: <message>
```

そのログを元に次の修正を行う。
