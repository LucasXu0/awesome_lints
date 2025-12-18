import 'package:flutter/material.dart';

void main() {
  // expect_lint: prefer_constrained_box_over_container
  Container(
    constraints: const BoxConstraints(maxWidth: 200),
  );

  // expect_lint: prefer_constrained_box_over_container
  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    child: const Text('Hello'),
  );

  // expect_lint: prefer_constrained_box_over_container
  Container(
    constraints: const BoxConstraints(),
  );

  // expect_lint: prefer_constrained_box_over_container
  Container(
    constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
    child: const Text('Hello'),
  );

  // expect_lint: prefer_constrained_box_over_container
  Container(
    key: const Key('test'),
    constraints: const BoxConstraints(maxHeight: 100),
    child: const Text('Hello'),
  );
}
