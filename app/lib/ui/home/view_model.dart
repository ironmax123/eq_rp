import 'dart:async';

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

    /// 選択中の地震データ（リストタップ時）
    Earthquake? selectedEarthquake,

    /// 選択中の都道府県コード（未選択はnull）
    String? selectedPrefecture,

    /// エラーメッセージ
    String? errorMessage,
  }) = _HomeScreenState;
}

/// ホーム画面のViewModel
@riverpod
class HomeScreenViewModel extends _$HomeScreenViewModel {
  static const _autoPinDuration = Duration(minutes: 3);

  Timer? _autoClearTimer;
  Earthquake? _selectedEarthquake;
  String? _selectedPrefecture;
  String? _autoSelectedEarthquakeId;

  @override
  HomeScreenState build() {
    ref.onDispose(() {
      _autoClearTimer?.cancel();
    });

    final historyAsync = ref.watch(historyEqProvider);
    final realtimeData = ref.watch(eqProvider);

    return historyAsync.when(
      data: (history) {
        if (realtimeData != null && realtimeData.earthquakes.isNotEmpty) {
          final rtEq = realtimeData.earthquakes.first;
          _showRealtimePin(rtEq);

          final filteredHistory = history.earthquakes
              .where((e) => e.id != rtEq.id)
              .toList();
          final mergedData = EarthquakeResponse(
            earthquakes: [rtEq, ...filteredHistory],
          );
          return HomeScreenState(
            earthquakeResponse: mergedData,
            selectedEarthquake: _selectedEarthquake,
            selectedPrefecture: _selectedPrefecture,
          );
        }
        return HomeScreenState(
          earthquakeResponse: history,
          selectedEarthquake: _selectedEarthquake,
          selectedPrefecture: _selectedPrefecture,
        );
      },
      loading: () => const HomeScreenState(),
      error: (e, _) => HomeScreenState(errorMessage: e.toString()),
    );
  }

  /// リストの地震項目タップ時
  void selectEarthquake(Earthquake eq) {
    _autoClearTimer?.cancel();
    _autoSelectedEarthquakeId = null;
    _selectedEarthquake = eq;
    _selectedPrefecture = null;
    state = state.copyWith(
      selectedEarthquake: _selectedEarthquake,
      selectedPrefecture: _selectedPrefecture,
    );
  }

  /// 都道府県タップ時に選択状態を更新
  void selectPrefecture(String prefKey) {
    _selectedPrefecture = prefKey;
    state = state.copyWith(selectedPrefecture: _selectedPrefecture);
  }

  /// 選択解除
  void clearSelection() {
    _autoClearTimer?.cancel();
    _autoSelectedEarthquakeId = null;
    _selectedPrefecture = null;
    _selectedEarthquake = null;
    state = state.copyWith(
      selectedPrefecture: _selectedPrefecture,
      selectedEarthquake: _selectedEarthquake,
    );
  }

  void _showRealtimePin(Earthquake earthquake) {
    if (_autoSelectedEarthquakeId == earthquake.id) {
      return;
    }

    _autoClearTimer?.cancel();
    _autoSelectedEarthquakeId = earthquake.id;
    _selectedEarthquake = earthquake;
    _selectedPrefecture = null;

    _autoClearTimer = Timer(_autoPinDuration, () {
      if (_autoSelectedEarthquakeId != earthquake.id) {
        return;
      }

      _autoSelectedEarthquakeId = null;
      _selectedPrefecture = null;
      _selectedEarthquake = null;
      state = state.copyWith(
        selectedPrefecture: _selectedPrefecture,
        selectedEarthquake: _selectedEarthquake,
      );
    });
  }
}
