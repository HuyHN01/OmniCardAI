import 'package:flutter/material.dart';

/// ============ DECK STAT CARD ============
/// Card hiển thị thống kê thẻ theo trạng thái
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
            // Dot + Label
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: dotColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Value
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============ FLASHCARD LIST ITEM ============
/// Item trong danh sách thẻ với status và edit button
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
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
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
                // Leading Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Content
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
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Trailing (Status dot + Edit button)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.grey[600],
                      ),
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

/// ============ STUDY NOW BUTTON ============
/// Button chính để bắt đầu học
class StudyNowButton extends StatelessWidget {
  final int cardCount;
  final VoidCallback onPressed;

  const StudyNowButton({
    super.key,
    required this.cardCount,
    required this.onPressed,
  });

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
          shadowColor: const Color(0xFF2196F3).withOpacity(0.4),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// ============ SECTION HEADER ============
/// Header cho các section với optional action button
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
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

/// ============ DECK HEADER INFO ============
/// Header info với title và subtitle
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$totalCards thẻ • Lần học cuối: $lastStudied',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

/// ============ EMPTY STATE ============
/// Hiển thị khi deck chưa có thẻ nào
class EmptyDeckState extends StatelessWidget {
  final VoidCallback onAddCard;

  const EmptyDeckState({
    super.key,
    required this.onAddCard,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.layers_outlined,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            const Text(
              'Chưa có thẻ nào',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Thêm thẻ mới để bắt đầu học',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAddCard,
              icon: const Icon(Icons.add),
              label: const Text('Thêm thẻ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============ SORT OPTIONS BOTTOM SHEET ============
/// Bottom sheet để chọn cách sắp xếp
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
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Sắp xếp theo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          
          // Options
          _buildSortOption(
            context,
            icon: Icons.sort_by_alpha,
            label: 'Thứ tự A-Z',
            onTap: () {
              Navigator.pop(context);
              onSortSelected('alphabetical');
            },
          ),
          _buildSortOption(
            context,
            icon: Icons.access_time,
            label: 'Mới nhất',
            onTap: () {
              Navigator.pop(context);
              onSortSelected('newest');
            },
          ),
          _buildSortOption(
            context,
            icon: Icons.stars,
            label: 'Độ khó',
            onTap: () {
              Navigator.pop(context);
              onSortSelected('difficulty');
            },
          ),
          _buildSortOption(
            context,
            icon: Icons.trending_up,
            label: 'Tỷ lệ đúng',
            onTap: () {
              Navigator.pop(context);
              onSortSelected('accuracy');
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildSortOption(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF2196F3)),
    title: Text(
      label,
      style: const TextStyle(fontSize: 15),
    ),
    onTap: onTap,
  );
}