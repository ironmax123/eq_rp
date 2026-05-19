# demo buzzer not triggered 修正計画書

## 現状
`api/main_demo.py` では、起動10秒後に EEW リポジトリをデモ用へ差し替えている。

しかしブザーは鳴らない。

## 原因
現在の実装は、10秒後に以下だけを行っている。

```python
eq_service_module.eq_repository = demo_eq_repository
```

これは「次回 `eq_service()` が呼ばれたときにデモデータを返すようにする」だけであり、その時点では地震データの取得処理は走らない。

ブザーは `main.py` の `lcd_update_loop()` 内で `get_cache_state().is_eq_mode` が `True` になった瞬間に鳴る。

つまり、10秒後にリポジトリを差し替えても、`/v1/eq/{timestamp}` が呼ばれて `eq_service()` が実行されるまで `is_eq_mode` は `False` のままになる。

そのため、画面やクライアントが `/v1/eq/{timestamp}` を叩いていない場合、地震モードへ入らずブザーも鳴らない。

## 対策
10秒後に EEW リポジトリをデモ用へ差し替えた直後、既存の `eq_service()` を1回だけ呼び出す。

これにより:

1. デモリポジトリから東京湾の地震データを取得する。
2. 既存の `eq_service()` の通常処理により `is_eq_mode = True` になる。
3. 既存のキャッシュ戦略、地震モード、10分継続、1分キャッシュ、3分後履歴追加ロジックはそのまま使われる。
4. `lcd_update_loop()` が `is_eq_mode` の変化を検知し、既存のブザー処理が鳴る。

## 修正予定ファイル
- `api/main_demo.py`
- `docs/api/demo.md`

## 修正内容
`switch_to_demo_repository()` の最後で、デモ切替後に以下を実行する。

```python
eq_service_module.eq_service(DEMO_TRIGGER_TIMESTAMP)
```

`DEMO_TRIGGER_TIMESTAMP` は既存APIの引数形式に合わせた整数値として定義する。

## 確認方法
1. Raspberry Pi で `cd api`
2. `fastapi dev main_demo.py`
3. 起動後10秒待つ
4. `/v1/eq/{timestamp}` を手動で叩かなくても、地震モードへ入りブザーが鳴ることを確認する
5. その後の `/v1/eq/{timestamp}` は既存キャッシュ戦略に従ってデモ地震を返すことを確認する
