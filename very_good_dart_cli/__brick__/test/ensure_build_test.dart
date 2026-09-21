@Tags(['version-verify', 'skip_very_good_optimization'])
library;

import 'dart:io';

import 'package:build_verify/build_verify.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('ensure_build', () async {
    // `build_verify` locates the package by joining `packageRelativeDirectory`
    // onto the git root, and throws when the result does not match the current
    // directory. Passing the package's path relative to the git root keeps the
    // check working when the package is not the repository root, as is the case
    // for a package resolving from a parent Pub workspace, or for one generated
    // into a subdirectory of an existing repository.
    final result = Process.runSync('git', ['rev-parse', '--show-toplevel']);
    final gitRoot = (result.stdout as String).trim();

    await expectBuildClean(
      packageRelativeDirectory: p.relative(
        Directory.current.resolveSymbolicLinksSync(),
        from: gitRoot,
      ),
    );
  });
}
