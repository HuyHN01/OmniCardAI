// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BatchCardNotifier)
const batchCardProvider = BatchCardNotifierProvider._();

final class BatchCardNotifierProvider
    extends $NotifierProvider<BatchCardNotifier, void> {
  const BatchCardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'batchCardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$batchCardNotifierHash();

  @$internal
  @override
  BatchCardNotifier create() => BatchCardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$batchCardNotifierHash() => r'970fc9559c1b7d645a47485a5cc86c507689f11c';

abstract class _$BatchCardNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
