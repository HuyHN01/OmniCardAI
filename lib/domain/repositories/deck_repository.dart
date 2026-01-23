import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';

abstract class IDeckRepository {
  Future<List<DeckModel>> getAllDecks();
  Future<void> saveDeck(DeckModel deck);
  Future<void> deleteDeck(int id);
  Future<List<DeckModel>> searchDecks(String query);
  Future<List<CardModel>> searchCards(String query);
  Stream<List<DeckModel>> watchDecks();
}