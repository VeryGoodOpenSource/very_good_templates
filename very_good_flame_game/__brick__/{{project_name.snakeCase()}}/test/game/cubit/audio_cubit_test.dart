import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}/game/cubit/cubit.dart';

class _MockAudioCache extends Mock implements AudioCache {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

class _MockBgm extends Mock implements Bgm {}

void main() {
  group('AudioCubit', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    late AudioCache audioCache;
    late AudioPlayer effectPlayer;
    late Bgm bgm;
    late AudioPlayer bgmPlayer;

    setUp(() {
      audioCache = _MockAudioCache();
      effectPlayer = _MockAudioPlayer();
      bgm = _MockBgm();
      bgmPlayer = _MockAudioPlayer();
      when(() => bgm.audioPlayer).thenReturn(bgmPlayer);

      when(effectPlayer.dispose).thenAnswer((_) => Future.value());
      when(bgmPlayer.dispose).thenAnswer((_) => Future.value());

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers'),
        (_) => null,
      );
    });

    test('can be instantiated', () {
      expect(AudioCubit(audioCache: audioCache), isA<AudioCubit>());
    });

    blocTest<AudioCubit, AudioState>(
      'toggleVolume mutes the volume when the volume is not 0',
      setUp: () {
        when(() => effectPlayer.setVolume(any())).thenAnswer((_) async {});
        when(() => bgmPlayer.setVolume(any())).thenAnswer((_) async {});
      },
      build: () => AudioCubit.test(effectPlayer: effectPlayer, bgm: bgm),
      act: (cubit) => cubit.toggleVolume(),
      expect: () => [const AudioState(volume: 0)],
      verify: (_) {
        verify(() => effectPlayer.setVolume(any(that: equals(0)))).called(1);
        verify(() => bgmPlayer.setVolume(any(that: equals(0)))).called(1);
      },
    );

    blocTest<AudioCubit, AudioState>(
      'toggleVolume unmutes the volume when the volume is 0',
      setUp: () {
        when(() => effectPlayer.setVolume(any())).thenAnswer((_) async {});
        when(() => bgmPlayer.setVolume(any())).thenAnswer((_) async {});
      },
      build: () {
        return AudioCubit.test(effectPlayer: effectPlayer, bgm: bgm, volume: 0);
      },
      act: (cubit) => cubit.toggleVolume(),
      expect: () => [const AudioState()],
      verify: (_) {
        verify(() => effectPlayer.setVolume(any(that: equals(1)))).called(1);
        verify(() => bgmPlayer.setVolume(any(that: equals(1)))).called(1);
      },
    );
  });
}
