import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/earthquake.dart';
import '../../provider/eq/provider.dart';
import '../../provider/history/provider.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

/// ホーム画面の状態
@freezed
abstract class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    /// 地震データ（未取得はnull）
    EarthquakeResponse? earthquakeResponse,

    /// 選択中の都道府県コード（未選択はnull）
    String? selectedPrefecture,

    /// エラーメッセージ
    String? errorMessage,
  }) = _HomeScreenState;
}

/// ホーム画面のViewModel
@riverpod
class HomeScreenViewModel extends _$HomeScreenViewModel {
  @override
  HomeScreenState build() {
    final historyAsync = ref.watch(historyEqProvider);
    final realtimeData = ref.watch(eqProvider);

    return historyAsync.when(
      data: (history) {
        if (realtimeData != null && realtimeData.earthquakes.isNotEmpty) {
          final rtEq = realtimeData.earthquakes.first;
          final filteredHistory = history.earthquakes.where((e) => e.id != rtEq.id).toList();
          final mergedData = EarthquakeResponse(earthquakes: [rtEq, ...filteredHistory]);
          return HomeScreenState(earthquakeResponse: mergedData);
        }
        return HomeScreenState(earthquakeResponse: history);
      },
      loading: () => const HomeScreenState(),
      error: (e, _) => HomeScreenState(errorMessage: e.toString()),
    );
  }

  /// 都道府県タップ時に選択状態を更新
  void selectPrefecture(String prefKey) {
    state = state.copyWith(selectedPrefecture: prefKey);
  }

  /// 選択解除
  void clearSelection() {
    state = state.copyWith(selectedPrefecture: null);
  }
}
