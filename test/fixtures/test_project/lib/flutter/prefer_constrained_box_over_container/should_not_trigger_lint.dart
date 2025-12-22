import 'package:flutter/material.dart';

void main() {
  // Container with other properties - should not trigger
  Container(
    padding: const EdgeInsets.all(8),
    constraints: const BoxConstraints(maxWidth: 200),
  );

  Container(
    color: Colors.red,
    constraints: const BoxConstraints(maxWidth: 200),
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    margin: const EdgeInsets.all(8),
  );

  Container(
    decoration: const BoxDecoration(color: Colors.blue),
    constraints: const BoxConstraints(maxWidth: 200),
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    transform: Matrix4.identity(),
  );

  Container(
    alignment: Alignment.center,
    constraints: const BoxConstraints(maxWidth: 200),
    child: const Text('Hello'),
  );

  // Container without constraints - should not trigger

  Container(padding: const EdgeInsets.all(8), child: const Text('Hello'));

  Container(width: 200, height: 200, child: const Text('Hello'));

  // Already using ConstrainedBox - should not trigger
  ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 200),
    child: const Text('Hello'),
  );
}
