# 地震発生日時のフォーマット修正計画

## 発生している問題（バグの内容）
地震リストに表示される発生日時が `yyyy/mm/dd hh:mm` 形式になっておらず、`20260511130851` のような数字の羅列になっている。

## 考えられる原因
強震モニタ API から取得される発生日時（`origin_time`）の形式が `yyyyMMddHHmmss` であり、現在のフロントエンド実装で使用している `DateTime.parse()` がこの形式を直接解釈できないため、パースに失敗して元の文字列がそのまま返されています。

```dart
// app/lib/ui/home/widget/list.dart 30行目付近
String _formatTime(String isoString) {
  try {
    final dt = DateTime.parse(isoString).toLocal(); // ここで失敗
    // ...
  } catch (e) {
    return isoString; // 失敗したのでそのまま返す
  }
}
```

## 修正計画

フロントエンドの時刻フォーマット関数を、`yyyyMMddHHmmss` 形式にも対応するように拡張します。

### 変更内容
`app/lib/ui/home/widget/list.dart` の `_formatTime` 関数を以下のように修正します。

```dart
String _formatTime(String timeString) {
  // yyyyMMddHHmmss 形式 (14文字) の場合の処理を追加
  if (timeString.length == 14 && int.tryParse(timeString) != null) {
    final y = timeString.substring(0, 4);
    final m = timeString.substring(4, 6);
    final d = timeString.substring(6, 8);
    final h = timeString.substring(8, 10);
    final min = timeString.substring(10, 12);
    return '$y/$m/$d $h:$min';
  }

  // 従来の ISO 8601 形式等の場合の処理
  try {
    final dt = DateTime.parse(timeString).toLocal();
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$y/$m/$d $h:$min';
  } catch (e) {
    return timeString;
  }
}
```

## 変更対象のファイル
#### [MODIFY] `app/lib/ui/home/widget/list.dart`

## 確認事項
この修正方針でよろしいでしょうか？許可をいただければ修正を開始します。
