// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryEq)
final historyEqProvider = HistoryEqProvider._();

final class HistoryEqProvider
    extends $AsyncNotifierProvider<HistoryEq, EarthquakeResponse> {
  HistoryEqProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyEqProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyEqHash();

  @$internal
  @override
  HistoryEq create() => HistoryEq();
}

String _$historyEqHash() => r'ef7b562af9bd7fc7b310584e3b3568724cea4044';

abstract class _$HistoryEq extends $AsyncNotifier<EarthquakeResponse> {
  FutureOr<EarthquakeResponse> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<EarthquakeResponse>, EarthquakeResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EarthquakeResponse>, EarthquakeResponse>,
              AsyncValue<EarthquakeResponse>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
