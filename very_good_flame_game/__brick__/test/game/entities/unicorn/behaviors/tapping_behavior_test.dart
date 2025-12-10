// Make test files more explicit rather then collapsing calls
// ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

class _FakeAssetSource extends Fake implements AssetSource {}

class _MockImages extends Mock implements Images {}

class _MockAppLocalizations extends Mock implements AppLocalizations {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

class _{{project_name.pascalCase()}} extends {{project_name.pascalCase()}} {
  _{{project_name.pascalCase()}}({
    required super.l10n,
    required super.effectPlayer,
    required super.textStyle,
    required super.images,
  });

  @override
  Future<void> onLoad() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TappingBehavior', () {
    late AppLocalizations l10n;
    late AudioPlayer audioPlayer;
    late Images images;

    {{project_name.pascalCase()}} createFlameGame() {
      return _{{project_name.pascalCase()}}(
        l10n: l10n,
        effectPlayer: audioPlayer,
        textStyle: const TextStyle(),
        images: images,
      );
    }

    setUpAll(() async {
      registerFallbackValue(_FakeAssetSource());
    });

    setUp(() async {
      l10n = _MockAppLocalizations();
      when(() => l10n.counterText(any())).thenReturn('counterText');

      audioPlayer = _MockAudioPlayer();
      when(() => audioPlayer.play(any())).thenAnswer((_) async {});

      images = _MockImages();
      final image = await _fakeImage();
      when(() => images.fromCache(any())).thenReturn(image);
    });

    FlameTester(createFlameGame).testGameWidget(
      'when tapped, starts playing the animation',
      setUp: (game, tester) async {
        await game.ensureAdd(
          Unicorn.test(
            position: Vector2.zero(),
            behaviors: [TappingBehavior()],
          ),
        );
      },
      verify: (game, tester) async {
        await tester.tapAt(Offset.zero);

        /// Flush long press gesture timer
        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        game.update(0.1);

        final unicorn = game.firstChild<Unicorn>()!;
        expect(unicorn.animationTicker.currentIndex, equals(1));
        expect(unicorn.isAnimationPlaying(), equals(true));

        verify(() => audioPlayer.play(any())).called(1);
      },
    );
  });
}

Future<Image> _fakeImage() async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(
    const Rect.fromLTWH(0, 0, 1, 1),
    Paint()..color = const Color(0xFF000000),
  );
  final picture = recorder.endRecording();
  return picture.toImage(1, 1);
}
