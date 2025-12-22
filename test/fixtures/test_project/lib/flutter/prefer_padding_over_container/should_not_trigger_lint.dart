import 'package:flutter/widgets.dart';

void notTrigger() {
  // Container with padding and other properties is acceptable
  Container(
    padding: EdgeInsets.all(8),
    color: Color(0xFF000000),
    child: Text('Hello'),
  );

  Container(
    decoration: BoxDecoration(color: Color(0xFF000000)),
    margin: EdgeInsets.all(16),
    child: Text('World'),
  );

  Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(8),
    child: Text('Foo'),
  );

  // Padding is the correct widget
  Padding(padding: EdgeInsets.all(8), child: Text('Bar'));

  // Container without padding or margin
  Container(color: Color(0xFF000000), child: Text('Baz'));

  // Container with both padding and other properties
  Container(
    padding: EdgeInsets.all(8),
    width: 100,
    height: 100,
    child: Text('Qux'),
  );
}
