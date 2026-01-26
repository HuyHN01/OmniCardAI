import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/app_route.dart';
import 'package:omni_card_ai/presentation/deck_detail/pages/create_card_modal.dart';
import 'package:omni_card_ai/presentation/main_shell/floating_action_button_switcher.dart';

class MainShellPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellPage({
    super.key, 
    required this.navigationShell
  });

  static const _libraryTabIndex = 1;

  @override
  Widget build(BuildContext context) {

    final int currentTabIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: currentTabIndex, 
        onTap: navigationShell.goBranch
      ),
      floatingActionButton: FloatingActionButtonSwitcher(
        isVisible: _shouldShowFab(currentTabIndex), 
        onPressed: () => _onCreateCardPressed(context)
      )
    );
  }


  bool _shouldShowFab(int tabIndex) => tabIndex == _libraryTabIndex;

  void _onCreateCardPressed(BuildContext context) {
    context.push(AppRoutes.createDeck);
    debugPrint('Create new deck');
  }
}


class _BottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
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
          label: 'Trang chủ'
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
          label: 'Cá nhân'
        ),
      ],
    );
  }
}