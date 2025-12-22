import 'package:flutter/material.dart';

void notTrigger() {
  // Using Text.rich - this is the preferred approach
  Text.rich(
    TextSpan(
      text: 'Hello ',
      children: [
        TextSpan(
          text: 'World',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  // Simple text with string
  Text('Simple string');

  // Text with style
  Text(
    'Styled text',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  // Text with various parameters
  Text(
    'Complex text',
    style: TextStyle(color: Colors.blue),
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
  );

  // Text.rich with proper usage
  Text.rich(
    TextSpan(
      children: [
        TextSpan(text: 'First'),
        TextSpan(
          text: ' Second',
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );

  // Text.rich with WidgetSpan
  Text.rich(
    TextSpan(
      children: [
        TextSpan(text: 'Icon: '),
        WidgetSpan(child: Icon(Icons.star)),
      ],
    ),
  );

  // Const Text.rich
  const Text.rich(TextSpan(text: 'Const text'));

  // Simple const text
  const Text('Constant text');

  // Text with styling
  Text(
    'No spans here',
    style: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    textAlign: TextAlign.left,
  );

  // Empty Text
  Text('');

  // Text with interpolation
  final name = 'User';
  Text('Hello $name');

  // Text.rich is the recommended way when working with TextSpan
  Text.rich(
    TextSpan(
      text: 'Complex ',
      children: [
        TextSpan(
          text: 'formatted ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: 'text',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
      style: TextStyle(fontSize: 16),
    ),
  );

  // Text.rich with single TextSpan
  Text.rich(
    TextSpan(
      text: 'Single span',
      style: TextStyle(color: Colors.blue),
    ),
  );
}
