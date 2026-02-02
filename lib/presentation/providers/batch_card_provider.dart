import 'package:flutter/foundation.dart';
import 'package:omni_card_ai/presentation/create_card/widgets/card_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

part 'batch_card_provider.g.dart';

@riverpod
class BatchCardNotifier extends _$BatchCardNotifier {
  @override
  void build() {}

  Future<void> saveAll({
    required int deckId,
    required List<CardFormModel> forms,
  }) async {

    final List<CardModel> newCards = [];

    for (var f in forms) {
      final term = f.frontController.text.trim();
      final definition = f.backController.text.trim();

      final frontLang = await _detectLanguage(term);
      final backLang = await _detectLanguage(definition);
      debugPrint('Detected languages - Front: $frontLang, Back: $backLang');

      final newCard = CardModel()
        ..term = term
        ..definition = definition
        ..frontLanguage = frontLang
        ..backLanguage = backLang
        // --- THIẾT LẬP THÔNG SỐ KHỞI TẠO CHO SM-2 ---
        ..repetition = 0         // Chưa lặp lại lần nào
        ..interval = 0           // Khoảng cách ôn tập là 0 ngày
        ..easinessFactor = 2.5   // Giá trị mặc định chuẩn của thuật toán SM-2
        ..nextReview = DateTime.now() // Đặt lịch học ngay lập tức (Due Now)
        
        // --- METADATA ---
        ..status = 'new'         // Trạng thái hiển thị là Mới
        ..isDirty = true         // Đánh dấu để sync Firebase
        ..updatedAt = DateTime.now();

      newCards.add(newCard);
    }

    await ref.read(deckRepositoryProvider).addCardsToDeck(deckId, newCards);
  }

  Future<String> _detectLanguage(String text) async {
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);

    try {
      final languageCode = await languageIdentifier.identifyLanguage(text);
      return _normalizeLanguageCode(languageCode);
    } catch (e) {
      debugPrint('Language detection error: $e');
      return 'und'; // undetermined
    } finally {
      languageIdentifier.close();
    }
  }

  String _normalizeLanguageCode (String rawLang) {
    if (rawLang.toLowerCase().startsWith('en')) return 'en-US';
    if (rawLang.toLowerCase().startsWith('vi')) return 'vi-VN';
    return 'vi-VN'; 
  }
}