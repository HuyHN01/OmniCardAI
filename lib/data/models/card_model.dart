import 'package:isar_community/isar.dart';
import 'deck_model.dart';
part 'card_model.g.dart';

@collection
class CardModel {
  Id id = Isar.autoIncrement;

  @Index()
  String? remoteId;

  @Index(type: IndexType.value, caseSensitive: false)
  late String term;

  @Index(type: IndexType.value, caseSensitive: false)
  late String definition;

  String? mnemonic;

   // ========== PHỤC VỤ TÍNH NĂNG TEXT-TO-SPEECH ==========
  String frontLanguage = 'vi-VN'; // Mặc định là tiếng Việt
  String backLanguage = 'vi-VN'; // Mặc định là tiếng Việt
  bool isAutoPlayEnabled = false;

  // ========== SM-2 FIELDS ==========
  int repetition = 0;
  double easinessFactor = 2.5;
  int interval = 0;

  @Index()
  DateTime nextReview = DateTime.now();

  // ========== SYNC METADATA ==========
  String status = 'new';
  DateTime updatedAt = DateTime.now();
  bool isDirty = true;

  final deck = IsarLink<DeckModel>();
}