import 'package:flutter/material.dart';
// import 'stats_widgets.dart';
// import 'stats_dummy_data.dart';

/// ============ STATISTICS SCREEN ============
/// Màn hình thống kê học tập với charts và insights
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedNavIndex = 2; // Statistics tab active
  
  // ========== LOAD DATA ==========
  late int _currentStreak;
  late int _totalCards;
  late int _weeklyTotal;
  late double _weeklyGrowth;
  late Map<String, int> _weeklyActivity;
  late Map<DateTime, int> _heatmapData;
  late Map<String, dynamic> _aiInsight;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    _currentStreak = StatsDummyData.getCurrentStreak();
    _totalCards = StatsDummyData.getTotalCards();
    _weeklyTotal = StatsDummyData.getWeeklyTotal();
    _weeklyGrowth = StatsDummyData.getWeeklyGrowth();
    _weeklyActivity = StatsDummyData.getWeeklyActivity();
    _heatmapData = StatsDummyData.getHeatmapData();
    _aiInsight = StatsDummyData.getAIInsight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== HEADER ==========
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Thống kê học tập',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        debugPrint('Open detailed stats');
                      },
                      icon: const Icon(Icons.trending_up),
                      iconSize: 24,
                      color: const Color(0xFF2196F3),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFE3F2FD),
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ),
              
              // ========== SUMMARY CARDS ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    SummaryStatCard(
                      icon: Icons.local_fire_department,
                      iconColor: const Color(0xFFFF6B35),
                      iconBgColor: const Color(0xFFFFF4ED),
                      label: 'Chuỗi hiện tại',
                      value: '$_currentStreak ngày',
                    ),
                    const SizedBox(width: 12),
                    SummaryStatCard(
                      icon: Icons.style,
                      iconColor: const Color(0xFF2196F3),
                      iconBgColor: const Color(0xFFE3F2FD),
                      label: 'Tổng thẻ',
                      value: _formatNumber(_totalCards),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // ========== WEEKLY ACTIVITY SECTION ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hoạt động tuần này',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$_weeklyTotal thẻ',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                            GrowthBadge(percentage: _weeklyGrowth),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Bar Chart
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: WeeklyBarChart(
                        data: _weeklyActivity,
                        currentDay: 'T4',
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // ========== STUDY HABITS HEATMAP ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Thói quen học tập',
                      trailing: const HeatmapLegend(),
                    ),
                    const SizedBox(height: 16),
                    
                    // Heatmap
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: StudyHeatmap(data: _heatmapData),
                    ),
                    
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Dữ liệu trong 3 tháng qua',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // ========== AI INSIGHT CARD ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AIInsightCard(
                  title: _aiInsight['title'],
                  description: _aiInsight['description'],
                  onViewDetails: () {
                    debugPrint('View AI insight details');
                  },
                ),
              ),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
  
  // Helper to format numbers (1,240 instead of 1240)
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

// ========== INLINE WIDGETS (Copy từ stats_widgets.dart) ==========

class SummaryStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final String value;

  const SummaryStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
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

class WeeklyBarChart extends StatefulWidget {
  final Map<String, int> data;
  final String currentDay;

  const WeeklyBarChart({
    super.key,
    required this.data,
    this.currentDay = 'T4',
  });

  @override
  State<WeeklyBarChart> createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = widget.data.values.reduce((a, b) => a > b ? a : b).toDouble();
    
    return SizedBox(
      height: 180,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.data.entries.map((entry) {
              final isCurrentDay = entry.key == widget.currentDay;
              final normalizedHeight = (entry.value / maxValue) * 140;
              final animatedHeight = normalizedHeight * _animation.value;
              
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: animatedHeight,
                        decoration: BoxDecoration(
                          color: isCurrentDay
                              ? const Color(0xFF2196F3)
                              : const Color(0xFFBBDEFB),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrentDay
                              ? const Color(0xFF2196F3)
                              : Colors.grey[600],
                          fontWeight: isCurrentDay
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class StudyHeatmap extends StatelessWidget {
  final Map<DateTime, int> data;

  const StudyHeatmap({super.key, required this.data});

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0: return const Color(0xFFEBEBEB);
      case 1: return const Color(0xFFC6E3FF);
      case 2: return const Color(0xFF8DC5FF);
      case 3: return const Color(0xFF54A7FF);
      case 4: return const Color(0xFF2196F3);
      default: return const Color(0xFFEBEBEB);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedDates = data.keys.toList()..sort();
    final startDate = sortedDates.first;
    final totalDays = sortedDates.last.difference(startDate).inDays + 1;
    
    return SizedBox(
      height: 140,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: totalDays,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          final intensity = data[date] ?? 0;
          
          return Container(
            decoration: BoxDecoration(
              color: _getColorForIntensity(intensity),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class GrowthBadge extends StatelessWidget {
  final double percentage;

  const GrowthBadge({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage >= 0;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPositive ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: 14,
            color: isPositive ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
          ),
          const SizedBox(width: 4),
          Text(
            '${percentage > 0 ? '+' : ''}${(percentage * 100).toInt()}% vs tuần trước',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isPositive ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }
}

class AIInsightCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onViewDetails;

  const AIInsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF9333EA), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                '?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onViewDetails,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Xem chi tiết',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14, color: Color(0xFF2196F3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Ít', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        const SizedBox(width: 6),
        ...List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _getColorForIntensity(index),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
        const SizedBox(width: 6),
        Text('Nhiều', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0: return const Color(0xFFEBEBEB);
      case 1: return const Color(0xFFC6E3FF);
      case 2: return const Color(0xFF8DC5FF);
      case 3: return const Color(0xFF54A7FF);
      case 4: return const Color(0xFF2196F3);
      default: return const Color(0xFFEBEBEB);
    }
  }
}

class StatsDummyData {
  static int getCurrentStreak() => 12;
  static int getTotalCards() => 1240;
  static int getWeeklyTotal() => 245;
  static double getWeeklyGrowth() => 0.12;
  
  static Map<String, int> getWeeklyActivity() {
    return {
      'T2': 45, 'T3': 78, 'T4': 120, 'T5': 95,
      'T6': 52, 'T7': 105, 'CN': 85,
    };
  }
  
  static Map<DateTime, int> getHeatmapData() {
    final Map<DateTime, int> heatmap = {};
    final now = DateTime.now();
    final random = DateTime.now().millisecondsSinceEpoch;
    
    for (int i = 89; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = DateTime(date.year, date.month, date.day);
      final weekday = date.weekday;
      
      int intensity;
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        intensity = ((random + i) % 3);
      } else if (weekday >= DateTime.tuesday && weekday <= DateTime.thursday) {
        intensity = 2 + ((random + i) % 3);
      } else {
        intensity = 1 + ((random + i) % 3);
      }
      
      if (((random + i * 7) % 100) < 15) intensity = 0;
      
      heatmap[dateKey] = intensity;
    }
    
    return heatmap;
  }
  
  static Map<String, dynamic> getAIInsight() {
    return {
      'title': 'Bạn học hiệu quả nhất vào sáng thứ Ba.',
      'description': 'Thử ôn tập các thẻ khó vào thời gian này để tăng khả năng ghi nhớ.',
    };
  }
}