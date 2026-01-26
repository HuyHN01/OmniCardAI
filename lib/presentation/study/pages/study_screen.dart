import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:omni_card_ai/presentation/providers/study_provider.dart';
import 'package:omni_card_ai/presentation/study/widgets/study_widgets.dart';


/// ============ STUDY SCREEN ============
/// Màn hình học flashcard với flip animation và rating
class StudyScreen extends ConsumerStatefulWidget {
  final int deckId;
  final String deckTitle;

  const StudyScreen({
    super.key,
    required this.deckId,
    required this.deckTitle
  });

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> {
  bool _showAnswer = false;
  
  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(studySessionProvider(widget.deckId));
    final notifier = ref.read(studySessionProvider(widget.deckId).notifier);

    if (sessionState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (sessionState.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.deckTitle)),
        body: const Center(child: Text("Tuyệt vời! Bạn đã hoàn thành bài học hôm nay.")),
      );
    }

    if (sessionState.isFinished) {
      _showCompletionDialog(sessionState.total);
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
                              widget.deckTitle,
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
                        showAnswer: false,
                      ),
                      showBack: _showAnswer,
                    ),
                  ),
                ),
              ),
             ),

            // ========== RATING BUTTONS ==========
            _showAnswer 
              ? Padding(padding: padding)
              : Padding(padding: padding)
          ],
        ),
      ),
    );
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