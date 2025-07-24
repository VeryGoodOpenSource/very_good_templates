import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/loading/loading.dart';

void main() {
  group('PreloadState', () {
    test('initial', () {
      const state = PreloadState.initial();
      expect(state.totalCount, 0);
      expect(state.loadedCount, 0);
      expect(state.currentLabel, '');
    });

    group('progress', () {
      test('when not started is zero', () {
        const state = PreloadState.initial();
        expect(state.progress, 0);
      });

      test('after started', () {
        final state = const PreloadState.initial().copyWith(
          totalCount: 2,
          loadedCount: 1,
        );
        expect(state.progress, 0.5);
      });
    });

    group('isComplete', () {
      test('when not started is zero', () {
        const state = PreloadState.initial();
        expect(state.isComplete, false);
      });

      test('after started', () {
        final state = const PreloadState.initial().copyWith(
          totalCount: 2,
          loadedCount: 1,
        );
        expect(state.isComplete, false);

        final stateComplete = state.copyWith(loadedCount: 2);
        expect(stateComplete.isComplete, true);
      });
    });
  });
}
