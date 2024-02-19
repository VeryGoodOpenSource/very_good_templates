import 'package:flame/components.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';

class CounterComponent extends PositionComponent with HasGameRef<{{project_name.pascalCase()}}> {
  CounterComponent({
    required super.position,
  }) : super(anchor: Anchor.center);

  late final TextComponent text;

  @override
  Future<void> onLoad() async {
    await add(
      text = TextComponent(
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: game.textStyle,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    text.text = gameRef.l10n.counterText(gameRef.counter);
  }
}
