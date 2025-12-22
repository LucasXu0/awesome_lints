import 'package:flutter/widgets.dart';

void trigger() {
  // expect_lint: prefer_padding_over_container
  Container(padding: EdgeInsets.all(8), child: Text('Hello'));

  // expect_lint: prefer_padding_over_container
  Container(margin: EdgeInsets.all(16), child: Text('World'));

  // expect_lint: prefer_padding_over_container
  Container(padding: EdgeInsets.symmetric(horizontal: 12));

  // expect_lint: prefer_padding_over_container
  Container(
    key: Key('test'),
    padding: EdgeInsets.all(8),
    child: Text('With key'),
  );
}
