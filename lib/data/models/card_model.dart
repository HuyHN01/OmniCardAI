import 'package:isar_community/isar.dart';
import 'deck_model.dart';
part 'card_model.g.dart';

@collection
class CardModel {
  Id id = Isar.autoIncrement;

  //@Index(unique: true, replace: true)
  @Index()
  String? remoteId; // UID từ Firebase

  @Index(type: IndexType.value, caseSensitive: false)
  late String term; // Thuật ngữ

  @Index(type: IndexType.value, caseSensitive: false)
  late String definition; // Định nghĩa

  String? mnemonic; // Gợi ý ghi nhớ

  // Thuật toán SRS
  int stability = 0;
  int difficulty = 0;
  DateTime nextReview = DateTime.now();

  // Sync Metadata
  DateTime updatedAt = DateTime.now();
  bool isDirty = true; //Báo hiệu rằng bản ghi hiện tại mới hơn bản ghi trên firebase

  final deck = IsarLink<DeckModel>();
}