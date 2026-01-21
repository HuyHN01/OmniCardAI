import 'package:flutter/material.dart';
// import 'deck_detail_widgets.dart';

/// ============ DECK DETAIL SCREEN ============
/// Màn hình chi tiết bộ thẻ với danh sách flashcards
class DeckDetailScreen extends StatefulWidget {
  final String deckTitle;

  const DeckDetailScreen({
    super.key,
    this.deckTitle = 'Tiếng Anh Giao Tiếp',
  });

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  
  // ========== DECK DATA (Mock) ==========
  final int _totalCards = 47;
  final int _newCards = 12;
  final int _learningCards = 5;
  final int _masteredCards = 20;
  final String _lastStudied = 'Hôm nay';
  
  // Cards to study (new + learning)
  int get _cardsToStudy => _newCards + _learningCards;
  
  // ========== FLASHCARDS DATA ==========
  final List<Map<String, dynamic>> _flashcards = [
    {
      'question': 'Hello, how are you?',
      'answer': 'Xin chào, bạn khỏe không?',
      'icon': Icons.person,
      'iconColor': Color(0xFF2196F3),
      'iconBg': Color(0xFFE3F2FD),
      'status': 'new', // new, learning, mastered
    },
    {
      'question': 'Good morning',
      'answer': 'Chào buổi sáng',
      'icon': Icons.translate,
      'iconColor': Color(0xFFFF9800),
      'iconBg': Color(0xFFFFF3E0),
      'status': 'learning',
    },
    {
      'question': 'Thank you very much',
      'answer': 'Cảm ơn rất nhiều',
      'icon': Icons.check_circle,
      'iconColor': Color(0xFF4CAF50),
      'iconBg': Color(0xFFE8F5E9),
      'status': 'mastered',
    },
    {
      'question': 'Where is the library?',
      'answer': 'Thư viện ở đâu?',
      'icon': Icons.school,
      'iconColor': Color(0xFF2196F3),
      'iconBg': Color(0xFFE3F2FD),
      'status': 'new',
    },
    {
      'question': 'I am learning English',
      'answer': 'Tôi đang học tiếng Anh',
      'icon': Icons.check_circle,
      'iconColor': Color(0xFF4CAF50),
      'iconBg': Color(0xFFE8F5E9),
      'status': 'mastered',
    },
  ];
  
  // ========== ACTIONS ==========
  void _onSettings() {
    debugPrint('Open deck settings');
    // TODO: Navigate to deck settings
  }
  
  void _onStartStudy() {
    debugPrint('Start study session with $_cardsToStudy cards');
    // TODO: Navigate to study screen
  }
  
  void _onCardTap(Map<String, dynamic> card) {
    debugPrint('View card: ${card['question']}');
    // TODO: Show card detail or quick preview
  }
  
  void _onEditCard(Map<String, dynamic> card) {
    debugPrint('Edit card: ${card['question']}');
    // TODO: Navigate to edit card screen
  }
  
  void _onSort() {
    showSortOptions(context, (sortType) {
      debugPrint('Sort by: $sortType');
      // TODO: Implement sorting logic
      setState(() {
        // Sort _flashcards based on sortType
      });
    });
  }
  
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

  @override
  Widget build(BuildContext context) {
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
            onPressed: _onSettings,
            icon: const Icon(Icons.settings, color: Color(0xFF111827)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== HEADER INFO ==========
              Padding(
                padding: const EdgeInsets.all(24),
                child: DeckHeaderInfo(
                  title: widget.deckTitle,
                  totalCards: _totalCards,
                  lastStudied: _lastStudied,
                ),
              ),
              
              // ========== STATS CARDS ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    DeckStatCard(
                      label: 'Mới',
                      value: _newCards,
                      dotColor: const Color(0xFF2196F3),
                      backgroundColor: const Color(0xFFE3F2FD),
                    ),
                    const SizedBox(width: 12),
                    DeckStatCard(
                      label: 'Đang học',
                      value: _learningCards,
                      dotColor: const Color(0xFFFF9800),
                      backgroundColor: const Color(0xFFFFF3E0),
                    ),
                    const SizedBox(width: 12),
                    DeckStatCard(
                      label: 'Đã thuộc',
                      value: _masteredCards,
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
                  cardCount: _cardsToStudy,
                  onPressed: _onStartStudy,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // ========== CARD LIST SECTION ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DeckDetailSectionHeader(
                  title: 'Danh sách thẻ',
                  onActionPressed: _onSort,
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
                  itemCount: _flashcards.length,
                  itemBuilder: (context, index) {
                    final card = _flashcards[index];
                    return FlashcardListItem(
                      question: card['question'],
                      answer: card['answer'],
                      icon: card['icon'],
                      iconColor: card['iconColor'],
                      iconBackgroundColor: card['iconBg'],
                      statusColor: _getStatusColor(card['status']),
                      onTap: () => _onCardTap(card),
                      onEdit: () => _onEditCard(card),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

// ========== INLINE WIDGETS (Copy từ deck_detail_widgets.dart) ==========

class DeckStatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color dotColor;
  final Color backgroundColor;

  const DeckStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.dotColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: dotColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardListItem extends StatelessWidget {
  final String question;
  final String answer;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final Color statusColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const FlashcardListItem({
    super.key,
    required this.question,
    required this.answer,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.statusColor,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        answer,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(Icons.edit, size: 20, color: Colors.grey[600]),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudyNowButton extends StatelessWidget {
  final int cardCount;
  final VoidCallback onPressed;

  const StudyNowButton({super.key, required this.cardCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.play_arrow, size: 24),
        label: Text('Học ngay ($cardCount thẻ)'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
          shadowColor: const Color(0xFF2196F3).withOpacity(0.4),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class DeckDetailSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const DeckDetailSectionHeader({
    super.key,
    required this.title,
    this.onActionPressed,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        ),
        if (onActionPressed != null)
          TextButton.icon(
            onPressed: onActionPressed,
            icon: const Icon(Icons.sort, size: 18),
            label: Text(actionLabel ?? 'Sắp xếp'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2196F3),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
      ],
    );
  }
}

class DeckHeaderInfo extends StatelessWidget {
  final String title;
  final int totalCards;
  final String lastStudied;

  const DeckHeaderInfo({
    super.key,
    required this.title,
    required this.totalCards,
    required this.lastStudied,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 6),
        Text(
          '$totalCards thẻ • Lần học cuối: $lastStudied',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

void showSortOptions(BuildContext context, Function(String) onSortSelected) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Sắp xếp theo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          _buildSortOption(context, Icons.sort_by_alpha, 'Thứ tự A-Z', () {
            Navigator.pop(context);
            onSortSelected('alphabetical');
          }),
          _buildSortOption(context, Icons.access_time, 'Mới nhất', () {
            Navigator.pop(context);
            onSortSelected('newest');
          }),
          _buildSortOption(context, Icons.stars, 'Độ khó', () {
            Navigator.pop(context);
            onSortSelected('difficulty');
          }),
          _buildSortOption(context, Icons.trending_up, 'Tỷ lệ đúng', () {
            Navigator.pop(context);
            onSortSelected('accuracy');
          }),
        ],
      ),
    ),
  );
}

Widget _buildSortOption(BuildContext context, IconData icon, String label, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF2196F3)),
    title: Text(label, style: const TextStyle(fontSize: 15)),
    onTap: onTap,
  );
}