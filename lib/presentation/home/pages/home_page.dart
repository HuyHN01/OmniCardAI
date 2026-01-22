import 'package:flutter/material.dart';
import 'package:omni_card_ai/presentation/home/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // ========== MOCK DATA (sẽ thay bằng Provider/Riverpod sau) ==========
  final int _streakDays = 12;
  final int _totalCards = 42;
  final int _newCards = 10;
  final int _reviewingCards = 32;
  final double _progress = 0.7; // 70% completed
  
  final List<Map<String, dynamic>> _recentDecks = [
    {
      'title': 'IELTS Speaking',
      'remaining': 18,
      'progress': 0.6,
      'emoji': '🎧',
      'bgColor': Colors.blue.shade100,
      'progressColor': Colors.blue,
    },
    {
      'title': 'Sinh học',
      'remaining': 5,
      'progress': 0.8,
      'emoji': '🧪',
      'bgColor': Colors.green.shade100,
      'progressColor': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ========== HEADER ==========
            SliverToBoxAdapter(
              child: HomeHeader(
                greeting: 'Xin chào!',
                subtitle: 'Bạn đã sẵn sàng học chưa?',
                streakDays: _streakDays,
              ),
            ),
            
            // ========== HERO SECTION ==========
            SliverToBoxAdapter(
              child: CircularProgressHero(
                totalCards: _totalCards,
                newCards: _newCards,
                reviewingCards: _reviewingCards,
                progress: _progress,
                onStudyPressed: () {
                  // TODO: Navigate to study session
                  debugPrint('Start studying!');
                },
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            
            // ========== RECENT DECKS SECTION ==========
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Tiếp tục học',
                onViewAllPressed: () {
                  // TODO: Navigate to all decks
                  debugPrint('View all decks');
                },
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _recentDecks.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final deck = _recentDecks[index];
                    return DeckCard(
                      title: deck['title'],
                      remainingCards: deck['remaining'],
                      progress: deck['progress'],
                      emoji: deck['emoji'],
                      iconBackgroundColor: deck['bgColor'],
                      progressColor: deck['progressColor'],
                      onTap: () {
                        // TODO: Navigate to deck details
                        debugPrint('Tapped on ${deck['title']}');
                      },
                    );
                  },
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            
            // ========== WORD OF THE DAY ==========
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Từ vựng hôm nay',
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: WordOfTheDayCard(
                  word: 'Serendipity',
                  translation: 'Sự tình cờ may mắn',
                  onSpeakerPressed: () {
                    // TODO: Play pronunciation
                    debugPrint('Play audio');
                  },
                ),
              ),
            ),
            
            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}