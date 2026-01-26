import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/core/theme/app_theme.dart';
import 'package:omni_card_ai/core/routes/route_config.dart';
import 'package:omni_card_ai/data/local/isar_service.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final isar = await IsarService.init();
  try {
    runApp(
      ProviderScope(
        overrides: [
          isarProvider.overrideWithValue(isar),
        ],
        child: const OmniCardApp(),
      ),
    );
  }
  catch(e) {
    debugPrint("Lỗi: $e");
  }
 
}

class OmniCardApp extends StatelessWidget {
  const OmniCardApp({super.key});

  static const _appTitle = 'OmniCard AI';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _appTitle,
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}