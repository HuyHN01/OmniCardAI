import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/route_name.dart';

void showCreateCardModal(
  BuildContext context, 
  {required int deckId}
  ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>  _CreateCardModalContent(deckId: deckId,),
  );
}

// --- Phần nội dung chính của Modal ---
class _CreateCardModalContent extends StatelessWidget {
  final int deckId;

  const _CreateCardModalContent({required this.deckId});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.blue; 
    final backgroundColor = Colors.white;
    final surfaceColor = const Color(0xFFF8F9FA); // Màu nền xám nhạt cho các thẻ option

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Drag Handle (Thanh nắm kéo)
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 2. Header: Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24), // Spacer để cân đối title vào giữa
              const Text(
                'Tạo thẻ mới',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                onPressed: () => context.pop(), // Đóng modal
                icon: Icon(Icons.close, color: Colors.grey[600]),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          
          const SizedBox(height: 24),

          // 3. Các lựa chọn (Option Cards)
          
          // Option 1: Quét tài liệu
          _OptionCard(
            icon: Icons.camera_alt_rounded,
            title: 'Quét tài liệu',
            subtitle: 'Chụp ảnh sách hoặc vở',
            color: primaryColor,
            surfaceColor: surfaceColor,
            onTap: () {
              context.pop();
              // TODO: Navigate to Scan Screen
              print("Selected: Scan Document");
            },
          ),
          
          const SizedBox(height: 16),

          // Option 2: Nhập văn bản AI
          _OptionCard(
            icon: Icons.auto_awesome, // Icon lấp lánh tương tự hình
            title: 'Nhập văn bản AI',
            subtitle: 'Dán văn bản để tạo thẻ tự động',
            color: primaryColor,
            surfaceColor: surfaceColor,
            isBeta: true, // Hiển thị badge BETA
            onTap: () {
              context.pop();
              // TODO: Navigate to AI Input Screen
              context.pushNamed(
                RouteName.aiGenerationCreateCard,
                pathParameters: {'deckId': deckId.toString()}
              );
              print("Selected: AI Input");
            },
          ),

          const SizedBox(height: 16),

          // Option 3: Tự nhập
          _OptionCard(
            icon: Icons.edit_note_rounded,
            title: 'Tự nhập',
            subtitle: 'Tự viết câu hỏi và trả lời',
            color: primaryColor,
            surfaceColor: surfaceColor,
            onTap: () {
              context.pop();
              // TODO: Navigate to Manual Create Screen
              context.pushNamed(
                RouteName.manualCreateCard,
                pathParameters: {'deckId': deckId.toString()}
              );
              print("Selected: Manual Input");
            },
          ),

          const SizedBox(height: 24),

          // 4. Footer Text
          Text(
            'Chọn một phương thức để bắt đầu tạo bộ thẻ ghi nhớ của bạn.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Widget: Option Card ---
class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  final Color surfaceColor;
  final bool isBeta;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
    required this.surfaceColor,
    this.isBeta = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          // Thêm border nhẹ nếu muốn giống thiết kế hơn
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Icon Circle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            
            const SizedBox(width: 16),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (isBeta) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'BETA',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow Icon
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}