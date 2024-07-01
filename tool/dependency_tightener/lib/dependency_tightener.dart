/// A Very Good Project created by Very Good CLI.
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

export 'src/dependency_tightener.dart';

void main(
  List<String> args, {
  void Function(Object? object) log = print,
}) {
  final argumentParser = ArgParser()
    ..addOption(
      'directory',
      defaultsTo: Directory.current.path,
    );
  final arguments = argumentParser.parse(args);

  final targetDirectory = Directory(arguments['directory'] as String);

  final pubspecFiles = targetDirectory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('pubspec.yaml'))
      .toList();
  log('Found ${pubspecFiles.length} pubspec.yaml files.');
}
