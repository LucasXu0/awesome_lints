# Awesome Lints

Custom lint rules for Flutter applications using the `custom_lint` package.

## Available Lints

### avoid-single-child-column-or-row

Detects when a `Column` or `Row` widget has only a single child and suggests removing the unnecessary wrapper.

**Why?** Using `Column` or `Row` with a single child adds unnecessary nesting and complexity. In most cases, you can simply use the child widget directly.

**Bad:**
```dart
Column(
  children: [
    Text('Hello'),
  ],
)
```

**Good:**
```dart
Text('Hello')
```

**Note:** This lint will trigger for:
- Single child in a list literal: `children: [Text('Hello')]`
- Spread operators with single-element lists: `children: [...singleItemList]`
- Conditionals resulting in one child: `children: [if (true) Text('Hello')]`
- For loops with single iteration: `children: [for (var i = 0; i < 1; i++) Text('$i')]`

This lint will NOT trigger for:
- Multiple children in any form
- Empty children lists
- Spread operators with multiple items
- Conditionals/loops that result in multiple children

## Installation

1. Add this package to your `pubspec.yaml`:

```yaml
dev_dependencies:
  awesome_lints:
    path: path/to/awesome_lints
  custom_lint:
```

2. Add the plugin to your `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - avoid_single_child_column_or_row
```

3. Run the linter:

```bash
dart run custom_lint
```

## Running Tests

Unit tests:
```bash
dart test
```

Integration tests:
```bash
cd test/fixtures/test_project
flutter pub get
dart run custom_lint
```

## Development

This package is built using the `custom_lint_builder` package. To add new lint rules:

1. Create a new file in `lib/src/lints/<lint_name>.dart`
2. Implement your `DartLintRule` class
3. Add the rule to `lib/src/awesome_lints_plugin.dart`
4. Write unit tests in `test/lints/<lint_name>_test.dart`
5. Create integration test fixtures:
   - `test/fixtures/test_project/lib/<lint_name>/should_trigger_lint.dart`
   - `test/fixtures/test_project/lib/<lint_name>/should_not_trigger_lint.dart`

### Project Structure

```
lib/
  src/
    lints/
      <lint_name>.dart              # Lint rule implementation
    awesome_lints_plugin.dart       # Plugin registration
test/
  lints/
    <lint_name>_test.dart           # Unit tests
  fixtures/
    test_project/
      lib/
        <lint_name>/
          should_trigger_lint.dart
          should_not_trigger_lint.dart
      analysis_options.yaml
      pubspec.yaml
```
