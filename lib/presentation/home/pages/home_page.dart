import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/app_route.dart';
// import 'home_widgets.dart'; // Import các widget components
// import 'app_theme.dart'; // Import design system

/// Home Screen chính của OmniCard AI
/// Architecture: Stateful widget sẵn sàng integrate với Riverpod/Provider
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
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
      
      // ========== FLOATING ACTION BUTTON ==========
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create new deck
          debugPrint('Create new deck');
        },
        backgroundColor: Colors.blue,
        elevation: 8,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

// ========== WIDGET COMPONENTS (Copy từ home_widgets.dart) ==========

class HomeHeader extends StatelessWidget {
  final String greeting;
  final String subtitle;
  final int streakDays;

  const HomeHeader({
    super.key,
    required this.greeting,
    required this.subtitle,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greeting, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🔥', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 4),
                Text('$streakDays CHUỖI', 
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressHero extends StatefulWidget {
  final int totalCards;
  final int newCards;
  final int reviewingCards;
  final double progress;
  final VoidCallback onStudyPressed;

  const CircularProgressHero({
    super.key,
    required this.totalCards,
    required this.newCards,
    required this.reviewingCards,
    required this.progress,
    required this.onStudyPressed,
  });

  @override
  State<CircularProgressHero> createState() => _CircularProgressHeroState();
}

class _CircularProgressHeroState extends State<CircularProgressHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.progress)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.white],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(Colors.grey.shade200),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 12,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation(Colors.blue),
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${widget.totalCards}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                    Text('THẺ CẦN HỌC', style: TextStyle(fontSize: 11, color: Colors.grey[600], letterSpacing: 1.2)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.onStudyPressed,
              icon: const Icon(Icons.play_arrow, size: 20),
              label: const Text('Học ngay'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatusChip(color: Colors.blue, label: '${widget.newCards} Mới'),
              const SizedBox(width: 16),
              _StatusChip(color: Colors.orange, label: '${widget.reviewingCards} Đang học'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final Color color;
  final String label;
  const _StatusChip({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }
}

class DeckCard extends StatelessWidget {
  final String title;
  final int remainingCards;
  final double progress;
  final Color iconBackgroundColor;
  final String emoji;
  final Color progressColor;
  final VoidCallback onTap;

  const DeckCard({
    super.key,
    required this.title,
    required this.remainingCards,
    required this.progress,
    required this.iconBackgroundColor,
    required this.emoji,
    required this.progressColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 176,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: iconBackgroundColor, borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('$remainingCards thẻ còn lại', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(progressColor),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WordOfTheDayCard extends StatelessWidget {
  final String word;
  final String translation;
  final VoidCallback onSpeakerPressed;

  const WordOfTheDayCard({
    super.key,
    required this.word,
    required this.translation,
    required this.onSpeakerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(translation, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          IconButton(
            onPressed: onSpeakerPressed,
            icon: const Icon(Icons.volume_up),
            iconSize: 24,
            color: Colors.blue,
            style: IconButton.styleFrom(backgroundColor: Colors.blue.shade50, padding: const EdgeInsets.all(12)),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;

  const SectionHeader({super.key, required this.title, this.onViewAllPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.toUpperCase(), 
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
          if (onViewAllPressed != null)
            TextButton(
              onPressed: onViewAllPressed,
              child: const Text('TẤT CẢ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}