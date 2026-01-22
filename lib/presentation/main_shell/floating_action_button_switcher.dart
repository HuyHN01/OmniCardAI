import 'package:flutter/material.dart';

class FloatingActionButtonSwitcher extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onPressed;

  const FloatingActionButtonSwitcher({
    required this.isVisible,
    required this.onPressed,
  });

  static const _fabAnimationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _fabAnimationDuration,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation, 
        child: child,
      ),
      child: isVisible ? _createFab() : const SizedBox.shrink(),
    );
  }

  Widget _createFab() {
    return FloatingActionButton(
      key: const ValueKey('create-fab'),
      backgroundColor: Colors.blue,
      elevation: 8,
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}