import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/core/services/sm2_service.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';

// Dòng này cần thiết để riverpod_generator hoạt động
part 'study_session_provider.g.dart';

// --- STATE CLASS (Giữ nguyên logic cũ) ---
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

// --- NOTIFIER (Đã sửa lỗi arg) ---
@riverpod
class StudySession extends _$StudySession {
  final Sm2Service _sm2Service = Sm2Service();
  
  // 1. Khai báo biến để lưu deckId
  late int deckId;

  @override
  StudySessionState build(int deckId) {
    // 2. Lưu tham số deckId vào biến của class để dùng ở nơi khác
    this.deckId = deckId;
    
    // Gọi hàm load dữ liệu ngay khi khởi tạo
    _loadDueCards();
    return StudySessionState(); 
  }

  Future<void> _loadDueCards() async {
    try {
      // 3. Sửa 'arg' thành 'this.deckId'
      final cards = await ref.read(deckRepositoryProvider).getDueCards(this.deckId);
      state = state.copyWith(cards: cards, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> rateCard(int rating) async {
    final currentCard = state.currentCard;
    if (currentCard == null) return;

    // 1. Tính toán lịch mới bằng SM-2
    final updatedCard = _sm2Service.calculate(currentCard, rating);

    // 2. Lưu xuống DB
    // 3. Sửa 'arg' thành 'this.deckId'
    await ref.read(deckRepositoryProvider).addCardsToDeck(
      this.deckId, 
      [updatedCard], 
    );

    // 3. Chuyển sang thẻ tiếp theo
    if (state.currentIndex < state.cards.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      state = state.copyWith(isFinished: true);
    }
  }
}