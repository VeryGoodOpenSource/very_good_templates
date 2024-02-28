/// Merges all coverage files into one.
///
/// This is used as part of the GitHub `very_good_flutter_plugin` workflow to
/// merge all coverage files into one so that the coverage report and compared
/// with the coverage threshold.
///
/// Should be removed once the following Very Good CLI issue is resolved:
/// https://github.com/VeryGoodOpenSource/very_good_cli/issues/804
library;

import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  final coverageFilePath = 'coverage/lcov.info';
  final matches = Glob('**/$coverageFilePath');
  final outputLcovPath = path.join(Directory.current.path, coverageFilePath);
  File(outputLcovPath).createSync(recursive: true);

  final coverageFiles = matches.listSync().map((entity) => entity.path);

  final result = await Process.run('lcov', [
    for (final coverageFile in coverageFiles) ...[
      '--add-tracefile',
      coverageFile
    ],
    '--output-file',
    outputLcovPath
  ]);

  print(result.stdout);
}
