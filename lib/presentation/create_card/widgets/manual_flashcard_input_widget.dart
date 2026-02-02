import 'package:flutter/material.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';
import 'package:omni_card_ai/presentation/create_card/widgets/card_form_model.dart';

/// ============ CARD INPUT UNIT ============
/// Widget cho mỗi card pair (front + back)
class CardInputUnit extends StatelessWidget {
  final CardFormModel card;
  final VoidCallback onDelete;
  final VoidCallback onAISuggestion;
  final bool canDelete;
  final int index;

  const CardInputUnit({
    super.key,
    required this.card,
    required this.onDelete,
    required this.onAISuggestion,
    this.canDelete = true,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========== MẶT TRƯỚC (CÂU HỎI) ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mặt trước (Câu hỏi)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              if (canDelete)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.grey[600],
                  iconSize: 22,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Xóa thẻ',
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingS),

          TextField(
            controller: card.frontController,
            focusNode: card.frontFocusNode,
            textInputAction: TextInputAction.next,
            maxLines: 4,
            minLines: 3,
            style: const TextStyle(
              fontSize: 15,
              color: AppTheme.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Nhập câu hỏi...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary.withOpacity(0.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                borderSide: const BorderSide(
                  color: AppTheme.primaryBlue,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            onSubmitted: (_) {
              // Move focus to back field
              card.backFocusNode.requestFocus();
            },
          ),

          const SizedBox(height: AppTheme.spacingM),

          // ========== AI SUGGESTION BUTTON ==========
          Center(
            child: TextButton.icon(
              onPressed: onAISuggestion,
              icon: const Icon(
                Icons.auto_awesome,
                size: 18,
                color: AppTheme.primaryBlue,
              ),
              label: const Text(
                'Gợi ý câu trả lời với AI',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryBlue,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryBlueLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppTheme.spacingM),

          // ========== MẶT SAU (CÂU TRẢ LỜI) ==========
          const Text(
            'Mặt sau (Câu trả lời)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),

          TextField(
            controller: card.backController,
            focusNode: card.backFocusNode,
            textInputAction: TextInputAction.done,
            maxLines: 4,
            minLines: 3,
            style: const TextStyle(
              fontSize: 15,
              color: AppTheme.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Nhập câu trả lời...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary.withOpacity(0.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                borderSide: const BorderSide(
                  color: AppTheme.primaryBlue,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============ ADD CARD BUTTON ============
/// Button để thêm thẻ mới
class AddCardButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddCardButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add, size: 22),
          label: const Text(
            'Thêm thẻ khác',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 2,
          ),
        ),
      ),
    );
  }
}

