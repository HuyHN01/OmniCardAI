import 'package:flutter/material.dart';
import 'package:omni_card_ai/presentation/create_card/widgets/card_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';

part 'batch_card_provider.g.dart';

@riverpod
class BatchCardNotifier extends _$BatchCardNotifier {
  @override
  void build() {}

  Future<void> saveAll({
    required int deckId,
    required List<CardFormModel> forms,
  }) async {
    // 1. Chuyển đổi dữ liệu (Mapping) chuẩn SM-2
    final newCards = forms.map((f) => CardModel()
      ..term = f.frontController.text.trim()
      ..definition = f.backController.text.trim()
      
      // --- THIẾT LẬP THÔNG SỐ KHỞI TẠO CHO SM-2 ---
      ..repetition = 0         // Chưa lặp lại lần nào
      ..interval = 0           // Khoảng cách ôn tập là 0 ngày
      ..easinessFactor = 2.5   // Giá trị mặc định chuẩn của thuật toán SM-2
      ..nextReview = DateTime.now() // Đặt lịch học ngay lập tức (Due Now)
      
      // --- METADATA ---
      ..status = 'new'         // Trạng thái hiển thị là Mới
      ..isDirty = true         // Đánh dấu để sync Firebase
      ..updatedAt = DateTime.now()
    ).toList();

    // 2. Gọi Repository để lưu hàng loạt
    await ref.read(deckRepositoryProvider).addCardsToDeck(deckId, newCards);
  }
}