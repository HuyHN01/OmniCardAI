import 'package:flutter/rendering.dart';
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
  Future<void> saveDeck(DeckModel deck) async {
    await isar.writeTxn(() async {
      await isar.deckModels.put(deck);
    });
  }

  @override
  Future<void> deleteDeck(int id) async {
    await isar.writeTxn(() async {
      await isar.deckModels.delete(id);
    });
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
}