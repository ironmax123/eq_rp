// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ホーム画面のViewModel

@ProviderFor(HomeScreenViewModel)
final homeScreenViewModelProvider = HomeScreenViewModelProvider._();

/// ホーム画面のViewModel
final class HomeScreenViewModelProvider
    extends $NotifierProvider<HomeScreenViewModel, HomeScreenState> {
  /// ホーム画面のViewModel
  HomeScreenViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeScreenViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeScreenViewModelHash();

  @$internal
  @override
  HomeScreenViewModel create() => HomeScreenViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeScreenState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeScreenState>(value),
    );
  }
}

String _$homeScreenViewModelHash() =>
    r'c1d2374cc9f82c3284b27e7ea179e9ade3e0c486';

/// ホーム画面のViewModel

abstract class _$HomeScreenViewModel extends $Notifier<HomeScreenState> {
  HomeScreenState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HomeScreenState, HomeScreenState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeScreenState, HomeScreenState>,
              HomeScreenState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
