import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:omni_card_ai/core/routes/app_route.dart';
import 'package:omni_card_ai/presentation/home/screens/home_screen.dart';
import 'package:omni_card_ai/presentation/deck_library/screens/deck_library_screen.dart';


final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.deckLibrary,
      builder: (context, state) => DeckLibraryScreen()
    ),
  ]
);