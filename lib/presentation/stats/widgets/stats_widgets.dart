import 'package:flutter/material.dart';
import 'dart:math' as math;

/// ============ SUMMARY STAT CARD ============
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
            // Icon
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
            
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            
            // Value
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

/// ============ WEEKLY BAR CHART (without fl_chart dependency) ============
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
    final maxValue = widget.data.values.reduce(math.max).toDouble();
    
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
                      // Bar
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
                      
                      // Label
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

/// ============ HEATMAP CALENDAR ============
class StudyHeatmap extends StatelessWidget {
  final Map<DateTime, int> data;

  const StudyHeatmap({super.key, required this.data});

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0:
        return const Color(0xFFEBEBEB);
      case 1:
        return const Color(0xFFC6E3FF);
      case 2:
        return const Color(0xFF8DC5FF);
      case 3:
        return const Color(0xFF54A7FF);
      case 4:
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFFEBEBEB);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort dates
    final sortedDates = data.keys.toList()..sort();
    final startDate = sortedDates.first;
    final endDate = sortedDates.last;
    
    // Calculate weeks needed
    final totalDays = endDate.difference(startDate).inDays + 1;
    final weeks = (totalDays / 7).ceil();
    
    return SizedBox(
      height: 140,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 7 days per week
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

/// ============ SECTION HEADER ============
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// ============ GROWTH BADGE ============
class GrowthBadge extends StatelessWidget {
  final double percentage;
  final String comparison;

  const GrowthBadge({
    super.key,
    required this.percentage,
    this.comparison = 'vs tuần trước',
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage >= 0;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPositive
            ? const Color(0xFFDCFCE7)
            : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: 14,
            color: isPositive
                ? const Color(0xFF16A34A)
                : const Color(0xFFDC2626),
          ),
          const SizedBox(width: 4),
          Text(
            '${percentage > 0 ? '+' : ''}${(percentage * 100).toInt()}% $comparison',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isPositive
                  ? const Color(0xFF16A34A)
                  : const Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============ AI INSIGHT CARD ============
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
          // Icon with gradient
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF9333EA),
                  Color(0xFF3B82F6),
                ],
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
          
          // Content
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
                
                // View details link
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
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Color(0xFF2196F3),
                      ),
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

/// ============ HEATMAP LEGEND ============
class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ít',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
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
        Text(
          'Nhiều',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0:
        return const Color(0xFFEBEBEB);
      case 1:
        return const Color(0xFFC6E3FF);
      case 2:
        return const Color(0xFF8DC5FF);
      case 3:
        return const Color(0xFF54A7FF);
      case 4:
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFFEBEBEB);
    }
  }
}