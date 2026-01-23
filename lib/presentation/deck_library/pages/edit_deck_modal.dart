import 'package:flutter/material.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';

/// ============ EDIT DECK BOTTOM SHEET ============
/// Modern bottom sheet để edit deck thay vì AlertDialog
class EditDeckBottomSheet extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;
  final Function(String title, String description) onSave;

  const EditDeckBottomSheet({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
    required this.onSave,
  });

  @override
  State<EditDeckBottomSheet> createState() => _EditDeckBottomSheetState();
}

class _EditDeckBottomSheetState extends State<EditDeckBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tiêu đề';
    }
    if (value.trim().length < 3) {
      return 'Tiêu đề phải có ít nhất 3 ký tự';
    }
    return null;
  }

  Future<void> _onSave() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onSave(
        _titleController.text.trim(),
        _descController.text.trim(),
      );

      if (!mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Đã lưu thay đổi'),
          backgroundColor: AppTheme.accentGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusXL),
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========== HEADER ==========
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Chỉnh sửa bộ thẻ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        color: AppTheme.textSecondary,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // ========== TIÊU ĐỀ ==========
                  const Text(
                    'Tiêu đề',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingS),

                  TextFormField(
                    controller: _titleController,
                    validator: _validateTitle,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'VD: Tiếng Anh Giao Tiếp',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: AppTheme.textSecondary.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryBlue,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // ========== MÔ TẢ ==========
                  Row(
                    children: [
                      const Text(
                        'Mô tả',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(không bắt buộc)',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingS),

                  TextFormField(
                    controller: _descController,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                    minLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Mô tả ngắn gọn về bộ thẻ này...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary.withOpacity(0.5),
                        height: 1.5,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusM),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryBlue,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingXL),

                  // ========== ACTION BUTTONS ==========
                  Row(
                    children: [
                      // Hủy button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusM),
                            ),
                            side: BorderSide(
                              color: AppTheme.borderColor,
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            'Hủy',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: AppTheme.spacingM),

                      // Lưu button
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusM),
                            ),
                            elevation: 0,
                            disabledBackgroundColor:
                                AppTheme.primaryBlue.withOpacity(0.5),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Lưu thay đổi',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),

                  // Bottom padding for keyboard
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? AppTheme.spacingM
                        : 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ============ HELPER FUNCTION ============
/// Show edit deck bottom sheet
void showEditDeckModal(
  BuildContext context, {
  required String initialTitle,
  required String initialDescription,
  required Future<void> Function(String title, String description) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => EditDeckBottomSheet(
      initialTitle: initialTitle,
      initialDescription: initialDescription,
      onSave: onSave,
    ),
  );
}