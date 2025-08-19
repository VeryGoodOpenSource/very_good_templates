import 'package:flame/components.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';

class CounterComponent extends PositionComponent
    with HasGameReference<{{project_name.pascalCase()}}> {
  CounterComponent({required super.position}) : super(anchor: Anchor.center);

  late final TextComponent text;

  @override
  Future<void> onLoad() async {
    await add(
      text = TextComponent(
        anchor: Anchor.bottomLeft,
        textRenderer: TextPaint(style: game.textStyle.copyWith(fontSize: 20)),
      ),
    );
  }

  @override
  void update(double dt) {
    text.text = game.l10n.counterText(game.counter);
  }
}
