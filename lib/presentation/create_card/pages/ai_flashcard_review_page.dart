import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';

import '../../../core/routes/route_name.dart';

/// ============ GENERATED CARD MODEL ============
class GeneratedCardModel {
  final String id;
  String question;
  String answer;
  String frontLanguage;
  String backLanguage;
  bool isSelected;

  GeneratedCardModel({
    String? id,
    required this.question,
    required this.answer,
    this.frontLanguage = 'vi-VN',
    this.backLanguage = 'vi-VN',
    this.isSelected = true, // Selected by default
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, String> toMap() {
    return {'question': question, 'answer': answer};
  }
}

/// ============ REVIEW GENERATED CARDS SCREEN ============
/// Màn hình duyệt và chỉnh sửa thẻ do AI tạo ra
class AIFlashcardReviewScreen extends ConsumerStatefulWidget {
  final List<Map<String, String>> generatedCards;
  final int initialDeckId;
  final String? initialDeckName;

  const AIFlashcardReviewScreen({
    super.key,
    required this.generatedCards,
    required this.initialDeckId,
    this.initialDeckName,
  });

  @override
  ConsumerState<AIFlashcardReviewScreen> createState() =>
      _AIFlashcardReviewScreenState();
}

class _AIFlashcardReviewScreenState
    extends ConsumerState<AIFlashcardReviewScreen> {
  late List<GeneratedCardModel> _cards;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Convert to model
    _cards = widget.generatedCards
        .map(
          (card) => GeneratedCardModel(
            question: card['front'] ?? card['question'] ?? card['term'] ?? '',
            answer: card['back'] ?? card['answer'] ?? card['definition'] ?? '',
            frontLanguage: card['frontLanguage'] ?? 'vi-VN',
            backLanguage: card['backLanguage'] ?? 'vi-VN',
          ),
        )
        .toList();
  }

  // ========== COMPUTED VALUES ==========
  int get _selectedCount => _cards.where((card) => card.isSelected).length;
  int get _totalCards => _cards.length;
  bool get _hasSelection => _selectedCount > 0;
  bool get _allSelected => _selectedCount == _totalCards;

  // ========== ACTIONS ==========
  void _toggleCard(int index) {
    setState(() {
      _cards[index].isSelected = !_cards[index].isSelected;
    });
  }

  void _toggleSelectAll() {
    setState(() {
      final newValue = !_allSelected;
      for (var card in _cards) {
        card.isSelected = newValue;
      }
    });
  }

  Future<void> _editCard(int index) async {
    final card = _cards[index];
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) =>
          EditCardDialog(question: card.question, answer: card.answer),
    );

