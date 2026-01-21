import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';
import 'package:omni_card_ai/core/routes/route_config.dart';
import 'package:omni_card_ai/data/local/isar_service.dart';

const String APPLICATION_NAME = 'OmniCard AI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();
  
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: APPLICATION_NAME,
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );

    // return MaterialApp(
    //   //home: DeckDetailScreen(),
    //   home: StudyScreen(),
    // );
  }
}