import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';
import 'package:{{project_name.snakeCase()}}/gen/assets.gen.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/loading/cubit/cubit.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const GamePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final audioCache = context.read<PreloadCubit>().audio;
        return AudioCubit(
          audioPlayer: AudioPlayer()..audioCache = audioCache,
          backgroundMusic: Bgm(audioCache: audioCache),
        );
      },
      child: const Scaffold(body: SafeArea(child: GameView())),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key, this.game});

  final FlameGame? game;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  FlameGame? _game;

  late final Bgm bgm;

  @override
  void initState() {
    super.initState();
    bgm = context.read<AudioCubit>().bgm;
    bgm.play(Assets.audio.background);
  }

  @override
  void dispose() {
    bgm.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(color: Colors.white, fontSize: 4);

    _game ??= widget.game ??
        {
          {project_name.pascalCase()}
        }(
          l10n: context.l10n,
          effectPlayer: context.read<AudioCubit>().effectPlayer,
          textStyle: textStyle,
          images: context.read<PreloadCubit>().images,
        );
    return Stack(
      children: [
        Positioned.fill(child: GameWidget(game: _game!)),
        Align(
          alignment: Alignment.topRight,
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.volume == 0 ? Icons.volume_off : Icons.volume_up,
                ),
                onPressed: () => context.read<AudioCubit>().toggleVolume(),
              );
            },
          ),
        ),
      ],
    );
  }
}