    if (result != null) {
      setState(() {
        _cards[index].question = result['question']!;
        _cards[index].answer = result['answer']!;
      });
    }
  }

  // void _showDeckSelector() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) => DeckSelectorSheet(
  //       currentDeckId: _selectedDeckId,
  //       onDeckSelected: (deckId, deckName) {
  //         setState(() {
  //           _selectedDeckId = deckId;
  //           _selectedDeckName = deckName;
  //         });
  //         Navigator.pop(context);
  //       },
  //     ),
  //   );
  // }

  Future<void> _onSaveCards() async {
    if (!_hasSelection) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng chọn ít nhất một thẻ'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final int targetDeckId = widget.initialDeckId;

      final newCards = _cards
          .where((card) => card.isSelected)
          .map(
            (card) => CardModel()
              ..term = card.question
              ..definition = card.answer
              ..frontLanguage = card.frontLanguage
              ..backLanguage = card.backLanguage
              ..repetition = 0
              ..interval = 0
              ..easinessFactor = 2.5
              ..nextReview = DateTime.now()
              ..status = 'new'
              ..isDirty = true
              ..updatedAt = DateTime.now(),
          )
          .toList();

      await ref
          .read(deckRepositoryProvider)
          .addCardsToDeck(targetDeckId, newCards);

      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✅ Đã lưu $_selectedCount thẻ vào ${widget.initialDeckName ?? 'bộ thẻ hiện tại'}'
          ),
          backgroundColor: AppTheme.accentGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      // Thay vì pop() 2 lần, ta pop cho đến khi gặp DeckDetail
      Navigator.of(context).popUntil((route) {
        return route.settings.name == RouteName.deckDetail;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
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
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
        ),
        title: Column(
          children: [
            Text(
              'Duyệt thẻ đã tạo ($_totalCards)',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Chọn các thẻ bạn muốn lưu',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          // Select/Deselect All
          TextButton(
            onPressed: _toggleSelectAll,
            child: Text(
              _allSelected ? 'Bỏ chọn tất cả' : 'Chọn tất cả',
              style: const TextStyle(fontSize: 13, color: AppTheme.primaryBlue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ========== CARDS LIST ==========
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                return GeneratedCardItem(
                  card: card,
                  isSelected: card.isSelected,
                  onToggle: () => _toggleCard(index),
                  onEdit: () => _editCard(index),
                );
              },
            ),
          ),

          // ========== STICKY FOOTER ==========
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Deck Info Display (Static for now based on passed args)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.folder,
                            size: 20,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Lưu vào: ${widget.initialDeckName ?? "Bộ thẻ hiện tại"}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingM),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_hasSelection && !_isSaving)
                            ? _onSaveCards
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                          shadowColor: AppTheme.primaryBlue.withOpacity(0.4),
                          disabledBackgroundColor: AppTheme.primaryBlue
                              .withOpacity(0.3),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_circle, size: 20),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Lưu $_selectedCount thẻ đã chọn',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============ GENERATED CARD ITEM ============
class GeneratedCardItem extends StatelessWidget {
  final GeneratedCardModel card;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onEdit;

  const GeneratedCardItem({
    super.key,
    required this.card,
    required this.isSelected,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: isSelected
              ? AppTheme.primaryBlue.withOpacity(0.3)
              : const Color(0xFFE5E7EB),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (_) => onToggle(),
                    activeColor: AppTheme.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Q: ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                            TextSpan(
                              text: card.question,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Answer
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'A: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: card.answer,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Edit Button
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, size: 20, color: Colors.grey[600]),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ============ EDIT CARD DIALOG ============
class EditCardDialog extends StatefulWidget {
  final String question;
  final String answer;

  const EditCardDialog({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<EditCardDialog> createState() => _EditCardDialogState();
}

class _EditCardDialogState extends State<EditCardDialog> {
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _answerController = TextEditingController(text: widget.answer);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chỉnh sửa thẻ'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Câu hỏi',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _questionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập câu hỏi...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Câu trả lời',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _answerController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập câu trả lời...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'question': _questionController.text.trim(),
              'answer': _answerController.text.trim(),
            });
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}

/// ============ DECK SELECTOR SHEET ============
class DeckSelectorSheet extends StatelessWidget {
  final String? currentDeckId;
  final Function(String deckId, String deckName) onDeckSelected;

  const DeckSelectorSheet({
    super.key,
    this.currentDeckId,
    required this.onDeckSelected,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Load from provider
    final decks = [
      {'id': '1', 'name': 'Bộ thẻ Tiếng Anh'},
      {'id': '2', 'name': 'Sinh học Đại cương'},
      {'id': '3', 'name': 'Lịch sử Việt Nam'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Chọn bộ thẻ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24),
          ...decks.map(
            (deck) => ListTile(
              leading: const Icon(Icons.folder, color: AppTheme.primaryBlue),
              title: Text(deck['name']!),
              trailing: currentDeckId == deck['id']
                  ? const Icon(Icons.check, color: AppTheme.primaryBlue)
                  : null,
              onTap: () => onDeckSelected(deck['id']!, deck['name']!),
            ),
          ),
        ],
      ),
    );
  }
}