# gpiozero pin factory error 修正計画書

## 現状
Raspberry Pi で `Unable to load any defalt pin factory` が発生している。

現在の `api/buzzer.py` は `gpiozero.TonalBuzzer` をそのまま import しており、pin factory を明示していない。
`api/main.py` 側のブザー処理も同様に `gpiozero` のデフォルト設定に依存している。

## 考えられる原因
1. Raspberry Pi 側の Python 環境に `gpiozero` の pin factory 用バックエンドが入っていない。
2. `gpiozero` が自動選択できる `lgpio` / `RPi.GPIO` / `pigpio` のいずれも見つけられていない。
3. 現在の実装は `TonalBuzzer` をそのまま使っているだけなので、環境差に弱い。

## 対策
1. `api/buzzer.py` で `gpiozero.Device.pin_factory` を明示的に設定する。
2. 利用可能な factory を順番に試す。
   - `LGPIOFactory`
   - `RPiGPIOFactory`
   - `NativeFactory`
3. `api/main.py` 側のブザー処理も `api/buzzer.py` と同じ初期化経路を使う。
4. どの factory を選んだかをログに出す。
5. どの factory でも失敗した場合は、例外クラス名とメッセージを出して停止する。
6. 必要なら `api/requirements.txt` に pin factory 用の依存を追加する。

## 修正予定ファイル
- `api/buzzer.py`
- `api/main.py`
- `api/requirements.txt`

## 確認方法
1. Raspberry Pi で `api/buzzer.py` を単体実行する。
2. `Unable to load any defalt pin factory` が出ず、選ばれた factory 名がログに出ることを確認する。
3. `fastapi dev main_demo.py` でも同じブザー初期化経路で鳴ることを確認する。

## 注意点
- まずは環境依存を吸収する修正を優先する。
- それでも鳴らない場合は、`gpiozero` ではなく `lgpio` / `RPi.GPIO` の導入状況を追加で確認する。
