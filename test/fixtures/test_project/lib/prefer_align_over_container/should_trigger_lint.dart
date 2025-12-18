import 'package:flutter/widgets.dart';

void trigger() {
  // expect_lint: prefer_align_over_container
  Container(
    alignment: Alignment.topRight,
    child: Text('Hello'),
  );

  // expect_lint: prefer_align_over_container
  Container(
    alignment: Alignment.center,
  );

  // expect_lint: prefer_align_over_container
  Container(
    child: Text('World'),
    alignment: Alignment.bottomLeft,
  );
}
