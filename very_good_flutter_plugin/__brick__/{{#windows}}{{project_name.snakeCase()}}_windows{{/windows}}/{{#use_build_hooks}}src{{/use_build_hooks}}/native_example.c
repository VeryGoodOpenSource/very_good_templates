// Copyright (c) 2025, Very Good Ventures
// https://verygood.ventures

#include <stdint.h>

/// Example native function that adds two integers.
///
/// This function demonstrates how to create native code that can be called
/// from Dart using FFI (Foreign Function Interface).
///
/// This function is compiled by the build hook and automatically linked
/// to the Dart bindings in lib/src/native_bindings.dart using the @Native
/// annotation.
///
/// For more information, see:
/// https://dart.dev/tools/hooks#reference-assets
int32_t add(int32_t a, int32_t b) {
    return a + b;
}
