// Test cases that should trigger the avoid_commented_out_code lint

void test() {
  // Case 1: Commented out function declaration
  // expect_lint: avoid_commented_out_code
  // void apply() { print('test'); }

  // Case 2: Commented out variable declaration
  // expect_lint: avoid_commented_out_code
  // final String name = 'test';

  // Case 3: Commented out assignment
  // expect_lint: avoid_commented_out_code
  // value = 42;

  // Case 4: Commented out if statement
  // expect_lint: avoid_commented_out_code
  // if (true) {

  // Case 5: Commented out for loop
  // expect_lint: avoid_commented_out_code
  // for (var i = 0; i < 10; i++) {

  // Case 6: Commented out method call
  // expect_lint: avoid_commented_out_code
  // someObject.doSomething();

  // Case 7: Commented out return statement
  // expect_lint: avoid_commented_out_code
  // return(value);

  // Case 8: Commented out import
  // expect_lint: avoid_commented_out_code
  // import 'package:flutter/material.dart';

  // Case 9: Commented out class declaration
  // expect_lint: avoid_commented_out_code
  // class MyClass {

  // Case 10: Commented out closing brace
  // expect_lint: avoid_commented_out_code
  // }

  // Case 11: Commented out annotation
  // expect_lint: avoid_commented_out_code
  // @override

  // Case 12: Commented out print statement
  // expect_lint: avoid_commented_out_code
  // print('debug');

  // Case 13: Commented out while loop
  // expect_lint: avoid_commented_out_code
  // while (condition) {

  print('test');
}
