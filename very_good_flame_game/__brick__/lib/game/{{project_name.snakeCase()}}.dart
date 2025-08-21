import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

class {{project_name.pascalCase()}} extends FlameGame {
  {{project_name.pascalCase()}}({
    required this.l10n,
    required this.effectPlayer,
    required this.textStyle,
    required Images images,
  }) {
    this.images = images;
  }

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  int counter = 0;

  CounterComponent? counterComponent;

  @override
  Color backgroundColor() => const Color(0xFF2A48DF);

  @override
  Future<void> onLoad() async {
    final world = World(
      children: [
        Unicorn(position: size / 2),
      ],
    );

    final camera = CameraComponent(world: world);
    await addAll([world, camera]);

    camera.viewfinder.position = size / 2;
    camera.viewfinder.zoom = 8;

    // add a HUD component showing number of taps on unicorn
    counterComponent = CounterComponent(position: Vector2(0, 0));
    camera.viewport.add(counterComponent!);
    _positionCounterComponent(size);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _positionCounterComponent(size);
  }

  void _positionCounterComponent(Vector2 size) {
    counterComponent?.position = Vector2(10, size.y - 10);
  }
}
