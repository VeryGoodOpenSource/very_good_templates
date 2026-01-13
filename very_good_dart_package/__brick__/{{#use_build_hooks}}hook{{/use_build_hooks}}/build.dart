// Copyright (c) 2025, Very Good Ventures
// https://verygood.ventures

import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

/// Build hook for compiling native C code.
///
/// This hook is automatically invoked during the build process to compile
/// native C sources into a dynamic library that can be used via Dart FFI.
///
/// For more information about build hooks, see:
/// https://dart.dev/tools/hooks
void main(List<String> args) async {
  await build(args, (input, output) async {
    final packageName = input.packageName;

    // Configure the C library builder
    final cbuilder = CBuilder.library(
      name: packageName,
      assetName: '$packageName.dart',
      sources: ['src/native_example.c'],
    );

    // Execute the build
    await cbuilder.run(input: input, output: output);
  });
}
