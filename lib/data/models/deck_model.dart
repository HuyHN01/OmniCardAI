import 'package:isar_community/isar.dart';
import 'card_model.dart';

part 'deck_model.g.dart';

@collection
class DeckModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index(caseSensitive: false)
  late String title;
  
  String? description;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  bool isDirty = true;

  @Backlink(to: 'deck')
  final cards = IsarLinks<CardModel>();
}