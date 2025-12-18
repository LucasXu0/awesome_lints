import 'package:flutter/material.dart';

void main() {
  // expect_lint: prefer_center_over_align
  const Align(
    alignment: Alignment.center,
    child: Text('Hello'),
  );

  // expect_lint: prefer_center_over_align
  const Align(
    alignment: Alignment.center,
  );

  // expect_lint: prefer_center_over_align
  const Align(
    child: Text('Hello'),
  );

  // expect_lint: prefer_center_over_align
  const Align();

  // expect_lint: prefer_center_over_align
  const Align(
    alignment: Alignment(0, 0),
    child: Text('Hello'),
  );

  // expect_lint: prefer_center_over_align
  const Align(
    alignment: Alignment(0.0, 0.0),
    child: Text('Hello'),
  );
}
