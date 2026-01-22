import 'package:omni_card_ai/domain/repositories/deck_repository.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
part 'deck_provider.g.dart';

@riverpod
class DeckNotifier extends _$DeckNotifier {
  IDeckRepository get _repository => ref.read(deckRepositoryProvider);

  @override
  Stream<List<DeckModel>> build() {
    return _repository.watchDecks(); 
  }

  Future<void> addDeck(String title, String desc) async {
    final newDeck = DeckModel()
      ..title = title
      ..description = desc
      ..updatedAt = DateTime.now();

    await _repository.saveDeck(newDeck); 
  }

  Future<void> deleteDeck(int deckId) async {
    await _repository.deleteDeck(deckId);
  }
  
  Future<void> updateDeck(DeckModel deck, {String? title, String? desc}) async {
    if (title != null) deck.title = title;
    if (desc != null) deck.description = desc;

    deck.updatedAt = DateTime.now();
    deck.isDirty = true;

    await _repository.saveDeck(deck);
  }
}