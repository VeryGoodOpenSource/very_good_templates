// Copyright (c) 2025, Very Good Ventures
// https://verygood.ventures

#include <stdint.h>

/// Example native function that adds two integers.
///
/// This function demonstrates how to create native code that can be called
/// from Dart using FFI (Foreign Function Interface).
///
/// Usage from Dart:
/// ```dart
/// import 'dart:ffi';
/// import 'package:{{project_name.snakeCase()}}_windows/{{project_name.snakeCase()}}_windows.dart';
///
/// @Native<Int32 Function(Int32, Int32)>()
/// external int add(int a, int b);
/// ```
int32_t add(int32_t a, int32_t b) {
    return a + b;
}
