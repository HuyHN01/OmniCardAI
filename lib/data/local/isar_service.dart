import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:omni_card_ai/data/models/deck_model.dart';
import 'package:omni_card_ai/data/models/card_model.dart';


class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [DeckModelSchema, CardModelSchema],
      directory: dir.path,
    );
  }
}
