import 'package:flutter/widgets.dart';

void notTrigger() {
  Padding(
    padding: EdgeInsets.all(8),
    child: Text('Hello'),
  );

  // ignore: prefer_padding_over_container
  Container(
    padding: EdgeInsets.all(8),
    child: Text('Hello'),
  );
}
