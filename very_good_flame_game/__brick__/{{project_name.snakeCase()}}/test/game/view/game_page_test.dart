// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flame/cache.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';
import 'package:{{project_name.snakeCase()}}/loading/cubit/cubit.dart';

import '../../helpers/helpers.dart';

class _FakeAssetSource extends Fake implements AssetSource {}

class _FakeImage extends Fake implements ui.Image {}

class _MockAudioCubit extends MockCubit<AudioState> implements AudioCubit {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

class _MockImages extends Mock implements Images {}

class _MockBgm extends Mock implements Bgm {}

class _MockPreloadCubit extends MockCubit<PreloadState>
    implements PreloadCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // https://github.com/material-foundation/flutter-packages/issues/286#issuecomment-1406343761
  HttpOverrides.global = null;

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      MethodChannel('xyz.luan/audioplayers'),
      (message) => null,
    );

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (message) async => switch (message.method) {
        ('getTemporaryDirectory' || 'getApplicationSupportDirectory') =>
          Directory.systemTemp.createTempSync('fake').path,
        _ => null,
      },
    );
  });

  group('GamePage', () {
    late PreloadCubit preloadCubit;
    late Images images;

    setUpAll(() {
      registerFallbackValue(_FakeAssetSource());
    });

    setUp(() {
      images = _MockImages();
      when(() => images.fromCache(any())).thenReturn(_FakeImage());

      preloadCubit = _MockPreloadCubit();
      when(() => preloadCubit.audio).thenReturn(AudioCache(prefix: ''));
      when(() => preloadCubit.images).thenReturn(images);
    });

    testWidgets('is routable', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(
          Builder(
            builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).push(GamePage.route()),
              ),
            ),
          ),
          preloadCubit: preloadCubit,
        );

        await tester.tap(find.byType(FloatingActionButton));

        await tester.pump();
        await tester.pump();

        expect(find.byType(GamePage), findsOneWidget);

        await tester.pumpWidget(Container());
      });
    });

    testWidgets('renders GameView', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(
          const GamePage(),
          preloadCubit: preloadCubit,
        );
        expect(find.byType(GameView), findsOneWidget);
      });
    });
  });

  group('GameView', () {
    late AudioCubit audioCubit;

    setUp(() {
      audioCubit = _MockAudioCubit();
      when(() => audioCubit.state).thenReturn(AudioState());

      final effectPlayer = _MockAudioPlayer();
      when(() => audioCubit.effectPlayer).thenReturn(effectPlayer);
      final bgm = _MockBgm();
      when(() => audioCubit.bgm).thenReturn(bgm);
      when(() => bgm.play(any())).thenAnswer((_) async {});
      when(bgm.pause).thenAnswer((_) async {});
    });

    testWidgets('toggles mute button correctly', (tester) async {
      final controller = StreamController<AudioState>();
      whenListen(audioCubit, controller.stream, initialState: AudioState());

      final game = TestGame();
      await tester.pumpApp(
        BlocProvider.value(
          value: audioCubit,
          child: Material(child: GameView(game: game)),
        ),
      );

      expect(find.byIcon(Icons.volume_up), findsOneWidget);

      controller.add(AudioState(volume: 0));
      await tester.pump();

      expect(find.byIcon(Icons.volume_off), findsOneWidget);

      controller.add(AudioState());
      await tester.pump();

      expect(find.byIcon(Icons.volume_up), findsOneWidget);
    });

    testWidgets('calls correct method based on state', (tester) async {
      final controller = StreamController<AudioState>();
      when(audioCubit.toggleVolume).thenAnswer((_) async {});
      whenListen(audioCubit, controller.stream, initialState: AudioState());

      final game = TestGame();
      await tester.pumpApp(
        BlocProvider.value(
          value: audioCubit,
          child: Material(child: GameView(game: game)),
        ),
      );

      await tester.tap(find.byIcon(Icons.volume_up));
      controller.add(AudioState(volume: 0));
      await tester.pump();
      verify(audioCubit.toggleVolume).called(1);

      await tester.tap(find.byIcon(Icons.volume_off));
      controller.add(AudioState());
      await tester.pump();
      verify(audioCubit.toggleVolume).called(1);
    });
  });
}
