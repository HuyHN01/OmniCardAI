import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_card_ai/core/routes/app_route.dart';
import 'package:omni_card_ai/core/routes/route_name.dart';
import 'package:omni_card_ai/presentation/create_card/pages/ai_flashcard_generation_page.dart';
import 'package:omni_card_ai/presentation/create_card/pages/ai_flashcard_review_page.dart';
import 'package:omni_card_ai/presentation/create_card/pages/manual_batch_create_cards_page.dart';
import 'package:omni_card_ai/presentation/create_deck/pages/create_deck_screen.dart';
import 'package:omni_card_ai/presentation/deck_detail/pages/deck_detail_screen.dart';
import 'package:omni_card_ai/presentation/deck_library/pages/deck_library_page.dart';
import 'package:omni_card_ai/presentation/home/pages/home_page.dart';
import 'package:omni_card_ai/presentation/main_shell/main_shell_page.dart';
import 'package:omni_card_ai/presentation/profile/pages/profile_page.dart';
import 'package:omni_card_ai/presentation/stats/pages/stats_screen.dart';
import 'package:omni_card_ai/presentation/study/pages/completion_page.dart';
import 'package:omni_card_ai/presentation/study/pages/study_screen.dart';


final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: _buildMainShell,
      branches: _mainBranch
    ),
    GoRoute(
      path: AppRoutes.createDeck,
      builder: (context, state) => CreateDeckScreen(),
    ),
    GoRoute(
      path: AppRoutes.deckDetail, /*/deck-detail/:deckId/'*/
      name: RouteName.deckDetail,
      builder: (context, state) {
        final deckIdString = state.pathParameters['deckId']!;
        final deckId = int.parse(deckIdString);

        return DeckDetailScreen(deckId: deckId);
      },
      routes: [
        GoRoute(
          path: AppRoutes.manualCreateCard,
          name: RouteName.manualCreateCard,
          builder: (context, state) {
            final deckIdString = state.pathParameters['deckId']!;
            final deckId = int.parse(deckIdString);

            return ManualBatchCreateCardsScreen(deckId: deckId);
          },
        ),
        GoRoute(
          path: AppRoutes.aiGenerationCreateCard,
          name: RouteName.aiGenerationCreateCard,
          builder: (context, state) {
            final deckIdString = state.pathParameters['deckId']!;
            final deckId = int.parse(deckIdString);

            return AIFlashcardGenerationScreen(deckId: deckId);
          },
        ),
        GoRoute(
          path: AppRoutes.aiGenerationReview,
          name: RouteName.aiGenerationReview,
          builder: (context, state) {
            final deckIdString = state.pathParameters['deckId']!;
            final cards = state.extra as List<Map<String, String>>;
            final deckId = int.parse(deckIdString);

            return AIFlashcardReviewScreen(
              generatedCards: cards,
              initialDeckId: deckId,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.study,
          name: RouteName.study,
          builder: (context, state) {
            final deckIdString = state.pathParameters['deckId']!;
            final deckId = int.parse(deckIdString);

            return StudyScreen(deckId: deckId);
          },
          routes: [
            GoRoute(
              path: AppRoutes.completeStudy,
              name: RouteName.completeStudy,
              builder: (context, state) {
                final deckIdString = state.pathParameters['deckId']!;
                final deckId = int.parse(deckIdString);
                return CompletionPage(deckId: deckId);
              },
            )
          ]
        ),
      ]
    ),
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
    route: _route(AppRoutes.home, RouteName.home,HomeScreen())
  ),
  _branch(
    route: _route(AppRoutes.deckLibrary, RouteName.deckLibrary, DeckLibraryScreen())
  ),
  _branch(
    route: _route(AppRoutes.statistics, RouteName.statistics, StatisticsScreen())
  ),
  _branch(route: _route(AppRoutes.profile, RouteName.profile, ProfileScreen()))
];

StatefulShellBranch _branch({required GoRoute route}) {
  return StatefulShellBranch(routes: [route]);
}

GoRoute _route (String path, String name,Widget page) {
  return GoRoute(
    path: path,
    name: name,
    builder: (_, _) => page,
  );
}