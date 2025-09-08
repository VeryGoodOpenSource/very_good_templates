import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/loading/loading.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final cubit = PreloadCubit(
              Images(prefix: ''),
              AudioCache(prefix: ''),
            );
            unawaited(cubit.loadSequentially());
            return cubit;
          },
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2A48DF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2A48DF),
          foregroundColor: Color(0xFFFFFFFF),
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF2A48DF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFF2A48DF)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoadingPage(),
    );
  }
}
