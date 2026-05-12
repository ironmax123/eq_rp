# Flutter日本語文字化け修正計画書

## 概要
Flutterアプリ内でAPIから取得した地震情報（日本語）が文字化けして表示される問題の修正計画です。

## 背景と原因の分析
ユーザーからの指摘を受けFlutterのコードを確認したところ、APIからデータを取得する処理（`provider.dart`）において、HTTPレスポンスのデコード方法に問題があることが判明しました。

Dartの `http` パッケージにおいて、`response.body` を呼び出すと、レスポンスヘッダに `charset=utf-8` が明示されていない限り、デフォルトで **ISO-8859-1 (Latin-1)** としてデコードされます。
FastAPIのデフォルトのJSONレスポンスは `application/json` （charsetなし）を返すため、UTF-8の日本語文字列がLatin-1として誤ってデコードされ、文字化け（いわゆる「文字化け（Mojibake）」）が発生していました。システムフォントの不足が原因ではありませんでした。

## 修正計画

APIレスポンスのバイトデータを明示的にUTF-8でデコードしてからJSONパースするように修正します。

### 変更ファイル

#### [MODIFY] [app/lib/provider/eq/provider.dart](file:///Users/eitanakgaichi/eq_rp/app/lib/provider/eq/provider.dart)
```diff
- final json = jsonDecode(response.body);
+ final json = jsonDecode(utf8.decode(response.bodyBytes));
```

#### [MODIFY] [app/lib/provider/history/provider.dart](file:///Users/eitanakgaichi/eq_rp/app/lib/provider/history/provider.dart)
```diff
- final json = jsonDecode(response.body);
+ final json = jsonDecode(utf8.decode(response.bodyBytes));
```

## 検証計画
- 上記コード修正後、再度Flutterアプリを実行し、日本語が正しく表示されることを確認します。
