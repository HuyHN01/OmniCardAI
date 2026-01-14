import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/app_route.dart';
import 'package:omni_card_ai/presentation/deck_library/pages/deck_library_page.dart';
import 'package:omni_card_ai/presentation/home/pages/home_page.dart';
import 'package:omni_card_ai/presentation/main_shell/main_shell_page.dart';


final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainShellPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.deckLibrary,
              builder: (context, state) => const DeckLibraryScreen(),
            )
          ]
        )
      ]
    )
  ]
);