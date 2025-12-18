import 'package:flutter/widgets.dart';

void notTrigger() {
  GestureDetector(
    child: Text('Hello'),
    onTap: () {},
  );

  GestureDetector(
    child: Text('Hello'),
    onPanUpdate: (_) {},
  );
}
