# リストタップ → マップ移動・着色・ピン表示 実装計画

## 概要
リストの地震項目をタップしたら、マップがその震源地にフォーカスし、震度に応じた色をつけ、lat/lonの位置にピンを打つ。

## 変更対象

### 1. `view_model.dart`
- `HomeScreenState` に `Earthquake? selectedEarthquake` フィールドを追加
- `selectEarthquake(Earthquake eq)` メソッドを追加

### 2. `widget/list.dart`
- `onTap` コールバック（`ValueChanged<Earthquake>`）と `selectedId`（`String?`）を受け取れるようにする
- タップ時にコールバックを呼び、選択中のアイテムはハイライト表示

### 3. `screen.dart`
- 選択中の地震があればそのlat/lonでマップをセンタリング（`LatLng` は japan_maps のものを流用）
- 選択中の地震の震度でprefectureの色を構築
- マップの中心（＝震源地）にピンアイコンをオーバーレイ表示
