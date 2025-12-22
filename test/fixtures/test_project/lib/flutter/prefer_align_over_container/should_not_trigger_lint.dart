import 'package:flutter/widgets.dart';

void notTrigger() {
  // Container with alignment and other properties is acceptable
  Container(
    alignment: Alignment.topRight,
    transform: Matrix4.skewY(0.3),
    child: Text('Hello'),
  );

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
  Align(alignment: Alignment.topRight, child: Text('Bar'));

  // Container without alignment

  Container(padding: EdgeInsets.all(8), child: Text('Baz'));
}
