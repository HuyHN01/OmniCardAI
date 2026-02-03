// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ttsService)
const ttsServiceProvider = TtsServiceProvider._();

final class TtsServiceProvider
    extends
        $FunctionalProvider<
          UnifiedTtsService,
          UnifiedTtsService,
          UnifiedTtsService
        >
    with $Provider<UnifiedTtsService> {
  const TtsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ttsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ttsServiceHash();

  @$internal
  @override
  $ProviderElement<UnifiedTtsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UnifiedTtsService create(Ref ref) {
    return ttsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnifiedTtsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnifiedTtsService>(value),
    );
  }
}

String _$ttsServiceHash() => r'f9b1b61c60d41aae431542b43c481d29a75e5baf';
