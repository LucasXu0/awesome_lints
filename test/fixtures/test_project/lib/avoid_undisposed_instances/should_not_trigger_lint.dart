// ignore_for_file: unused_import

import 'package:flutter/widgets.dart';

class DisposableClass {
  void dispose() {}
}

void notTrigger() {
  final instance = DisposableClass();
  instance.dispose();

  DisposableClass? nullableInstance;
  nullableInstance = DisposableClass();
  nullableInstance.dispose();
}
