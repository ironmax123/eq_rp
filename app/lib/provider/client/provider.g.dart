// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApiClient)
final apiClientProvider = ApiClientFamily._();

final class ApiClientProvider extends $NotifierProvider<ApiClient, void> {
  ApiClientProvider._({
    required ApiClientFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'apiClientProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @override
  String toString() {
    return r'apiClientProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ApiClient create() => ApiClient();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ApiClientProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$apiClientHash() => r'a737c05192f3a6457c10b620734cde16ccf3e637';

final class ApiClientFamily extends $Family
    with $ClassFamilyOverride<ApiClient, void, void, void, String> {
  ApiClientFamily._()
    : super(
        retry: null,
        name: r'apiClientProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ApiClientProvider call(String url) =>
      ApiClientProvider._(argument: url, from: this);

  @override
  String toString() => r'apiClientProvider';
}

abstract class _$ApiClient extends $Notifier<void> {
  late final _$args = ref.$arg as String;
  String get url => _$args;

  void build(String url);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
