// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Eq)
final eqProvider = EqProvider._();

final class EqProvider extends $NotifierProvider<Eq, EarthquakeResponse?> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeResponse? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeResponse?>(value),
    );
  }
}

String _$eqHash() => r'4d6cf52a9078cad2578fc333b31e73c3c5633820';

abstract class _$Eq extends $Notifier<EarthquakeResponse?> {
  EarthquakeResponse? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EarthquakeResponse?, EarthquakeResponse?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EarthquakeResponse?, EarthquakeResponse?>,
              EarthquakeResponse?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
