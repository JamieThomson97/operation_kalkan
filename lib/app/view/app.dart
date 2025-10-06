import 'package:flutter/material.dart';
import 'package:operation_kalkan/l10n/l10n.dart';
import 'package:operation_kalkan/views/homepage.dart';

class App extends StatelessWidget {
  const App({super.key});

  static String resortName2 = 'La Managa';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Homepage(resortName: resortName2),
    );
  }
}
