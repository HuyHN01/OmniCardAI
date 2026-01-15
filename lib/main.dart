import 'package:flutter/material.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';
import 'package:omni_card_ai/core/routes/route_config.dart';
import 'package:omni_card_ai/presentation/deck_detail/pages/deck_detail_screen.dart';
import 'package:omni_card_ai/presentation/study/pages/completion_page.dart';
import 'package:omni_card_ai/presentation/study/pages/study_screen.dart';

const String APPLICATION_NAME = 'OmniCard AI';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   title: APPLICATION_NAME,
    //   theme: AppTheme.lightTheme,
    //   routerConfig: goRouter,
    //   debugShowCheckedModeBanner: false,
    // );

    return MaterialApp(
      home: CompletionPage(),
    );
  }
}