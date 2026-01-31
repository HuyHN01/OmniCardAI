import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/route_name.dart';
import 'package:omni_card_ai/presentation/providers/deck_detail_provider.dart';
import 'package:omni_card_ai/presentation/providers/study_provider.dart';
import 'package:omni_card_ai/presentation/study/widgets/study_widgets.dart';


/// ============ STUDY SCREEN ============
/// Màn hình học flashcard với flip animation và rating
class StudyScreen extends ConsumerStatefulWidget {
  final int deckId;

  const StudyScreen({
    super.key,
    required this.deckId,
  });

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> {
  bool _showAnswer = false;
  
  @override
  Widget build(BuildContext context) {
    final deckAsync = ref.watch(deckDetailProvider(widget.deckId));
    final sessionState = ref.watch(studySessionProvider(widget.deckId));
    final notifier = ref.read(studySessionProvider(widget.deckId).notifier);

    ref.listen<StudySessionState>(
      studySessionProvider(widget.deckId),
      (previous, next) {
        // Chỉ hiện dialog khi trạng thái chuyển từ "chưa xong" sang "xong"
        if (!previous!.isFinished && next.isFinished) {
          // Dùng microtask để đảm bảo việc vẽ UI hoàn tất trước khi hiện dialog
          Future.microtask(() {
            context.pop();
            context.pushNamed( 
              RouteName.completeStudy,
              pathParameters: {'deckId': widget.deckId.toString()},
            );
          });
        }
      },
    );

    if (sessionState.isLoading || deckAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (deckAsync.hasError || !deckAsync.hasValue || deckAsync.value == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("Không tìm thấy bộ thẻ!")),
      );
    }
    
    final deck = deckAsync.value!;

    if (sessionState.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(deck.title)), // Dùng title từ DeckModel
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                "Đã hoàn thành!",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text("Không còn thẻ nào cần học trong bộ này."),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text("Quay lại"),
              )
            ],
          ),
        ),
      );
    }

    final currentCard = sessionState.currentCard!;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _onClose, 
                        icon: const Icon(Icons.close)
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'BỘ THẺ HIỆN TẠI',
                              style: TextStyle(
                                fontSize: 11,
                                color:Colors.grey[600],
                                letterSpacing: 0.5
                              )
                            ),
                            const SizedBox(height: 4,),
                            Text(
                              deck.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ),
                      IconButton(
                        onPressed: () {/*Mở Menu Setting giao diện học*/},
                        icon: const Icon(Icons.more_horiz, size: 28,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),

                  //Progres bar
                  StudyProgressBar(
                    current: sessionState.progress,
                    total: sessionState.total,
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
                      front: StudyCardWidget(
                        term: currentCard.term, 
                        definition: currentCard.definition,
                        imageUrl: '' ,//Bổ sung field image url
                        tag: '' ,//Bổ sung field tab
                        hint: currentCard.mnemonic ,
                        showAnswer: false,
                      ), 
                      back: StudyCardWidget(
                        term: currentCard.term, 
                        definition: currentCard.definition,
                        imageUrl: '' ,//Bổ sung field image url
                        tag: '' ,//Bổ sung field tab
                        hint: currentCard.mnemonic,
                        showAnswer: true,
                      ),
                      showBack: _showAnswer,
                    ),
                  ),
                ),
              ),
             ),

            // ========== RATING BUTTONS ==========
            _showAnswer 
              ? Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    // MAPPING: 1 (Quên) -> 2 (Khó) -> 3 (Được) -> 4 (Dễ) -> 5 (Rất dễ)
                    // Trong SM-2, Grade < 3 là Fail. Nên ta map:
                    // Quên -> 1
                    // Khó -> 3
                    // Được -> 4
                    // Dễ -> 5
                    RatingButton(
                      label: 'QUÊN', 
                      interval: '< 1p', //TODO:Hiển thị interval dự kiến thực tế từ SM2 
                      backgroundColor: const Color(0xFFFFEBEE), 
                      textColor: const Color(0xFFE53935), 
                      onPressed: () => _handleRating(notifier, 1)
                    ),
                    RatingButton(
                      label: 'KHÓ',
                      interval: '1p',
                      backgroundColor: const Color(0xFFFFF3E0),
                      textColor: const Color(0xFFFF9800),
                      onPressed: () => _handleRating(notifier, 3),
                    ),
                    RatingButton(
                      label: 'ĐƯỢC',
                      interval: '3n',
                      backgroundColor: const Color(0xFFE3F2FD),
                      textColor: const Color(0xFF2196F3),
                      onPressed: () => _handleRating(notifier, 4),
                    ),
                    RatingButton(
                      label: 'DỄ',
                      interval: '7n',
                      backgroundColor: const Color(0xFFE8F5E9),
                      textColor: const Color(0xFF4CAF50),
                      onPressed: () => _handleRating(notifier, 5),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _flipCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16)
                      )
                    ),
                    child: const Text(
                      'Hiện đáp án',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _handleRating(StudyNotifier notifier, int rating) async {
    try {
      // Show loading nếu cần thiết (optional)
      
      // 1. Chờ DB lưu xong và StateNotifier cập nhật Index mới
      await notifier.rateCard(rating); 

      // 2. Sau khi dữ liệu đã là thẻ mới, ta mới update UI
      if (mounted) {
        setState(() {
          _showAnswer = false; // Reset về mặt trước -> Lúc này FlippableCard sẽ hiện mặt trước của THẺ MỚI
        });
      }
    } catch (e) {
      debugPrint("Lỗi khi đánh giá thẻ: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi lưu kết quả: $e")),
      );
    }
  }

  void _showCompletionDialog(int numberOfCardsDone) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Hoàn thành!'),
        content: Text('Bạn đã học xong $numberOfCardsDone thẻ.'),
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

  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }
}