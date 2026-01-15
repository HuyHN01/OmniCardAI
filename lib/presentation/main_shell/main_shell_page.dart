import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/presentation/main_shell/create_card_modal.dart';

class MainShellPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {

    final int currentTabIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(context, currentTabIndex),
    );
  }

  
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: navigationShell.goBranch,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey.shade400,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home), 
          label: 'Trang chủ'),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Thư viện',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Thống kê',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
      ],
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
    int tabIndex
  ) {
    return (
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _isFabVisibleForTab(tabIndex) ? _createFab(context) : const SizedBox.shrink(),
      )
    );
  }
  
  Widget _createFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onCreateCardPressed(context),
      backgroundColor: Colors.blue,
      elevation: 8,
      child: const Icon(Icons.add, size: 28, color: Colors.white),
    );
  }

  void _onCreateCardPressed(BuildContext context) {
    showCreateCardModal(context);
    debugPrint('Create new deck');
  }

  bool _isFabVisibleForTab (int tabIndex) {
    return tabIndex == 0 || tabIndex == 1;
  }
}

