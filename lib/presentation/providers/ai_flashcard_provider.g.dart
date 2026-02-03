// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_flashcard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AiFlashcard)
const aiFlashcardProvider = AiFlashcardProvider._();

final class AiFlashcardProvider
    extends $NotifierProvider<AiFlashcard, AiFlashcardState> {
  const AiFlashcardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiFlashcardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiFlashcardHash();

  @$internal
  @override
  AiFlashcard create() => AiFlashcard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiFlashcardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiFlashcardState>(value),
    );
  }
}

String _$aiFlashcardHash() => r'aa01470517ab5dfb556a7e426384b361b7cc7b20';

abstract class _$AiFlashcard extends $Notifier<AiFlashcardState> {
  AiFlashcardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AiFlashcardState, AiFlashcardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AiFlashcardState, AiFlashcardState>,
              AiFlashcardState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
