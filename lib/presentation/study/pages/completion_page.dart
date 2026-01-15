import 'package:flutter/material.dart';
import '../widgets/stat_chip.dart'; // Import widget vừa tạo ở trên

class CompletionPage extends StatefulWidget {
  const CompletionPage({super.key});

  @override
  State<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends State<CompletionPage> {
  // Biến trạng thái để kích hoạt animation sau khi build xong
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    // Kích hoạt animation sau khi frame đầu tiên được render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Định nghĩa màu sắc theo thiết kế
    const primaryBlue = Color(0xFF2196F3);
    const textDark = Color(0xFF2D3339);
    const textGrey = Color(0xFF757575);
    
    // Màu cho Chip
    const xpBg = Color(0xFFE3F2FD); // Xanh dương nhạt
    const xpContent = Color(0xFF1976D2); // Xanh dương đậm
    const accBg = Color(0xFFE8F5E9); // Xanh lá nhạt
    const accContent = Color(0xFF388E3C); // Xanh lá đậm

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // --- 1. Animated Trophy Illustration ---
            AnimatedScale(
              scale: _startAnimation ? 1.0 : 0.5,
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut, // Hiệu ứng nảy sinh động
              child: AnimatedOpacity(
                opacity: _startAnimation ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Giả lập hiệu ứng nền xanh mờ sau lưng cúp (Radial Gradient)
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF2E7D32).withOpacity(0.2), // Xanh lá mờ tâm
                        Colors.white.withOpacity(0), // Ra ngoài thì trong suốt
                      ],
                      radius: 0.7,
                    ),
                  ),
                  alignment: Alignment.center,
                  // TODO: Thay thế Icon này bằng Image.asset('assets/images/trophy_3d.png')
                  child: const Icon(
                    Icons.emoji_events_rounded, // Placeholder icon Cúp
                    size: 160,
                    color: Color(0xFFFFD700), // Màu vàng Gold
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 2. Success Text ---
            AnimatedOpacity(
              opacity: _startAnimation ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
              child: Column(
                children: [
                  const Text(
                    'Xuất sắc!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: textDark,
                      fontFamily: 'Inter', // Giả sử dùng font Inter
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bạn đã hoàn thành bài học hôm nay.',
                    style: TextStyle(
                      fontSize: 16,
                      color: textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- 3. Stats Chips (XP & Accuracy) ---
            // Dùng Transform để tạo hiệu ứng trượt nhẹ từ dưới lên
            AnimatedSlide(
              offset: _startAnimation ? Offset.zero : const Offset(0, 0.5),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatChip(
                    icon: Icons.bolt_rounded,
                    label: '+50 XP',
                    backgroundColor: xpBg,
                    contentColor: xpContent,
                  ),
                  SizedBox(width: 16),
                  StatChip(
                    icon: Icons.track_changes_rounded, // Icon bia ngắm
                    label: '100% Accuracy',
                    backgroundColor: accBg,
                    contentColor: accContent,
                  ),
                ],
              ),
            ),

            const Spacer(flex: 3),

            // --- 4. Bottom Action Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Điều hướng về trang chủ
                    // context.go('/home'); // Sử dụng GoRouter
                    Navigator.of(context).pop(); // Hoặc pop nếu là modal
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: primaryBlue.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Về trang chủ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}