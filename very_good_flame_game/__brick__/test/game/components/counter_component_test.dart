// Make test files more explicit rather then collapsing calls
// ignore_for_file: cascade_invocations

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}/game/game.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

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
  group('$CounterComponent', () {
    late AppLocalizations l10n;

    setUp(() {
      l10n = _MockAppLocalizations();

      when(() => l10n.counterText(any())).thenAnswer(
        (invocation) => 'counterText: ${invocation.positionalArguments[0]}',
      );
    });

    {{project_name.pascalCase()}} createFlameGame() {
      return _{{project_name.pascalCase()}}(
        l10n: l10n,
        effectPlayer: _MockAudioPlayer(),
        textStyle: const TextStyle(),
        images: Images(),
      );
    }

    testWithGame('has all components', createFlameGame, (game) async {
      final component = CounterComponent(position: Vector2.all(1));
      await game.ensureAdd(component);

      expect(component.text, isNotNull);
    });

    testWithGame('changes text count correctly', createFlameGame, (game) async {
      final component = CounterComponent(position: Vector2.all(1));
      await game.ensureAdd(component);

      expect(component.text.text, equals(''));
      game.counter = 1;
      game.update(0.1);
      expect(component.text.text, equals('counterText: 1'));

      game.counter = 2;
      game.update(0.1);
      expect(component.text.text, equals('counterText: 2'));
    });
  });
}
