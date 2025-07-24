import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/game/entities/unicorn/behaviors/tapping_behavior.dart';
import 'package:{{project_name.snakeCase()}}/gen/assets.gen.dart';

class Unicorn extends PositionedEntity with HasGameReference {
  Unicorn({required super.position})
    : super(
        anchor: Anchor.center,
        size: Vector2.all(32),
        behaviors: [TappingBehavior()],
      );

  @visibleForTesting
  Unicorn.test({required super.position, super.behaviors})
    : super(size: Vector2.all(32));

  late SpriteAnimationComponent _animationComponent;

  @visibleForTesting
  SpriteAnimationTicker get animationTicker =>
      _animationComponent.animationTicker!;

  @override
  Future<void> onLoad() async {
    final animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(Assets.images.unicornAnimation.path),
      SpriteAnimationData.sequenced(
        amount: 16,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );

    await add(
      _animationComponent = SpriteAnimationComponent(
        animation: animation,
        size: size,
      ),
    );

    resetAnimation();
  }

  void resetAnimation() {
    animationTicker
      ..currentIndex = animationTicker.spriteAnimation.frames.length - 1
      ..update(0.1)
      ..currentIndex = 0;
  }

  /// Plays the animation.
  void playAnimation() => animationTicker.reset();

  /// Returns whether the animation is playing or not.
  bool isAnimationPlaying() => !animationTicker.done();
}
