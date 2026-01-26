import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/data/models/deck_model.dart';
import 'package:omni_card_ai/presentation/deck_library/pages/edit_deck_modal.dart';
import 'package:omni_card_ai/presentation/providers/deck_provider.dart';
import 'package:omni_card_ai/presentation/deck_library/widgets/deck_library_widgets.dart';
import 'package:omni_card_ai/presentation/providers/search_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final searchResultAsync = ref.watch(searchResultProvider);

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
                  ref.read(searchQueryProvider.notifier).updateQuery(value);
                },
              ),
            ),
            
            const SizedBox(height: 24),

            // ========== DECK LIST ==========
            Expanded(
              child: searchResultAsync.when(
                data: (decks) {
                  if(decks.isEmpty) {
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
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: decks.length + 1, // +1 for footer
                    itemBuilder: (context, index) {
                      // Footer encouragement
                      if (index == decks.length) {
                        return const EncouragementFooter();
                      }

                      final deck = decks[index];
                      bool _isNavigating = false; //Chặn Double Tap Khi Điều Hướng

                      return LibraryDeckCard(
                        title: deck.title,
                        cardCount: deck.countCard,
                        progress: deck.calculateProgres,
                        isNew: deck.isNewDeck,
                        onTap: () async {
                          //Chặn Double Tap Khi Điều Hướng
                          if (_isNavigating) return;
                          _isNavigating = true;
                          
                          debugPrint('Open deck: ${deck.title}');
                          await context.push('/deck-detail/${deck.id}');
                          
                          _isNavigating = false;
                        },
                        onMorePressed: () {
                          _showDeckOptions(context, deck);
                        },
                      );
                    },
                  );
                }, 
                error: (err, stack) => Center(child: Text('Lỗi: $err')), 
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // ========== DECK OPTIONS BOTTOM SHEET ==========
  void _showDeckOptions(BuildContext context, DeckModel deck) {
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
                      deck.title,
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
                _showEditDeckModal(context, deck);
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
                _showDeleteConfirmation(context, deck);
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
  void _showDeleteConfirmation(BuildContext context, DeckModel deck) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa bộ thẻ?'),
        content: Text(
          'Bạn có chắc muốn xóa "${deck.title}"? Hành động này không thể hoàn tác.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              debugPrint('Delete deck: ${deck.title}');
              await ref.read(deckNotifierProvider.notifier).deleteDeck(deck.id); 
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

  void _showEditDeckModal(BuildContext context, DeckModel deck) {
    showEditDeckModal(
      context, 
      initialTitle: deck.title, 
      initialDescription: deck.description ?? '', 
      onSave: (title, description) async {
        await ref.read(deckNotifierProvider.notifier).updateDeck(
          deck,
          title: title,
          desc: description
        );
      }
    );
  }
}