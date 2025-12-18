import 'package:flutter/material.dart';

void main() {
  // Non-center alignment - should not trigger
  const Align(
    alignment: Alignment.topLeft,
    child: Text('Hello'),
  );

  const Align(
    alignment: Alignment.bottomRight,
    child: Text('Hello'),
  );

  const Align(
    alignment: Alignment.centerLeft,
    child: Text('Hello'),
  );

  const Align(
    alignment: Alignment(0.5, 0.5),
    child: Text('Hello'),
  );

  // Already using Center - should not trigger
  const Center(
    child: Text('Hello'),
  );

  const Center();

  // Align with other properties besides alignment and child - should not trigger
  Align(
    alignment: Alignment.center,
    heightFactor: 2.0,
    child: const Text('Hello'),
  );

  Align(
    alignment: Alignment.center,
    widthFactor: 2.0,
    child: const Text('Hello'),
  );
}
