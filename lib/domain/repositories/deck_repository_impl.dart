import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
import 'package:omni_card_ai/domain/repositories/deck_repository.dart';

class DeckRepositoryImpl implements IDeckRepository {
  final Isar isar;
  DeckRepositoryImpl(this.isar);

  @override
  Future<List<DeckModel>> getAllDecks() async {
    final decks = await isar.deckModels.where().findAll();

    for (var deck in decks) {
      await deck.cards.load();
    }

    return decks;
  }

  @override
  Future<int> saveDeck(DeckModel deck) async {
    dynamic newId;

    debugPrint('>>> BẮT ĐẦU TXN TẠI: [saveDeck]');
    await isar.writeTxn(() async {
      newId = await isar.deckModels.put(deck);
    });
    debugPrint('>>> KÊT THÚC TXN TẠI: [saveDeck]');

    return newId;
  }

  @override
  Future<void> deleteDeck(int id) async {
    debugPrint('>>> BẮT ĐẦU TXN TẠI: [deleteDeck]');
    await isar.writeTxn(() async {
      // 1. Tìm và xóa tất cả các Card thuộc bộ thẻ này trước
      // Điều này đảm bảo không còn Card nào "mồ côi" trong database
      await isar.cardModels.filter().deck((q) => q.idEqualTo(id)).deleteAll();

      // 2. Xóa chính bộ thẻ đó
      await isar.deckModels.delete(id);
    });
    debugPrint('>>> KẾT THÚC TXN TẠI: [deleteDeck]');
  }

  @override
  Future<List<DeckModel>> searchDecks(String query) async {
    if (query.isEmpty) {
      return getAllDecks();
    }
    
    final results = await isar.deckModels
        .filter()
        .titleContains(query, caseSensitive: false)
        .findAll();

    for (var deck in results) {
      await deck.cards.load();
    }
    
    return results;
  }

  @override
  Future<List<CardModel>> searchCards(String query) async {
    if (query.isEmpty) return [];
    // Full-text search đơn giản trên cả term và definition
    return await isar.cardModels
        .filter()
        .termContains(query, caseSensitive: false)
        .or()
        .definitionContains(query, caseSensitive: false)
        .findAll();
  }

  @override
  Stream<List<DeckModel>> watchDecks() {
    return isar.deckModels.where().watch(fireImmediately: true);
  }

  @override
  Stream<DeckModel?> watchDeck(int id) {
    return isar.deckModels.watchObject(id, fireImmediately: true);
  }

  @override
Future<void> addCardsToDeck(int deckId, List<CardModel> newCards) async {
  await isar.writeTxn(() async {
    final deck = await isar.deckModels.get(deckId);
    if (deck == null) return;

    // 1. Gán giá trị link trong bộ nhớ
    for (var card in newCards) {
      card.deck.value = deck; 
      card.updatedAt = DateTime.now();
      card.isDirty = true;
    }

    // 2. Lưu Card vào DB (Lúc này card sẽ có ID, nhưng Link chưa được lưu vào bảng liên kết)
    await isar.cardModels.putAll(newCards);

    // 3. BƯỚC QUAN TRỌNG CÒN THIẾU: Lưu Link thủ công
    // Thay vì put(deck) gây crash, ta lưu link từ phía Card.
    // Việc này cập nhật bảng liên kết mà không đụng chạm trực tiếp đến Deck Object,
    // giảm thiểu rủi ro kích hoạt Watcher của Deck.
    for (var card in newCards) {
      await card.deck.save(); 
    }
  });

  // 4. (Tùy chọn) Cập nhật thời gian Deck ở một Transaction RIÊNG BIỆT
  // Tách hẳn ra để đảm bảo an toàn tuyệt đối cho Transaction phía trên.
  // Nếu không cần thiết phải update ngay lập tức, bạn có thể bỏ qua bước này.
  _updateDeckTimestampSafe(deckId);
}

// Hàm phụ trợ để update timestamp an toàn
Future<void> _updateDeckTimestampSafe(int deckId) async {
  try {
    await isar.writeTxn(() async {
      final deck = await isar.deckModels.get(deckId);
      if (deck != null) {
        deck.updatedAt = DateTime.now();
        await isar.deckModels.put(deck);
      }
    });
  } catch (e) {
    // Nếu có lỗi ở đây (do UI conflict), nó cũng không ảnh hưởng đến việc tạo thẻ
    debugPrint("Update timestamp failed silently: $e");
  }
}
}