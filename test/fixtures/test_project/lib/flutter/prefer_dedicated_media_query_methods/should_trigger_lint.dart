import 'package:flutter/material.dart';

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: MediaQuery.of() - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    final mediaQuery1 = MediaQuery.of(context);

    // Case 2: MediaQuery.maybeOf() - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    final mediaQuery2 = MediaQuery.maybeOf(context);

    // Case 3: MediaQuery.of() used to get size - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    final size1 = MediaQuery.of(context).size;

    // Case 4: MediaQuery.maybeOf() used to get padding - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    final padding1 = MediaQuery.maybeOf(context)?.padding;

    // Case 5: MediaQuery.of() used to get platformBrightness - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    final brightness1 = MediaQuery.of(context).platformBrightness;

    // Case 6: MediaQuery.maybeOf() used to get textScaler - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    final textScale1 = MediaQuery.maybeOf(context)?.textScaler;

    // Case 7: MediaQuery.of() used in conditional - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    if (MediaQuery.of(context).size.width > 600) {
      // do something
    }

    // Case 8: MediaQuery.maybeOf() null check - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    if (MediaQuery.maybeOf(context) != null) {
      // do something
    }

    return Container();
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 9: MediaQuery.of() in a method call - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    _processMediaQuery(MediaQuery.of(context));

    // Case 10: MediaQuery.maybeOf() in a method call - should trigger
    // expect_lint: prefer_dedicated_media_query_methods
    _processMediaQueryMaybe(MediaQuery.maybeOf(context));

    return Container();
  }

  void _processMediaQuery(MediaQueryData data) {}

  void _processMediaQueryMaybe(MediaQueryData? data) {}
}
