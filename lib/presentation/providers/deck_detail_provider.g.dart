// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deckDetail)
const deckDetailProvider = DeckDetailFamily._();

final class DeckDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeckModel?>,
          DeckModel?,
          Stream<DeckModel?>
        >
    with $FutureModifier<DeckModel?>, $StreamProvider<DeckModel?> {
  const DeckDetailProvider._({
    required DeckDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'deckDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deckDetailHash();

  @override
  String toString() {
    return r'deckDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<DeckModel?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DeckModel?> create(Ref ref) {
    final argument = this.argument as int;
    return deckDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deckDetailHash() => r'0cda4c54b3c0de899b71d347ae685ce4144244a5';

final class DeckDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DeckModel?>, int> {
  const DeckDetailFamily._()
    : super(
        retry: null,
        name: r'deckDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeckDetailProvider call(int deckId) =>
      DeckDetailProvider._(argument: deckId, from: this);

  @override
  String toString() => r'deckDetailProvider';
}

@ProviderFor(deckCards)
const deckCardsProvider = DeckCardsFamily._();

final class DeckCardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CardModel>>,
          List<CardModel>,
          Stream<List<CardModel>>
        >
    with $FutureModifier<List<CardModel>>, $StreamProvider<List<CardModel>> {
  const DeckCardsProvider._({
    required DeckCardsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'deckCardsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deckCardsHash();

  @override
  String toString() {
    return r'deckCardsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CardModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CardModel>> create(Ref ref) {
    final argument = this.argument as int;
    return deckCards(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckCardsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deckCardsHash() => r'28b5a95b97392003385bf96577e5fd2eddb55788';

final class DeckCardsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CardModel>>, int> {
  const DeckCardsFamily._()
    : super(
        retry: null,
        name: r'deckCardsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeckCardsProvider call(int deckId) =>
      DeckCardsProvider._(argument: deckId, from: this);

  @override
  String toString() => r'deckCardsProvider';
}
