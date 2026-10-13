part of 'audio_cubit.dart';

class const AudioState({final double volume = 1}) extends Equatable {
  AudioState copyWith({double? volume}) {
    return AudioState(volume: volume ?? this.volume);
  }

  @override
  List<Object> get props => [volume];
}
