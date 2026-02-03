import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';
import 'package:omni_card_ai/presentation/create_card/widgets/manual_flashcard_input_widget.dart';
import 'package:omni_card_ai/presentation/create_card/widgets/card_form_model.dart';
import 'package:omni_card_ai/presentation/providers/batch_card_provider.dart';
/// ============ BATCH CREATE CARDS SCREEN ============
/// Màn hình tạo nhiều thẻ cùng lúc
class ManualBatchCreateCardsScreen extends ConsumerStatefulWidget {
  final int deckId;
  final String deckTitle;

  const ManualBatchCreateCardsScreen({
    super.key,
    required this.deckId,
    this.deckTitle = 'Bộ thẻ',
  });

  @override
  ConsumerState<ManualBatchCreateCardsScreen> createState() =>
      _ManualBatchCreateCardsScreenState();
}

class _ManualBatchCreateCardsScreenState extends ConsumerState<ManualBatchCreateCardsScreen> {
  final List<CardFormModel> _cards = [];
  final ScrollController _scrollController = ScrollController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _addNewCard();
  }

  @override
  void dispose() {
    for (var card in _cards) {
      card.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }
  // ========== CARD MANAGEMENT ==========
  void _addNewCard() {
    setState(() {
      _cards.add(CardFormModel());
    });

    // Auto-scroll to bottom after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      // Focus on front field of new card
      if (_cards.isNotEmpty) {
        _cards.last.frontFocusNode.requestFocus();
      }
    });
  }

  void _removeCard(int index) {
    if (_cards.length <= 1) {
      // Always keep at least one card
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Phải có ít nhất một thẻ'),
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

    // Dispose before removing
    _cards[index].dispose();

    setState(() {
      _cards.removeAt(index);
    });
  }

  // ========== AI SUGGESTION ==========
  Future<void> _onAISuggestion(CardFormModel card) async {
    final question = card.frontController.text.trim();

    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng nhập câu hỏi trước'),
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

    // TODO: Integrate with AI API
    // Example:
    // final suggestion = await aiService.getSuggestion(question);
    // card.backController.text = suggestion;

    // Simulate AI call
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pop(context); // Close loading

    // Mock suggestion
    card.backController.text = 'Đây là câu trả lời được gợi ý bởi AI cho: "$question"';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✨ Đã tạo gợi ý với AI'),
        backgroundColor: AppTheme.accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ========== VALIDATION & SAVE ==========
  Future<void> _onSave() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Filter complete cards
    final completeCards = _cards.where((card) => card.isComplete).toList();

    if (completeCards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng hoàn thành ít nhất một thẻ'),
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

    // Show confirmation if there are incomplete cards
    final incompleteCount = _cards.length - completeCards.length;
    if (incompleteCount > 0) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lưu thẻ?'),
          content: Text(
            'Có $incompleteCount thẻ chưa hoàn thành sẽ bị bỏ qua.\n\n'
            'Bạn có muốn lưu ${completeCards.length} thẻ đã hoàn thành?',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Lưu'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;
    }

    setState(() => _isSaving = true);

    try {
      // TODO: Save to database/provider
      // Example with Riverpod:
      // await ref.read(cardsProvider.notifier).batchCreateCards(
      //   deckId: widget.deckId,
      //   cards: completeCards.map((c) => c.toMap()).toList(),
      // );
      await ref.read(batchCardProvider.notifier).saveAll(
        deckId: widget.deckId, 
        forms: completeCards
      );

      if (mounted) {
        // Return to previous screen
        Navigator.pop(context, completeCards.length);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã tạo ${completeCards.length} thẻ mới'),
            backgroundColor: AppTheme.accentGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );     
      }
    } 
    catch (e) {
      //if (!mounted) return;
      debugPrint("Lỗi thuật: $e");
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
          onPressed: () async {
            // Check for unsaved changes
            final hasContent = _cards.any((card) => card.hasContent);
            if (hasContent) {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Thoát mà không lưu?'),
                  content: const Text('Tất cả thay đổi sẽ bị mất.'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Ở lại'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Thoát',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirmed == true && mounted) {
                Navigator.pop(context);
              }
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
        ),
        title: const Text(
          'Tạo thẻ hàng loạt',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: _isSaving ? null : _onSave,
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Text(
                      'Lưu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // ========== CARD LIST ==========
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppTheme.spacingL),
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  return CardInputUnit(
                    key: ValueKey(_cards[index].id),
                    card: _cards[index],
                    index: index,
                    canDelete: _cards.length > 1,
                    onDelete: () => _removeCard(index),
                    onAISuggestion: () => _onAISuggestion(_cards[index]),
                  );
                },
              ),
            ),

            // ========== ADD BUTTON ==========
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingL),
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
              child: AddCardButton(onPressed: _addNewCard),
            ),
          ],
        ),
      ),
    );
  }
}