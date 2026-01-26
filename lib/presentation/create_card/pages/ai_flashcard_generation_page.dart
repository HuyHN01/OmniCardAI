import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';

/// ============ AI TEXT INPUT SCREEN ============
/// Màn hình nhập văn bản để AI tạo flashcards tự động
class AIFlashcardGenerationScreen extends StatefulWidget {
  final int deckId;

  const AIFlashcardGenerationScreen({
    super.key,
    required this.deckId,
  });

  @override
  State<AIFlashcardGenerationScreen> createState() => _AIFlashcardGenerationScreenState();
}

class _AIFlashcardGenerationScreenState extends State<AIFlashcardGenerationScreen> {
  final TextEditingController _textController = TextEditingController();
  final int _maxCharacters = 2000;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    // Listen to text changes for character counter
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // ========== CHARACTER COUNT ==========
  int get _characterCount => _textController.text.length;
  bool get _isTextValid => _textController.text.trim().isNotEmpty;
  bool get _isOverLimit => _characterCount > _maxCharacters;

  // ========== ACTIONS ==========
  Future<void> _onGenerateCards() async {
    if (!_isTextValid || _isOverLimit) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    setState(() => _isGenerating = true);

    try {
      final inputText = _textController.text.trim();

      // TODO: Call Gemini AI API
      // Example:
      // final cards = await geminiService.generateCards(
      //   text: inputText,
      //   deckId: widget.deckId,
      // );

      // Simulate AI processing
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      // Mock response
      final mockCards = [
        {'front': 'Câu hỏi 1 từ AI', 'back': 'Câu trả lời 1'},
        {'front': 'Câu hỏi 2 từ AI', 'back': 'Câu trả lời 2'},
        {'front': 'Câu hỏi 3 từ AI', 'back': 'Câu trả lời 3'},
      ];

      // Show success and navigate back with results
      Navigator.pop(context, mockCards);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✨ Đã tạo ${mockCards.length} thẻ từ văn bản'),
          backgroundColor: AppTheme.accentGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
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
        setState(() => _isGenerating = false);
      }
    }
  }

  void _onPasteFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData?.text != null) {
      setState(() {
        _textController.text = clipboardData!.text!;
      });
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
        title: const Text(
          'Nhập văn bản AI',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          // Paste button
          IconButton(
            onPressed: _onPasteFromClipboard,
            icon: const Icon(Icons.content_paste, color: AppTheme.primaryBlue),
            tooltip: 'Dán từ clipboard',
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // ========== TEXT INPUT AREA ==========
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                        border: Border.all(
                          color: _isOverLimit
                              ? Colors.red
                              : const Color(0xFFE5E7EB),
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
                        children: [
                          // TextField
                          TextField(
                            controller: _textController,
                            maxLines: null,
                            minLines: 15,
                            maxLength: _maxCharacters,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: AppTheme.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Dán đoạn văn bản, bài báo, hoặc nhập chủ đề bạn muốn tạo thẻ vào đây...',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: AppTheme.textSecondary.withOpacity(0.5),
                                height: 1.5,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(24),
                              counterText: '', // Hide default counter
                            ),
                          ),

                          // Custom character counter
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 24,
                              bottom: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '$_characterCount/$_maxCharacters',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _isOverLimit
                                        ? Colors.red
                                        : AppTheme.textSecondary,
                                    fontWeight: _isOverLimit
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Helper text
                    if (_characterCount > 0 && !_isOverLimit)
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 16,
                            color: AppTheme.primaryBlue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'AI sẽ phân tích văn bản và tạo flashcards phù hợp cho bạn',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),

                    // Error message
                    if (_isOverLimit)
                      Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Văn bản quá dài. Vui lòng giảm xuống ${_maxCharacters} ký tự.',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // ========== GENERATE BUTTON ==========
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
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_isTextValid && !_isOverLimit && !_isGenerating)
                        ? _onGenerateCards
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
                      disabledBackgroundColor:
                          AppTheme.primaryBlue.withOpacity(0.3),
                    ),
                    child: _isGenerating
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.auto_awesome, size: 20),
                              SizedBox(width: 10),
                              Text(
                                'Tạo thẻ với Gemini',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}