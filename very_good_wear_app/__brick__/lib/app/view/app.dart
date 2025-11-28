import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/ambient_mode/ambient_mode.dart';
import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => AmbientModeBuilder(
    child: const CounterPage(),
    builder: (context, isAmbientModeActive, child) => MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        // This makes elements such as buttons have a fewer pixels in
        // padding and general spacing. good for devices with limited screen
        // real state.
        visualDensity: VisualDensity.compact,
        // When in ambient mode, change the apps color scheme
        colorScheme: isAmbientModeActive
            ? const ColorScheme.dark(
                primary: Colors.white24,
                onSurface: Colors.white10,
              )
            : const ColorScheme.dark(primary: Color(0xFF00B5FF)),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}
