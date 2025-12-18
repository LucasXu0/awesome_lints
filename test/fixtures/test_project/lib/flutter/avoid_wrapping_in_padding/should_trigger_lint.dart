import 'package:flutter/widgets.dart';

void trigger() {
  // expect_lint: avoid_wrapping_in_padding
  Padding(
    padding: EdgeInsets.all(8),
    child: Container(
      color: Color(0xFF000000),
    ),
  );

  // expect_lint: avoid_wrapping_in_padding
  Padding(
    padding: EdgeInsets.all(8),
    // ignore: prefer_padding_over_container
    child: Container(
      padding: EdgeInsets.zero,
    ),
  );
}
