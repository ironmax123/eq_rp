# UIの色違いとDockerビルドエラーの修正計画

## 1. 考えられる原因

### 震度アイコンの色が違う問題
`app/lib/ui/home/widget/list.dart` にて、`_intensityColor` というメソッドが独自に定義され、ハードコードされた色が使われています。本来プロジェクトで共通利用するべき気象庁基準の色定義クラス（`IntensityColor` / `app/lib/util/intensity_color.dart`）が使われていないため、ここだけ色が異なってしまっています。

### Dockerビルドエラー
ビルドログの `Error: Failed to find any of [llvm-ar, ar] in LocalDirectory: '/usr/lib/llvm-14/bin'` より、Linux用ビルド時のコンパイルプロセス（dart_build）において、必要なLLVMのアーカイブツール (`llvm-ar`) が見つかっていないことが原因です。`Dockerfile` のパッケージインストールにおいて `clang` などは指定されていますが、`llvm` パッケージ自体が不足しているために発生しています。

## 2. 対策と修正計画

### list.dart の修正
1. `app/lib/ui/home/widget/list.dart` を修正します。
2. 独自実装されている `_intensityColor` メソッド（5行目〜28行目）を削除します。
3. `app/lib/util/intensity_color.dart` の `IntensityColor` クラスをインポートし、色を決定している部分を `IntensityColor.fromIntensity(eq.maxIntensity)` に置き換えます。

### Dockerfile の修正
1. `app/Dockerfile` を修正します。
2. `apt-get install` のパッケージリストに `llvm` を追加し、ビルドに必要な `llvm-ar` 等のツールチェーンがインストールされるようにします。

---

以上の修正で、リストUIの背景色がプロジェクト標準の気象庁基準色に統一され、Dockerでのリリースビルドも正常に通るようになります。
