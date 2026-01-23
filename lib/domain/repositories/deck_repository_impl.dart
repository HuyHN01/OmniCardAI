import 'package:isar_community/isar.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
import 'package:omni_card_ai/domain/repositories/deck_repository.dart';

class DeckRepositoryImpl implements IDeckRepository {
  final Isar isar;
  DeckRepositoryImpl(this.isar);

  @override
  Future<List<DeckModel>> getAllDecks() async {
    final decks = await isar.deckModels.where().findAll();

    for (var deck in decks) {
      await deck.cards.load();
    }

    return decks;
  }

  @override
  Future<int> saveDeck(DeckModel deck) async {
    dynamic newId;

    await isar.writeTxn(() async {
      newId = await isar.deckModels.put(deck);
    });

    return newId;
  }

  @override
  Future<void> deleteDeck(int id) async {
    await isar.writeTxn(() async {
      // 1. Tìm và xóa tất cả các Card thuộc bộ thẻ này trước
      // Điều này đảm bảo không còn Card nào "mồ côi" trong database
      await isar.cardModels.filter().deck((q) => q.idEqualTo(id)).deleteAll();

      // 2. Xóa chính bộ thẻ đó
      await isar.deckModels.delete(id);
    });
  }

  @override
  Future<List<DeckModel>> searchDecks(String query) async {
    if (query.isEmpty) {
      return getAllDecks();
    }
    
    final results = await isar.deckModels
        .filter()
        .titleContains(query, caseSensitive: false)
        .findAll();

    for (var deck in results) {
      await deck.cards.load();
    }
    
    return results;
  }

  @override
  Future<List<CardModel>> searchCards(String query) async {
    if (query.isEmpty) return [];
    // Full-text search đơn giản trên cả term và definition
    return await isar.cardModels
        .filter()
        .termContains(query, caseSensitive: false)
        .or()
        .definitionContains(query, caseSensitive: false)
        .findAll();
  }

  @override
  Stream<List<DeckModel>> watchDecks() {
    return isar.deckModels.where().watch(fireImmediately: true);
  }

  @override
  Stream<DeckModel?> watchDeck(int id) {
    return isar.deckModels.watchObject(id, fireImmediately: true);
  }
}