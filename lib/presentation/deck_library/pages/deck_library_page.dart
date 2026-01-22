import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/presentation/providers/deck_provider.dart';
import 'package:omni_card_ai/presentation/deck_library/widgets/deck_library_widgets.dart';

/// ============ DECK LIBRARY SCREEN ============
/// Màn hình thư viện hiển thị tất cả các bộ thẻ của user
/// Có search functionality và filter options
class DeckLibraryScreen extends ConsumerStatefulWidget {
  const DeckLibraryScreen({super.key});

  @override
  ConsumerState<DeckLibraryScreen> createState() => _DeckLibraryScreenState();
}

class _DeckLibraryScreenState extends ConsumerState<DeckLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  
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

            
            Consumer(
              builder: (context, ref, child) {

                final deckAsync = ref.watch(deckNotifierProvider);
                
                return Expanded(
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
                      : deckAsync.maybeWhen(
                          data: (decks) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: decks.length + 1, // +1 for footer
                              itemBuilder: (context, index) {
                                // Footer encouragement
                                if (index == decks.length) {
                                  return const EncouragementFooter();
                                }

                                final deck = decks[index];
                                return LibraryDeckCard(
                                  title: deck.title,
                                  cardCount: deck.countCard,
                                  progress: deck.calculateProgres,
                                  isNew: deck.isNewDeck,
                                  onTap: () {
                                    debugPrint('Open deck: ${deck.title}');
                                    // TODO: Navigate to deck detail
                                  },
                                  onMorePressed: () {
                                    _showDeckOptions(context, deck.title);
                                  },
                                );
                              },
                            );
                          },
                          orElse: () {
                            return EmptyLibraryState(
                              message: _searchController.text.isEmpty
                                  ? 'Chưa có bộ thẻ nào'
                                  : 'Không tìm thấy kết quả',
                              subtitle: _searchController.text.isEmpty
                                  ? 'Nhấn nút + để tạo bộ thẻ đầu tiên'
                                  : 'Thử tìm với từ khóa khác',
                              icon: _searchController.text.isEmpty
                                  ? Icons.inbox_outlined
                                  : Icons.search_off,
                            );
                          },
                      ),
                );
              },
            ),
          ],
        ),
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