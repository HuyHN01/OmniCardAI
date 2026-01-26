import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';

abstract class IDeckRepository {
  Future<List<DeckModel>> getAllDecks();
  Future<int> saveDeck(DeckModel deck);
  Future<void> deleteDeck(int id);
  Future<List<DeckModel>> searchDecks(String query);
  Future<List<CardModel>> searchCards(String query);
  Stream<List<DeckModel>> watchDecks();
  Stream<DeckModel?> watchDeck(int id);
  Future<void> addCardsToDeck(int deckId, List<CardModel> newCards);
  Stream<List<CardModel>> watchCardsInDeck(int deckId);
  Future<List<CardModel>> getDueCards(int deckId);
}