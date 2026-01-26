import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
part 'deck_detail_provider.g.dart';

@riverpod
Stream<DeckModel?> deckDetail(DeckDetailRef ref, int deckId) {
  final repository = ref.watch(deckRepositoryProvider);
  
  return repository.watchDeck(deckId).asyncMap((deck) async {
    if (deck != null) {
      await deck.cards.load(); 
    }
    return deck;
  });
}

@riverpod
Stream<List<CardModel>> deckCards(DeckCardsRef ref, int deckId) {
  final repository = ref.watch(deckRepositoryProvider);
  return repository.watchCardsInDeck(deckId);
}