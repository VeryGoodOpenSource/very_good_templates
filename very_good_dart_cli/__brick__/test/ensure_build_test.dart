@Tags(['version-verify', 'skip_very_good_optimization'])
library;

import 'package:build_verify/build_verify.dart';
import 'package:test/test.dart';

void main() {
  test('ensure_build', expectBuildClean);
}
