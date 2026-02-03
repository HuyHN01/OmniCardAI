// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeckNotifier)
const deckProvider = DeckNotifierProvider._();

final class DeckNotifierProvider
    extends $StreamNotifierProvider<DeckNotifier, List<DeckModel>> {
  const DeckNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckNotifierHash();

  @$internal
  @override
  DeckNotifier create() => DeckNotifier();
}

String _$deckNotifierHash() => r'4f4024065ac5db5bdf38272bb592144aa4c1a489';

abstract class _$DeckNotifier extends $StreamNotifier<List<DeckModel>> {
  Stream<List<DeckModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<DeckModel>>, List<DeckModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DeckModel>>, List<DeckModel>>,
              AsyncValue<List<DeckModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
