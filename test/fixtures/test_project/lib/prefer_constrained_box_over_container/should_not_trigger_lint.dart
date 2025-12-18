import 'package:flutter/material.dart';

void main() {
  // Container with other properties - should not trigger
  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    padding: const EdgeInsets.all(8),
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    color: Colors.red,
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    margin: const EdgeInsets.all(8),
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    decoration: const BoxDecoration(color: Colors.blue),
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    transform: Matrix4.identity(),
  );

  Container(
    constraints: const BoxConstraints(maxWidth: 200),
    alignment: Alignment.center,
    child: const Text('Hello'),
  );

  // Container without constraints - should not trigger
  // ignore: prefer_padding_over_container
  Container(
    padding: const EdgeInsets.all(8),
    child: const Text('Hello'),
  );

  Container(
    width: 200,
    height: 200,
    child: const Text('Hello'),
  );

  // Already using ConstrainedBox - should not trigger
  ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 200),
    child: const Text('Hello'),
  );
}
