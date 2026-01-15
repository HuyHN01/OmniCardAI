import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/app_route.dart';
import 'package:omni_card_ai/presentation/deck_library/pages/deck_library_page.dart';
import 'package:omni_card_ai/presentation/home/pages/home_page.dart';
import 'package:omni_card_ai/presentation/main_shell/main_shell_page.dart';
import 'package:omni_card_ai/presentation/profile/pages/profile_page.dart';
import 'package:omni_card_ai/presentation/stats/pages/stats_screen.dart';


final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: _buildMainShell,
      branches: _mainBranch
    )
  ]
);

Widget _buildMainShell(
  BuildContext context,
  GoRouterState state,
  StatefulNavigationShell navigationShell
) {
  return MainShellPage(navigationShell: navigationShell);
}

List<StatefulShellBranch> _mainBranch = [
  _branch(
    route: _route(AppRoutes.home, HomeScreen())
  ),
  _branch(
    route: _route(AppRoutes.deckLibrary, DeckLibraryScreen())
  ),
  _branch(
    route: _route(AppRoutes.statistics, StatisticsScreen())
  ),
  _branch(route: _route(AppRoutes.profile, ProfileScreen()))
];

StatefulShellBranch _branch({required GoRoute route}) {
  return StatefulShellBranch(routes: [route]);
}

GoRoute _route (String path, Widget page) {
  return GoRoute(
    path: path,
    builder: (_, _) => page,
  );
}