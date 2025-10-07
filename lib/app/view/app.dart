import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operation_kalkan/app/router/app_router.dart';
import 'package:operation_kalkan/l10n/l10n.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    const surfaceBackground = Colors.white;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3D5AFE),
    );

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: surfaceBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: surfaceBackground,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          foregroundColor: Colors.black87,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
