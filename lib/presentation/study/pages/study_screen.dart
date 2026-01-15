import 'package:flutter/material.dart';
// import 'study_widgets.dart';
import 'dart:math' as math;

/// ============ STUDY SCREEN ============
/// Màn hình học flashcard với flip animation và rating
class StudyScreen extends StatefulWidget {
  final String deckTitle;
  final int totalCards;

  const StudyScreen({
    super.key,
    this.deckTitle = 'SINH HỌC ĐẠI CƯƠNG',
    this.totalCards = 50,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  int _currentCardIndex = 0;
  bool _showAnswer = true; // Start with answer visible (design shows back)
  
  // ========== MOCK FLASHCARDS ==========
  final List<Map<String, dynamic>> _cards = [
    {
      'term': 'Quang hợp',
      'definition': 'Quá trình thực vật và một số sinh vật khác sử dụng năng lượng ánh sáng để tổng hợp thức ăn từ carbon dioxide và nước.',
      'imageUrl': 'https://images.unsplash.com/photo-1466611653911-95081537e5b7?w=800',
      'tag': 'THUẬT NGỮ',
      'hint': 'Gợi nhớ: "Quang" (Ánh sáng) + "Hợp" (Tổng hợp)',
    },
    {
      'term': 'DNA',
      'definition': 'Axit deoxyribonucleic, vật chất di truyền trong hầu hết các sinh vật.',
      'imageUrl': 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?w=800',
      'tag': 'KHÁI NIỆM',
      'hint': 'Gợi nhớ: Cấu trúc xoắn kép như thang dây',
    },
    {
      'term': 'Ti thể',
      'definition': 'Bào quan sản xuất năng lượng (ATP) cho tế bào thông qua hô hấp tế bào.',
      'imageUrl': 'https://images.unsplash.com/photo-1576086213369-97a306d36557?w=800',
      'tag': 'CẤU TRÚC',
      'hint': 'Gợi nhớ: "Nhà máy điện" của tế bào',
    },
  ];
  
  int get _currentCard => _currentCardIndex;
  int get _progress => _currentCardIndex + 1;
  
  // ========== ACTIONS ==========
  void _onClose() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kết thúc học?'),
        content: const Text('Tiến độ của bạn sẽ được lưu lại.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tiếp tục'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close study screen
            },
            child: const Text(
              'Kết thúc',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  
  void _onMenu() {
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
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt học tập'),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Open study settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Bắt đầu lại'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentCardIndex = 0;
                  _showAnswer = false;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Kết thúc', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _onClose();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }
  
  void _onRating(int rating) {
    debugPrint('Card rated: $rating');
    // TODO: Update card's next review date based on SM-2 algorithm
    
    // Move to next card
    if (_currentCardIndex < _cards.length - 1) {
      setState(() {
        _currentCardIndex++;
        _showAnswer = false; // Reset to question side
      });
    } else {
      // Session complete
      _showCompletionDialog();
    }
  }
  
  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Hoàn thành!'),
        content: Text('Bạn đã học xong ${_cards.length} thẻ.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close study screen
            },
            child: const Text('Xong'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = _cards[_currentCard];
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // ========== HEADER ==========
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Top row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _onClose,
                        icon: const Icon(Icons.close, size: 28),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'BỘ THẺ HIỆN TẠI',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.deckTitle,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: _onMenu,
                        icon: const Icon(Icons.more_horiz, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Progress bar
                  StudyProgressBar(
                    current: _progress,
                    total: widget.totalCards,
                  ),
                ],
              ),
            ),
            
            // ========== FLASHCARD AREA ==========
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: _flipCard,
                  child: StackedCardsBackground(
                    child: FlippableCard(
                      showBack: _showAnswer,
                      front: StudyCardWidget(
                        term: currentCard['term'],
                        definition: currentCard['definition'],
                        imageUrl: currentCard['imageUrl'],
                        tag: currentCard['tag'],
                        hint: currentCard['hint'],
                        showAnswer: false,
                      ),
                      back: StudyCardWidget(
                        term: currentCard['term'],
                        definition: currentCard['definition'],
                        imageUrl: currentCard['imageUrl'],
                        tag: currentCard['tag'],
                        hint: currentCard['hint'],
                        showAnswer: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // ========== RATING BUTTONS ==========
            if (_showAnswer)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    RatingButton(
                      label: 'QUÊN',
                      interval: '< 1p',
                      backgroundColor: const Color(0xFFFFEBEE),
                      textColor: const Color(0xFFE53935),
                      onPressed: () => _onRating(1),
                    ),
                    RatingButton(
                      label: 'KHÓ',
                      interval: '6p',
                      backgroundColor: const Color(0xFFFFF3E0),
                      textColor: const Color(0xFFFF9800),
                      onPressed: () => _onRating(2),
                    ),
                    RatingButton(
                      label: 'ĐƯỢC',
                      interval: '1n',
                      backgroundColor: const Color(0xFFE3F2FD),
                      textColor: const Color(0xFF2196F3),
                      onPressed: () => _onRating(3),
                    ),
                    RatingButton(
                      label: 'DỄ',
                      interval: '4n',
                      backgroundColor: const Color(0xFFE8F5E9),
                      textColor: const Color(0xFF4CAF50),
                      onPressed: () => _onRating(4),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _flipCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Hiện đáp án',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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

// ========== INLINE WIDGETS (Copy từ study_widgets.dart) ==========

class RatingButton extends StatelessWidget {
  final String label;
  final String interval;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RatingButton({
    super.key,
    required this.label,
    required this.interval,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 4),
              Text(interval, style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.8))),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final String motivationText;

  const StudyProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.motivationText = 'CỐ GẮNG LÊN!',
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tiến độ: $current/$total',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2196F3))),
            Text(motivationText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[500])),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF2196F3)),
          ),
        ),
      ],
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class StudyCardWidget extends StatelessWidget {
  final String term;
  final String definition;
  final String? imageUrl;
  final String? tag;
  final String? hint;
  final bool showAnswer;

  const StudyCardWidget({
    super.key,
    required this.term,
    required this.definition,
    this.imageUrl,
    this.tag,
    this.hint,
    this.showAnswer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageUrl != null)
            Stack(
              children: [
                ClipPath(
                  clipper: CurvedBottomClipper(),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      image: DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover),
                    ),
                  ),
                ),
                if (tag != null)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag!,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
                      ),
                    ),
                  ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  term,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(color: const Color(0xFF2196F3), borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(height: 20),
                if (showAnswer)
                  Text(
                    definition,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, height: 1.6, color: Colors.grey[700]),
                  ),
                if (showAnswer && hint != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb, color: Color(0xFF2196F3), size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            hint!,
                            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StackedCardsBackground extends StatelessWidget {
  final Widget child;

  const StackedCardsBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: 0.92,
          child: Transform.translate(
            offset: const Offset(0, -8),
            child: Container(
              height: 500,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ),
        Transform.scale(
          scale: 0.96,
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Container(
              height: 500,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class FlippableCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool showBack;

  const FlippableCard({super.key, required this.front, required this.back, required this.showBack});

  @override
  State<FlippableCard> createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(FlippableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showBack != oldWidget.showBack) {
      if (widget.showBack) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final angle = _animation.value * math.pi;
        final showFront = angle < math.pi / 2;
        
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: showFront
              ? widget.front
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(math.pi),
                  child: widget.back,
                ),
        );
      },
    );
  }
}