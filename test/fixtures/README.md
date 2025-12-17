# Test Fixtures

This directory contains test fixtures for integration testing of the custom lint rules.

## Directory Structure

```
test/fixtures/test_project/
  lib/
    <lint_name>/
      should_trigger_lint.dart
      should_not_trigger_lint.dart
  analysis_options.yaml
  pubspec.yaml
```

Each lint rule has its own subdirectory in `lib/` containing:
- `should_trigger_lint.dart` - Examples that should trigger the lint warning
- `should_not_trigger_lint.dart` - Examples that should NOT trigger the lint warning

## Running Integration Tests

To test the lint rules:

1. Navigate to the test project:
   ```bash
   cd test/fixtures/test_project
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run custom_lint:
   ```bash
   dart run custom_lint
   ```

## Expected Results for avoid_single_child_column_or_row

### lib/avoid_single_child_column_or_row/should_trigger_lint.dart
This file should show 8 warnings:
- Line 11: Column with single child
- Line 18: Row with single child
- Line 25: Column with single child and properties
- Line 38: Row with single child and properties
- Line 50: Inner Column with single child (nested case)
- Line 59: Column with spread operator (single item list)
- Line 64: Column with conditional (single child)
- Line 71: Row with for loop (single iteration)

### lib/avoid_single_child_column_or_row/should_not_trigger_lint.dart
This file should show NO warnings as all cases result in multiple children or empty lists.
