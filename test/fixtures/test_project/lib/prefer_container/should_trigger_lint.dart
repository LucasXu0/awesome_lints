import 'package:flutter/widgets.dart';

void trigger() {
  // expect_lint: prefer_container
  Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Color(0xFF000000)),
        child: Text('Hello'),
      ),
    ),
  );

  // expect_lint: prefer_container
  Transform(
    transform: Matrix4.identity(),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topRight,
        child: Text('World'),
      ),
    ),
  );

  // expect_lint: prefer_container
  Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Text('Foo'),
      ),
    ),
  );
}
