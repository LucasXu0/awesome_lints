import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_local_variable

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: MediaQuery.sizeOf() - should NOT trigger
    final size = MediaQuery.sizeOf(context);

    // Case 2: MediaQuery.maybeSizeOf() - should NOT trigger
    final maybeSize = MediaQuery.maybeSizeOf(context);

    // Case 3: MediaQuery.paddingOf() - should NOT trigger
    final padding = MediaQuery.paddingOf(context);

    // Case 4: MediaQuery.maybePaddingOf() - should NOT trigger
    final maybePadding = MediaQuery.maybePaddingOf(context);

    // Case 5: MediaQuery.viewInsetsOf() - should NOT trigger
    final viewInsets = MediaQuery.viewInsetsOf(context);

    // Case 6: MediaQuery.maybeViewInsetsOf() - should NOT trigger
    final maybeViewInsets = MediaQuery.maybeViewInsetsOf(context);

    // Case 7: MediaQuery.viewPaddingOf() - should NOT trigger
    final viewPadding = MediaQuery.viewPaddingOf(context);

    // Case 8: MediaQuery.maybeViewPaddingOf() - should NOT trigger
    final maybeViewPadding = MediaQuery.maybeViewPaddingOf(context);

    // Case 9: MediaQuery.devicePixelRatioOf() - should NOT trigger
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    // Case 10: MediaQuery.maybeDevicePixelRatioOf() - should NOT trigger
    final maybeDevicePixelRatio = MediaQuery.maybeDevicePixelRatioOf(context);

    // Case 11: MediaQuery.textScalerOf() - should NOT trigger
    final textScale = MediaQuery.textScalerOf(context);

    // Case 12: MediaQuery.maybeTextScalerOf() - should NOT trigger
    final maybeTextScale = MediaQuery.maybeTextScalerOf(context);

    // Case 13: MediaQuery.platformBrightnessOf() - should NOT trigger
    final brightness = MediaQuery.platformBrightnessOf(context);

    // Case 14: MediaQuery.maybePlatformBrightnessOf() - should NOT trigger
    final maybeBrightness = MediaQuery.maybePlatformBrightnessOf(context);

    // Case 15: MediaQuery.highContrastOf() - should NOT trigger
    final highContrast = MediaQuery.highContrastOf(context);

    // Case 16: MediaQuery.maybeHighContrastOf() - should NOT trigger
    final maybeHighContrast = MediaQuery.maybeHighContrastOf(context);

    // Case 17: MediaQuery.boldTextOf() - should NOT trigger
    final boldText = MediaQuery.boldTextOf(context);

    // Case 18: MediaQuery.maybeBoldTextOf() - should NOT trigger
    final maybeBoldText = MediaQuery.maybeBoldTextOf(context);

    // Case 19: MediaQuery.orientationOf() - should NOT trigger
    final orientation = MediaQuery.orientationOf(context);

    // Case 20: MediaQuery.maybeOrientationOf() - should NOT trigger
    final maybeOrientation = MediaQuery.maybeOrientationOf(context);

    return Container();
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 21: Using sizeOf in conditional - should NOT trigger
    if (MediaQuery.sizeOf(context).width > 600) {
      return Container();
    }

    // Case 22: Using platformBrightnessOf with equality - should NOT trigger
    if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
      return Container();
    }

    // Case 23: Using textScalerOf in calculation - should NOT trigger
    final fontSize = MediaQuery.textScalerOf(context).scale(14);

    return Container();
  }
}

// Case 24: Not MediaQuery at all - should NOT trigger
class CustomMediaQuery {
  static CustomMediaQuery of(BuildContext context) {
    return CustomMediaQuery();
  }

  static CustomMediaQuery? maybeOf(BuildContext context) {
    return null;
  }
}

class UsingCustomMediaQuery extends StatelessWidget {
  const UsingCustomMediaQuery({super.key});

  @override
  Widget build(BuildContext context) {
    // Should NOT trigger - different class
    final custom1 = CustomMediaQuery.of(context);
    final custom2 = CustomMediaQuery.maybeOf(context);

    return Container();
  }
}
