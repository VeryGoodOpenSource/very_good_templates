import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';
import 'package:{{project_name.snakeCase()}}/gen/assets.gen.dart';

class TappingBehavior extends Behavior<Unicorn>
    with TapCallbacks, HasGameReference<{{project_name.pascalCase()}}> {
  @override
  bool containsLocalPoint(Vector2 point) => parent.containsLocalPoint(point);

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    if (parent.isAnimationPlaying()) {
      return;
    }
    game.counter++;
    parent.playAnimation();

    await game.effectPlayer.play(AssetSource(Assets.audio.effect));
  }
}
