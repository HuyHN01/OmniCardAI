import 'package:flutter/material.dart';
// import 'profile_widgets.dart';

/// ============ PROFILE SCREEN ============
/// Màn hình cá nhân với settings và thông tin user
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  
  // ========== USER DATA (Mock) ==========
  final String _userName = 'Nguyễn Văn A';
  final String _memberSince = 'Thành viên từ 2023';
  final bool _isPro = true;
  final int _notificationCount = 2;

  // ========== ACTIONS ==========
  void _onEditProfile() {
    debugPrint('Edit profile');
    // TODO: Navigate to edit profile screen
  }

  void _onEditAvatar() {
    debugPrint('Edit avatar');
    // TODO: Show image picker
  }

  void _onSyncData() {
    debugPrint('Sync data');
    // TODO: Trigger data sync
  }

  void _onToggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    debugPrint('Dark mode: $value');
    // TODO: Update theme
  }

  void _onNotifications() {
    debugPrint('Open notifications');
    // TODO: Navigate to notifications screen
  }

  void _onAccountInfo() {
    debugPrint('Open account info');
    // TODO: Navigate to account info screen
  }

  void _onLogout() {
    showLogoutConfirmation(context, () {
      debugPrint('User logged out');
      // TODO: Clear auth state and navigate to login
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cá nhân',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _onEditProfile,
            child: const Text(
              'Sửa',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2196F3),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              
              // ========== USER INFO SECTION ==========
              ProfileAvatar(
                onEditPressed: _onEditAvatar,
              ),
              const SizedBox(height: 16),
              
              // User Name
              Text(
                _userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              
              // Pro Badge
              if (_isPro) const ProMemberBadge(),
              const SizedBox(height: 8),
              
              // Member Since
              Text(
                _memberSince,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // ========== SETTINGS SECTION ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileSectionHeader(title: 'Cài đặt chung'),
                    
                    // Đồng bộ dữ liệu
                    ProfileMenuTile(
                      icon: Icons.sync,
                      title: 'Đồng bộ dữ liệu',
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF9CA3AF),
                        size: 20,
                      ),
                      onTap: _onSyncData,
                    ),
                    
                    // Giao diện Tối
                    ProfileMenuTile(
                      icon: Icons.dark_mode,
                      title: 'Giao diện Tối',
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: _onToggleDarkMode,
                        activeColor: const Color(0xFF2196F3),
                      ),
                      onTap: () {
                        setState(() {
                          _isDarkMode = !_isDarkMode;
                        });
                        _onToggleDarkMode(_isDarkMode);
                      },
                    ),
                    
                    // Thông báo
                    ProfileMenuTile(
                      icon: Icons.notifications,
                      title: 'Thông báo',
                      trailing: NotificationBadge(count: _notificationCount),
                      onTap: _onNotifications,
                    ),
                    
                    // Thông tin tài khoản
                    ProfileMenuTile(
                      icon: Icons.person,
                      title: 'Thông tin tài khoản',
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF9CA3AF),
                        size: 20,
                      ),
                      onTap: _onAccountInfo,
                    ),
                    
                    // Đăng xuất
                    LogoutButton(onPressed: _onLogout),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ========== INLINE WIDGETS (Copy từ profile_widgets.dart) ==========

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onEditPressed;
  final double size;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    required this.onEditPressed,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFB8D5C8),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar())
                : _buildDefaultAvatar(),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditPressed,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.edit, color: Color(0xFF2196F3), size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: const Color(0xFFB8D5C8),
      child: Center(
        child: Icon(Icons.person, size: size * 0.5, color: const Color(0xFF6B8F7A)),
      ),
    );
  }
}

class ProMemberBadge extends StatelessWidget {
  const ProMemberBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text(
            'PRO MEMBER',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Icon(icon, color: iconColor ?? const Color(0xFF111827), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: titleColor ?? const Color(0xFF111827),
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int count;

  const NotificationBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE53935),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 20),
      ],
    );
  }
}

class ProfileSectionHeader extends StatelessWidget {
  final String title;

  const ProfileSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, top: 24),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Đăng xuất',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE53935),
          ),
        ),
      ),
    );
  }
}

void showLogoutConfirmation(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Đăng xuất', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      content: const Text(
        'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?',
        style: TextStyle(fontSize: 15),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Hủy', style: TextStyle(fontSize: 15, color: Colors.grey[700])),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: const Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFFE53935)),
          ),
        ),
      ],
    ),
  );
}