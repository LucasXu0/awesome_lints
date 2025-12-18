void goodExamples(int anotherNum) {
  // Use OR operator for multiple possible values
  if (anotherNum == 3 || anotherNum == 4) {
    print('valid');
  }

  // Non-contradictory bounds
  if (anotherNum < 4 && anotherNum > 2) {
    print('valid range');
  }

  // Single comparison
  if (anotherNum == 2) {
    print('equals two');
  }

  // Valid AND conditions
  if (anotherNum > 0 && anotherNum < 10) {
    print('in range');
  }
}
