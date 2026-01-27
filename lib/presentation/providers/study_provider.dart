import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/core/services/sm2_service.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';

// State của phiên học
class StudySessionState {
  final List<CardModel> cards;
  final int currentIndex;
  final bool isFinished;
  final bool isLoading;

  StudySessionState({
    this.cards = const [],
    this.currentIndex = 0,
    this.isFinished = false,
    this.isLoading = true,
  });

  CardModel? get currentCard => 
      (cards.isNotEmpty && currentIndex < cards.length) ? cards[currentIndex] : null;

  int get progress => currentIndex + 1;
  int get total => cards.length;

  StudySessionState copyWith({
    List<CardModel>? cards,
    int? currentIndex,
    bool? isFinished,
    bool? isLoading,
  }) {
    return StudySessionState(
      cards: cards ?? this.cards,
      currentIndex: currentIndex ?? this.currentIndex,
      isFinished: isFinished ?? this.isFinished,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Notifier quản lý logic
class StudyNotifier extends StateNotifier<StudySessionState> {
  final Ref ref;
  final int deckId;
  final Sm2Service _sm2Service = Sm2Service();

  StudyNotifier(this.ref, this.deckId) : super(StudySessionState()) {
    _loadDueCards();
  }

  Future<void> _loadDueCards() async {
    try {
      final cards = await ref.read(deckRepositoryProvider).getDueCards(deckId);
      state = state.copyWith(cards: cards, isLoading: false);
    } catch (e) {
      // Handle error (ví dụ: state = state.copyWith(error: e))
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> rateCard(int rating) async {
    final currentCard = state.currentCard;
    if (currentCard == null) return;

    // 1. Tính toán lịch mới bằng SM-2
    final updatedCard = _sm2Service.calculate(currentCard, rating);

    // 2. Lưu xuống DB
    // Lưu ý: Ta có thể lưu ngay hoặc gom lại lưu 1 lần cuối buổi. 
    // Để an toàn (tránh crash mất dữ liệu), ta lưu ngay.
    await ref.read(deckRepositoryProvider).addCardsToDeck(
      deckId, 
      [updatedCard], // Tận dụng hàm save có sẵn, nó sẽ update vì ID đã có
    );

    // 3. Chuyển sang thẻ tiếp theo
    if (state.currentIndex < state.cards.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      state = state.copyWith(isFinished: true);
    }
  }
}

// Provider Factory để tạo Notifier theo deckId
final studySessionProvider = StateNotifierProvider.family.autoDispose<StudyNotifier, StudySessionState, int>(
  (ref, deckId) => StudyNotifier(ref, deckId),
);