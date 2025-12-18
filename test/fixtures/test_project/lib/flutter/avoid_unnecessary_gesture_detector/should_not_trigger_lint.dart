import 'package:flutter/widgets.dart';

void notTrigger() {
  GestureDetector(
    onTap: () {},
    child: Text('Hello'),
  );

  GestureDetector(
    onPanUpdate: (_) {},
    child: Text('Hello'),
  );
}
