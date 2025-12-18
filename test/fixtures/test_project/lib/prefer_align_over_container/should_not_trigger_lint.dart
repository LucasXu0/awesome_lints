import 'package:flutter/widgets.dart';

void notTrigger() {
  // Container with alignment and other properties is acceptable
  Container(
    alignment: Alignment.topRight,
    transform: Matrix4.skewY(0.3),
    child: Text('Hello'),
  );

  // ignore: prefer_center_over_align
  Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(8),
    child: Text('World'),
  );

  Container(
    alignment: Alignment.bottomLeft,
    color: Color(0xFF000000),
    child: Text('Foo'),
  );

  // Align is the correct widget
  Align(
    alignment: Alignment.topRight,
    child: Text('Bar'),
  );

  // Container without alignment
  // ignore: prefer_padding_over_container
  Container(
    padding: EdgeInsets.all(8),
    child: Text('Baz'),
  );
}
