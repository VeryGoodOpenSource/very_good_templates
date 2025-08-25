import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit({required AudioPlayer audioPlayer, required Bgm backgroundMusic})
    : effectPlayer = audioPlayer,
      bgm = backgroundMusic,
      super(const AudioState());

  @visibleForTesting
  AudioCubit.test({
    required this.effectPlayer,
    required this.bgm,
    double volume = 1.0,
  }) : super(AudioState(volume: volume));

  final AudioPlayer effectPlayer;

  final Bgm bgm;

  Future<void> _changeVolume(double volume) async {
    await effectPlayer.setVolume(volume);
    await bgm.audioPlayer.setVolume(volume);
    if (!isClosed) {
      emit(state.copyWith(volume: volume));
    }
  }

  Future<void> toggleVolume() async {
    if (state.volume == 0) {
      return _changeVolume(1);
    }
    return _changeVolume(0);
  }

  @override
  Future<void> close() async {
    await effectPlayer.dispose();
    await bgm.dispose();
    return super.close();
  }
}
