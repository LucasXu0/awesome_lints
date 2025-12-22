import 'package:flutter/widgets.dart';

void notTrigger() {
  Padding(padding: EdgeInsets.all(8), child: Text('Hello'));

  Container(padding: EdgeInsets.all(8), child: Text('Hello'));
}
