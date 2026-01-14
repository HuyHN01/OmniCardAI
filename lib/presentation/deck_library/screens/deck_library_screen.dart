import 'package:flutter/material.dart';
// import 'deck_library_widgets.dart';

/// ============ DECK LIBRARY SCREEN ============
/// Màn hình thư viện hiển thị tất cả các bộ thẻ của user
/// Có search functionality và filter options
class DeckLibraryScreen extends StatefulWidget {
  const DeckLibraryScreen({super.key});

  @override
  State<DeckLibraryScreen> createState() => _DeckLibraryScreenState();
}

class _DeckLibraryScreenState extends State<DeckLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedNavIndex = 1; // Library tab active
  
  // ========== MOCK DATA (Replace with Provider/Riverpod) ==========
  final List<Map<String, dynamic>> _allDecks = [
    {
      'title': 'Tiếng Tây Ban Nha Cơ Bản',
      'cardCount': 45,
      'progress': 0.75,
      'isNew': false,
    },
    {
      'title': 'Thuật ngữ Y khoa',
      'cardCount': 120,
      'progress': 0.10,
      'isNew': false,
    },
    {
      'title': 'Lịch sử Thế giới 101',
      'cardCount': 30,
      'progress': null,
      'isNew': true,
    },
    {
      'title': 'Khoa học Máy tính',
      'cardCount': 85,
      'progress': 0.42,
      'isNew': false,
    },
  ];
  
  List<Map<String, dynamic>> _filteredDecks = [];
  
  @override
  void initState() {
    super.initState();
    _filteredDecks = List.from(_allDecks);
    _searchController.addListener(_filterDecks);
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  // ========== SEARCH FILTER ==========
  void _filterDecks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredDecks = List.from(_allDecks);
      } else {
        _filteredDecks = _allDecks.where((deck) {
          return deck['title'].toString().toLowerCase().contains(query);
        }).toList();
      }
    });
  }
  
  // ========== NAVIGATION ==========
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
    // TODO: Navigate to other screens
    debugPrint('Navigate to tab $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // ========== HEADER ==========
            LibraryHeader(
              onSettingsPressed: () {
                debugPrint('Open settings');
              },
            ),
            
            // ========== SEARCH BAR ==========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LibrarySearchBar(
                controller: _searchController,
                onChanged: (value) {
                  // Filter được handle bởi listener
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // ========== DECK LIST ==========
            Expanded(
              child: _filteredDecks.isEmpty
                  ? EmptyLibraryState(
                      message: _searchController.text.isEmpty
                          ? 'Chưa có bộ thẻ nào'
                          : 'Không tìm thấy kết quả',
                      subtitle: _searchController.text.isEmpty
                          ? 'Nhấn nút + để tạo bộ thẻ đầu tiên'
                          : 'Thử tìm với từ khóa khác',
                      icon: _searchController.text.isEmpty
                          ? Icons.inbox_outlined
                          : Icons.search_off,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: _filteredDecks.length + 1, // +1 for footer
                      itemBuilder: (context, index) {
                        // Footer encouragement
                        if (index == _filteredDecks.length) {
                          return const EncouragementFooter();
                        }
                        
                        final deck = _filteredDecks[index];
                        return LibraryDeckCard(
                          title: deck['title'],
                          cardCount: deck['cardCount'],
                          progress: deck['progress'],
                          isNew: deck['isNew'],
                          onTap: () {
                            debugPrint('Open deck: ${deck['title']}');
                            // TODO: Navigate to deck detail
                          },
                          onMorePressed: () {
                            _showDeckOptions(context, deck['title']);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      
      // ========== BOTTOM NAVIGATION ==========
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: _onNavItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: Colors.grey.shade400,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
      
      // ========== FAB ==========
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Create new deck');
          // TODO: Navigate to create deck screen
        },
        backgroundColor: const Color(0xFF2196F3),
        elevation: 8,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
  
  // ========== DECK OPTIONS BOTTOM SHEET ==========
  void _showDeckOptions(BuildContext context, String deckTitle) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      deckTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 24),
            
            // Options
            _buildOption(
              icon: Icons.edit,
              label: 'Chỉnh sửa',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Edit deck');
              },
            ),
            _buildOption(
              icon: Icons.share,
              label: 'Chia sẻ',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Share deck');
              },
            ),
            _buildOption(
              icon: Icons.copy,
              label: 'Sao chép',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Duplicate deck');
              },
            ),
            _buildOption(
              icon: Icons.delete,
              label: 'Xóa',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, deckTitle);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: color,
        ),
      ),
      onTap: onTap,
    );
  }
  
  // ========== DELETE CONFIRMATION ==========
  void _showDeleteConfirmation(BuildContext context, String deckTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa bộ thẻ?'),
        content: Text(
          'Bạn có chắc muốn xóa "$deckTitle"? Hành động này không thể hoàn tác.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              debugPrint('Delete deck: $deckTitle');
              // TODO: Implement delete logic
            },
            child: const Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// ========== COPY CÁC WIDGET COMPONENTS TỪ deck_library_widgets.dart ==========

class LibraryDeckCard extends StatelessWidget {
  final String title;
  final int cardCount;
  final double? progress;
  final bool isNew;
  final VoidCallback onTap;
  final VoidCallback onMorePressed;

  const LibraryDeckCard({
    super.key,
    required this.title,
    required this.cardCount,
    this.progress,
    this.isNew = false,
    required this.onTap,
    required this.onMorePressed,
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$cardCount thẻ',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onMorePressed,
                      icon: const Icon(Icons.more_vert),
                      iconSize: 20,
                      color: Colors.grey[600],
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (isNew)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Mới',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('Chưa học lần nào', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                    ],
                  )
                else if (progress != null)
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF2196F3)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${(progress! * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LibrarySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const LibrarySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Tìm kiếm bộ thẻ...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

class EncouragementFooter extends StatelessWidget {
  const EncouragementFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.auto_awesome,
                size: 36,
                color: const Color(0xFF2196F3).withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Cố gắng lên!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 8),
          Text(
            'Ôn tập thẻ mỗi ngày để ghi nhớ tốt hơn',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
          ),
        ],
      ),
    );
  }
}

class LibraryHeader extends StatelessWidget {
  final VoidCallback onSettingsPressed;

  const LibraryHeader({super.key, required this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Thư viện của bạn',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
          ),
          IconButton(
            onPressed: onSettingsPressed,
            icon: const Icon(Icons.settings),
            iconSize: 24,
            color: const Color(0xFF111827),
            style: IconButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(8)),
          ),
        ],
      ),
    );
  }
}

class EmptyLibraryState extends StatelessWidget {
  final String message;
  final String? subtitle;
  final IconData icon;

  const EmptyLibraryState({
    super.key,
    required this.message,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}