import 'package:flutter/material.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/presentation/providers/deck_provider.dart';

/// ============ CREATE DECK SCREEN ============
/// Màn hình tạo bộ thẻ mới với form validation
class CreateDeckScreen extends ConsumerStatefulWidget  {
  const CreateDeckScreen({super.key});

  @override
  ConsumerState<CreateDeckScreen> createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends ConsumerState<CreateDeckScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ========== VALIDATION ==========
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên bộ thẻ';
    }
    if (value.trim().length < 3) {
      return 'Tên bộ thẻ phải có ít nhất 3 ký tự';
    }
    return null;
  }

  // ========== ACTIONS ==========
  void _onClose() {
    // Check if has unsaved changes
    if (_nameController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hủy tạo bộ thẻ?'),
          content: const Text('Thông tin bạn đã nhập sẽ không được lưu.'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tiếp tục chỉnh sửa'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close screen
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _onCreateDeck() async {
    try {
      // Dismiss keyboard
      FocusScope.of(context).unfocus();

      if (!_formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        _isCreating = true;
      });

      // TODO: Integrate with Riverpod/Provider
      // Example:
      final deckName = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      await ref
          .read(deckNotifierProvider.notifier)
          .addDeck(deckName, description);

      // Simulate API call
      //await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      setState(() {
        _isCreating = false;
      });

      // Show success and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã tạo bộ thẻ "${_nameController.text.trim()}"'),
          backgroundColor: AppTheme.accentGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
        ),
      );

      Navigator.pop(context, {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
      });
    } 
    catch (e) {
      print("LỖI KHI LƯU: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          onPressed: _onClose,
          icon: const Icon(Icons.close, color: AppTheme.textPrimary),
        ),
        title: const Text(
          'Tạo bộ thẻ mới',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========== HEADER ICON ==========
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlueLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.style,
                      size: 50,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // ========== TÊN BỘ THẺ ==========
                const Text(
                  'Tên bộ thẻ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingM),

                TextFormField(
                  controller: _nameController,
                  validator: _validateName,
                  textInputAction: TextInputAction.next,
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
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: const BorderSide(
                        color: AppTheme.primaryBlue,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingL),

                // ========== MÔ TẢ ==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mô tả',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      '(Tùy chọn)',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingM),

                TextFormField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.done,
                  maxLines: 6,
                  minLines: 4,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        'Nhập mô tả ngắn gọn về bộ thẻ này... Ví dụ: 100 từ vựng thông dụng nhất.',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary.withOpacity(0.5),
                      height: 1.5,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                      borderSide: const BorderSide(
                        color: AppTheme.primaryBlue,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL * 2),

                // ========== CREATE BUTTON ==========
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isCreating ? null : _onCreateDeck,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      shadowColor: AppTheme.primaryBlue.withOpacity(0.4),
                      disabledBackgroundColor:
                          AppTheme.primaryBlue.withOpacity(0.5),
                    ),
                    child: _isCreating
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Tạo bộ thẻ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
