import 'package:isar_community/isar.dart';
import 'card_model.dart';

part 'deck_model.g.dart';

@collection
class DeckModel {
  Id id = Isar.autoIncrement;

  //@Index(unique: true, replace: true) Chưa có dữ liệu từ Firebase nên remoteId luôn là null, tạm thời bỏ qua thuộc tính Unique
  @Index()
  String? remoteId;

  @Index(caseSensitive: false)
  late String title;
  
  String? description;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  bool isDirty = true;

  @Backlink(to: 'deck')
  final cards = IsarLinks<CardModel>();

  int get countCard => cards.length;

  double get calculateProgres {
    if (cards.isEmpty) return 0;

    final masteredCards = cards.where((card) => card.status == 'mastered').length;

    return masteredCards / cards.length;
  }

  bool get isNewDeck {
    return DateTime.now().difference(createdAt).inHours < 24;
  }
}