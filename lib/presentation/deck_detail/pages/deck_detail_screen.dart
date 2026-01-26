import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/presentation/deck_detail/widgets/deck_detail_widgets.dart';
import 'package:omni_card_ai/presentation/deck_detail/pages/create_card_modal.dart';
import 'package:omni_card_ai/presentation/main_shell/floating_action_button_switcher.dart';
import 'package:omni_card_ai/presentation/providers/deck_detail_provider.dart';


/// ============ DECK DETAIL SCREEN ============
/// Màn hình chi tiết bộ thẻ với danh sách flashcards
class DeckDetailScreen extends ConsumerWidget {
  final int deckId;

  const DeckDetailScreen({
    super.key,
    required this.deckId,
  });

  // Helper để xác định trạng thái thẻ (Logic tạm thời)
  String _getCardStatus(CardModel card) {
    if (card.stability == 0) return 'new';
    if (card.stability > 20) return 'mastered';
    return 'learning';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckAsync = ref.watch(deckDetailProvider(deckId));
    final cardsAsync = ref.watch(deckCardsProvider(deckId));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
        ),
        actions: [
          IconButton(
            onPressed: () {} /* TODO: Settings */,
            icon: const Icon(Icons.settings, color: Color(0xFF111827)),
          ),
        ],
      ),
      body: deckAsync.when(
        data: (deck) {
          if (deck == null) {
            return const Center(
              child: Text(
                'Bộ thẻ không tồn tại'
              ),
            );
          }
          
          return cardsAsync.when(
            error: (err, stack) => Center(child: Text('Lỗi tải thẻ: $err')), 
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (cards) {
              final newCards = cards
                  .where((card) => card.stability == 0)
                  .length;
              final masteredCards = cards
                  .where((card) => card.stability > 20)
                  .length;
              final learningCards = cards.length - newCards - masteredCards;

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== HEADER INFO ==========
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: DeckHeaderInfo(
                          title: deck.title,
                          totalCards: cards.length,
                          lastStudied:
                              'Chưa học', //Sẽ chỉnh sửa dựa trên deck.updateAt
                        ),
                      ),

                      // ========== STATS CARDS ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            DeckStatCard(
                              label: 'Mới',
                              value: newCards,
                              dotColor: const Color(0xFF2196F3),
                              backgroundColor: const Color(0xFFE3F2FD),
                            ),

                            const SizedBox(width: 12),

                            DeckStatCard(
                              label: 'Đang học',
                              value: learningCards,
                              dotColor: const Color(0xFFFF9800),
                              backgroundColor: const Color(0xFFFFF3E0),
                            ),

                            const SizedBox(width: 12),

                            DeckStatCard(
                              label: 'Đã thuộc',
                              value: masteredCards,
                              dotColor: const Color(0xFF4CAF50),
                              backgroundColor: const Color(0xFFE8F5E9),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ========== STUDY NOW BUTTON ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: StudyNowButton(
                          cardCount: newCards + learningCards,
                          onPressed: () {} /* Navigate Study */,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ========== CARD LIST SECTION ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: DeckDetailSectionHeader(
                          title: 'Danh sách thẻ (${cards.length})',
                          onActionPressed: () {}, // TODO: Sort
                          actionLabel: 'Sắp xếp',
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ========== FLASHCARD LIST ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            final card = cards[index];
                            final status = _getCardStatus(card);

                            return FlashcardListItem(
                              question: card.term,
                              answer: card.definition,
                              icon: Icons.text_fields, //TODO: Logic Icon
                              iconColor: Colors.blue,
                              iconBackgroundColor: Colors.blue.shade50,
                              statusColor: _getStatusColor(status),
                              onTap: () {}, //Triển khai sau
                              onEdit: () {}, //Triển khai sau
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              );
            },
          );
        }, 
        error: (err, stack) => Center(child: Text('Lỗi: $err')), 
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      //=======FLOATING ACTION BUTTON ĐỂ TẠO CARD MỚI TRONG DESK=============
      floatingActionButton: FloatingActionButtonSwitcher(
        isVisible: true,
        onPressed: () => showCreateCardModal(context, deckId: deckId),
      ),
    );
  }

  // ========== ACTIONS ==========
  Color _getStatusColor(String status) {
    switch (status) {
      case 'new':
        return const Color(0xFF2196F3);
      case 'learning':
        return const Color(0xFFFF9800);
      case 'mastered':
        return const Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }
}