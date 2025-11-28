import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:wearable_rotary/wearable_rotary.dart'
    as wearable_rotary
    show rotaryEvents;
import 'package:wearable_rotary/wearable_rotary.dart' hide rotaryEvents;

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider(create: (_) => CounterCubit(), child: CounterView());
}

class CounterView extends StatefulWidget {
  CounterView({super.key, @visibleForTesting Stream<RotaryEvent>? rotaryEvents})
    : rotaryEvents = rotaryEvents ?? wearable_rotary.rotaryEvents;

  final Stream<RotaryEvent> rotaryEvents;

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final StreamSubscription<RotaryEvent> rotarySubscription;

  @override
  void initState() {
    super.initState();
    rotarySubscription = widget.rotaryEvents.listen(handleRotaryEvent);
  }

  @override
  void dispose() {
    unawaited(rotarySubscription.cancel());
    super.dispose();
  }

  void handleRotaryEvent(RotaryEvent event) {
    final cubit = context.read<CounterCubit>();
    return switch (event.direction) {
      RotaryDirection.clockwise => cubit.increment(),
      RotaryDirection.counterClockwise => cubit.decrement(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: context.read<CounterCubit>().increment,
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            Text(l10n.counterAppBarTitle),
            const CounterText(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: context.read<CounterCubit>().decrement,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayMedium);
  }
}
