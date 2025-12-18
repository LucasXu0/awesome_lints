import 'package:flutter/material.dart';

void trigger() {
  // This file demonstrates cases where Text.rich would be more appropriate
  // Note: These use RichText which is the underlying widget, to demonstrate
  // the pattern without compilation errors

  // While technically valid, using RichText.text would be better as Text.rich
  // expect_lint: prefer_text_rich
  RichText(
    text: TextSpan(
      text: 'Hello ',
      children: [
        TextSpan(text: 'World'),
      ],
    ),
  );

  // expect_lint: prefer_text_rich
  RichText(
    text: TextSpan(
      text: 'Bold text',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  // expect_lint: prefer_text_rich
  RichText(
    text: TextSpan(
      children: [
        TextSpan(text: 'First part '),
        TextSpan(
          text: 'bold part',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: ' last part'),
      ],
    ),
  );

  // expect_lint: prefer_text_rich
  RichText(
    text: WidgetSpan(
      child: Icon(Icons.star),
    ),
  );

  // expect_lint: prefer_text_rich
  RichText(
    text: TextSpan(
      text: 'Text with widget',
      children: [
        WidgetSpan(child: Icon(Icons.favorite)),
        TextSpan(text: ' inline'),
      ],
    ),
  );

  final span = TextSpan(text: 'Dynamic span');
  // expect_lint: prefer_text_rich
  RichText(text: span);
}
