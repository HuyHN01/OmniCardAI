import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/presentation/main_shell/create_card_modal.dart';

class MainShellPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {

    final int index = navigationShell.currentIndex;
    bool showFab = _shouldShowFab(index);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
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
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: showFab ?
          FloatingActionButton(
          onPressed: () {
            // TODO: Create new deck
            showCreateCardModal(context);
            debugPrint('Create new deck');
          },
          backgroundColor: Colors.blue,
          elevation: 8,
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ): const SizedBox.shrink(),
      ),
    );
  }

  bool _shouldShowFab (int index) {
    return index == 0 || index == 1;
  }
}

