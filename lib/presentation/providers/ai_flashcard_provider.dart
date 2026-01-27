import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/core/services/groq_service.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';

// State chứa danh sách thẻ tạm thời
class AiFlashcardState {
  final bool isLoading;
  final List<Map<String, String>> generatedCards;
  final String? error;

  AiFlashcardState({
    this.isLoading = false,
    this.generatedCards = const [],
    this.error,
  });

  AiFlashcardState copyWith({
    bool? isLoading,
    List<Map<String, String>>? generatedCards,
    String? error,
  }) {
    return AiFlashcardState(
      isLoading: isLoading ?? this.isLoading,
      generatedCards: generatedCards ?? this.generatedCards,
      error: error,
    );
  }
}

// Notifier quản lý logic
class AiFlashcardNotifier extends StateNotifier<AiFlashcardState> {
  final GroqService _service = GroqService();
  final Ref ref;

  AiFlashcardNotifier(this.ref) : super(AiFlashcardState());

  // 1. Gọi API để tạo thẻ
  Future<bool> generateCards(String text) async {
    if (text.isEmpty) return false;

    state = state.copyWith(isLoading: true, error: null);
    try {
      final cards = await _service.generateFlashcards(text);
      state = state.copyWith(isLoading: false, generatedCards: cards);
      return true; // Thành công
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false; // Thất bại
    }
  }

  // 2. Lưu thẻ vào Database (Isar)
  Future<void> saveCardsToDeck(int deckId) async {
    state = state.copyWith(isLoading: true);
    try {
      // Convert Map -> CardModel (Chuẩn SM-2 mới)
      final newCards = state.generatedCards.map((map) => CardModel()
        ..term = map['term']!
        ..definition = map['definition']!
        ..repetition = 0
        ..interval = 0
        ..easinessFactor = 2.5
        ..nextReview = DateTime.now()
        ..status = 'new'
        ..isDirty = true
        ..updatedAt = DateTime.now()
      ).toList();

      // Gọi Repository lưu
      await ref.read(deckRepositoryProvider).addCardsToDeck(deckId, newCards);
      
      // Reset state sau khi lưu xong
      state = AiFlashcardState(); 
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }
  
  // Xóa thẻ khỏi danh sách review (Logic tạm thời)
  void removeCardAt(int index) {
    final updatedList = List<Map<String, String>>.from(state.generatedCards);
    updatedList.removeAt(index);
    state = state.copyWith(generatedCards: updatedList);
  }
}

// Provider
final aiFlashcardProvider = StateNotifierProvider<AiFlashcardNotifier, AiFlashcardState>((ref) {
  return AiFlashcardNotifier(ref);
});