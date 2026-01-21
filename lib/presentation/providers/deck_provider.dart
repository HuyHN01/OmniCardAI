import 'package:omni_card_ai/domain/repositories/deck_repository.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
part 'deck_provider.g.dart';

@riverpod
class DeckNotifier extends _$DeckNotifier {
  late final IDeckRepository _repository;

  @override
  FutureOr<List<DeckModel>> build() {
    _repository = ref.watch(deckRepositoryProvider);
    return _repository.getAllDecks();
  }

  Future<void> addDeck(String title, String desc) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final newDeck = DeckModel()
        ..title = title
        ..description = desc
        ..updatedAt = DateTime.now();
      await _repository.saveDeck(newDeck);
      return _repository.getAllDecks();
    });
  }
}