import 'package:omni_card_ai/presentation/providers/deck_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
part 'search_provider.g.dart';

// 1. Provider lưu trữ từ khóa tìm kiếm hiện tại
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) => state = query;
}

// 2. Provider xử lý việc truy vấn Database dựa trên từ khóa
@riverpod
Stream<List<DeckModel>> searchResult(Ref ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();

  final deckAsync = ref.watch(deckProvider);

  return deckAsync.when(
    data: (decks) {
      if (query.isEmpty) return Stream.value(decks);

      final filteredDecks = decks.where((d) => 
        d.title.toLowerCase().contains(query)
      ).toList();
      
      return Stream.value(filteredDecks);
    }, 
    error: (err, stack) => Stream.error(err, stack), 
    loading: () => const Stream.empty()
  );
}