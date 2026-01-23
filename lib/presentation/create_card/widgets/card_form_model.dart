// ========== CARD FORM MODEL==========
//CardFormModel là UI State Model — tức là: Nó tồn tại để phục vụ màn hình nhập liệu (form), không phải để lưu DB.
import 'package:flutter/material.dart';

class CardFormModel {
  final String id;
  final TextEditingController frontController;
  final TextEditingController backController;
  final FocusNode frontFocusNode;
  final FocusNode backFocusNode;

  CardFormModel({
    String? id,
    String? initialFront,
    String? initialBack,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        frontController = TextEditingController(text: initialFront),
        backController = TextEditingController(text: initialBack),
        frontFocusNode = FocusNode(),
        backFocusNode = FocusNode();

  bool get hasContent {
    return frontController.text.trim().isNotEmpty ||
        backController.text.trim().isNotEmpty;
  }

  bool get isComplete {
    return frontController.text.trim().isNotEmpty &&
        backController.text.trim().isNotEmpty;
  }

  Map<String, String> toMap() {
    return {
      'front': frontController.text.trim(),
      'back': backController.text.trim(),
    };
  }

  void dispose() {
    frontController.dispose();
    backController.dispose();
    frontFocusNode.dispose();
    backFocusNode.dispose();
  }
}