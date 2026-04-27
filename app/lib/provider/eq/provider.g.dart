// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Eq)
final eqProvider = EqProvider._();

final class EqProvider extends $AsyncNotifierProvider<Eq, EarthquakeResponse> {
  EqProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqHash();

  @$internal
  @override
  Eq create() => Eq();
}

String _$eqHash() => r'9bf935ed8f593ee3a80c5b4fe56b70c1e65ad53d';

abstract class _$Eq extends $AsyncNotifier<EarthquakeResponse> {
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
