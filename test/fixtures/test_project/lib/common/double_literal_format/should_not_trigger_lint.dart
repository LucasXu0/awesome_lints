// Test cases that should NOT trigger double_literal_format lint
// ignore_for_file: dead_code, unused_local_variable, deaded_code

void testCorrectDoubleLiterals() {
  // Correct formatting
  var a = 0.257;
  var b = 0.21;
  var c = 5.23;
  var d = 1.0;
  var e = 0.5;
  var f = 3.14;
  var g = 10.0;
  var h = 0.0;

  // Integer literals (not doubles)
  var i = 5;
  var j = 10;
}
