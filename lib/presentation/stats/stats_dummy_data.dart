import 'dart:math';

/// ============ DUMMY DATA GENERATOR ============
/// Tạo data giả cho các charts trong Statistics Screen, SAU NÀY SẼ XÓA KHI CÓ DỮ LIỆU THẬT.
class StatsDummyData {
  static final Random _random = Random();
  
  // ========== SUMMARY STATS ==========
  static int getCurrentStreak() => 12;
  static int getTotalCards() => 1240;
  
  // ========== WEEKLY ACTIVITY ==========
  static int getWeeklyTotal() => 245;
  static double getWeeklyGrowth() => 0.12; // 12%
  
  static Map<String, int> getWeeklyActivity() {
    return {
      'T2': 45,   // Thứ 2
      'T3': 78,   // Thứ 3
      'T4': 120,  // Thứ 4 (highest - current day)
      'T5': 95,   // Thứ 5
      'T6': 52,   // Thứ 6
      'T7': 105,  // Thứ 7
      'CN': 85,   // Chủ nhật
    };
  }
  
  // ========== HEATMAP DATA (3 months) ==========
  /// Trả về Map<DateTime, int> với intensity từ 0-4
  /// 0 = không học, 4 = học nhiều nhất
  static Map<DateTime, int> getHeatmapData() {
    final Map<DateTime, int> heatmap = {};
    final now = DateTime.now();
    
    // Generate data cho 90 ngày gần nhất
    for (int i = 89; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = DateTime(date.year, date.month, date.day);
      
      // Tạo pattern realistic:
      // - Ít học vào cuối tuần (Sat/Sun)
      // - Nhiều học vào giữa tuần (Tue-Thu)
      final weekday = date.weekday;
      int intensity;
      
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        // Weekend: 0-2
        intensity = _random.nextInt(3);
      } else if (weekday >= DateTime.tuesday && weekday <= DateTime.thursday) {
        // Mid-week: 2-4
        intensity = 2 + _random.nextInt(3);
      } else {
        // Mon/Fri: 1-3
        intensity = 1 + _random.nextInt(3);
      }
      
      // Random skip một số ngày (không học)
      if (_random.nextDouble() < 0.15) {
        intensity = 0;
      }
      
      heatmap[dateKey] = intensity;
    }
    
    return heatmap;
  }
  
  // ========== AI INSIGHTS ==========
  static Map<String, dynamic> getAIInsight() {
    return {
      'title': 'Bạn học hiệu quả nhất vào sáng thứ Ba.',
      'description': 'Thử ôn tập các thẻ khó vào thời gian này để tăng khả năng ghi nhớ.',
      'icon': '🧠',
      'confidence': 0.85, // 85% confidence
    };
  }
  
  // ========== MONTHLY STATS (cho future use) ==========
  static List<Map<String, dynamic>> getMonthlyStats() {
    return [
      {'month': 'T1', 'cards': 850, 'time': 12.5}, // Tháng 1
      {'month': 'T2', 'cards': 920, 'time': 14.2},
      {'month': 'T3', 'cards': 1100, 'time': 16.8},
      {'month': 'T4', 'cards': 1240, 'time': 18.3}, // Current month
    ];
  }
  
  // ========== STUDY TIME DISTRIBUTION ==========
  static Map<String, double> getTimeDistribution() {
    return {
      '6-9h': 0.15,   // Sáng sớm
      '9-12h': 0.35,  // Buổi sáng (peak)
      '12-15h': 0.10, // Buổi trưa
      '15-18h': 0.20, // Chiều
      '18-21h': 0.15, // Tối
      '21-24h': 0.05, // Đêm
    };
  }
  
  // ========== DECK PERFORMANCE ==========
  static List<Map<String, dynamic>> getDeckPerformance() {
    return [
      {
        'name': 'Tiếng Tây Ban Nha',
        'accuracy': 0.75,
        'cardsStudied': 45,
        'trend': 'up',
      },
      {
        'name': 'Thuật ngữ Y khoa',
        'accuracy': 0.62,
        'cardsStudied': 120,
        'trend': 'down',
      },
      {
        'name': 'Khoa học Máy tính',
        'accuracy': 0.88,
        'cardsStudied': 85,
        'trend': 'up',
      },
    ];
  }
}