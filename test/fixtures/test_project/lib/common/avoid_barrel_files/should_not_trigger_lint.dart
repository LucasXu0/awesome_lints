// This file should NOT trigger the avoid_barrel_files lint

// Has both exports and local declarations
export 'package:flutter/material.dart';

class SomeClass {
  void doSomething() {}
}
