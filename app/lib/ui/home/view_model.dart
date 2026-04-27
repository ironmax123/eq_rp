import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/earthquake.dart';
import '../../provider/eq/provider.dart';

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
    // eqProviderをwatchし、データが来たら状態を更新
    final eqAsync = ref.watch(eqProvider);

    return eqAsync.when(
      data: (data) => HomeScreenState(earthquakeResponse: data),
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
