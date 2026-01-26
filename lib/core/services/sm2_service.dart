import 'dart:math';
import 'package:omni_card_ai/data/models/card_model.dart';

class Sm2Service {
  CardModel calculate(CardModel card, int grade) {
    // 1. Tính toán Easiness Factor (EF) mới
    double newEf = card.easinessFactor + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02));
    if (newEf < 1.3) newEf = 1.3;

    int newRep;
    int newInterval;

    // 2. Tính toán Interval (Khoảng cách ngày)
    if (grade >= 3) {
      if (card.repetition == 0) {
        newInterval = 1;
      } else if (card.repetition == 1) {
        newInterval = 6;
      } else {
        newInterval = (card.interval * newEf).round();
      }
      newRep = card.repetition + 1;
    } else {
      // Quên thẻ: Reset lộ trình
      newRep = 0;
      newInterval = 1;
    }

    // 3. Gán giá trị mới
    card.repetition = newRep;
    card.interval = newInterval;
    card.easinessFactor = newEf;
    card.nextReview = DateTime.now().add(Duration(days: newInterval));
    card.status = _determineStatus(card);
    // Đánh dấu để chuẩn bị sync Firebase sau này
    card.isDirty = true;
    card.updatedAt = DateTime.now();

    return card;
  }

  String _determineStatus(CardModel card) {
    if (card.repetition == 0) return 'learning'; // Đang học lại
    if (card.interval > 21) return 'mastered';   // Đã thuộc (interval > 3 tuần)
    return 'review';                             // Đang ôn tập
  }
}