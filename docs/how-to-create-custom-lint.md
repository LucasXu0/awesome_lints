# How to Create a Custom Lint Rule

This guide walks you through creating a new custom lint rule using the `custom_lint` package.

## Prerequisites

Ensure your `pubspec.yaml` has the required dependencies:

```yaml
dependencies:
  analyzer:
  analyzer_plugin:
  custom_lint_builder:
  flutter:
    sdk: flutter

dev_dependencies:
  test:
```

## Step 1: Create a New Lint File

Create a new file in `lib/src/lints/` with your lint rule name in snake_case.

**Example: `lib/src/lints/avoid_single_child_column_or_row.dart`**

```dart
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidSingleChildColumnOrRow extends DartLintRule {
  const AvoidSingleChildColumnOrRow() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_single_child_column_or_row',
    problemMessage:
        'Avoid using Column or Row with a single child. Consider removing the wrapper.',
    correctionMessage:
        'Remove the Column/Row wrapper and use the child directly.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Register a visitor for the AST nodes you want to check
    context.registry.addInstanceCreationExpression((node) {
      // Your lint logic here
      final type = node.staticType;
      if (type == null) return;

      final typeName = type.getDisplayString();

      // Check if it's a Column or Row
      if (typeName != 'Column' && typeName != 'Row') return;

      // Find the 'children' argument
      NamedExpression? childrenArg;
      try {
        childrenArg =
            node.argumentList.arguments.whereType<NamedExpression>().firstWhere(
                  (arg) => arg.name.label.name == 'children',
                );
      } catch (_) {
        return;
      }

      // Check if children is a list literal
      final expression = childrenArg.expression;
      if (expression is! ListLiteral) return;

      // Check if the list has exactly one element
      if (expression.elements.length != 1) return;

      // Report the issue
      reporter.atNode(node, _code);
    });
  }

  @override
  List<Fix> getFixes() => [_RemoveSingleChildWrapper()];
}

class _RemoveSingleChildWrapper extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    analyzer_error.AnalysisError analysisError,
    List<analyzer_error.AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final type = node.staticType;
      if (type == null) return;

      final typeName = type.getDisplayString();
      if (typeName != 'Column' && typeName != 'Row') return;

      // Find the 'children' argument
      NamedExpression? childrenArg;
      try {
        childrenArg =
            node.argumentList.arguments.whereType<NamedExpression>().firstWhere(
                  (arg) => arg.name.label.name == 'children',
                );
      } catch (_) {
        return;
      }

      final expression = childrenArg.expression;
      if (expression is! ListLiteral) return;

      if (expression.elements.length != 1) return;

      final singleChild = expression.elements.first;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Remove $typeName wrapper',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          node.sourceRange,
          singleChild.toSource(),
        );
      });
    });
  }
}
```

### Key Components:

1. **LintCode**: Defines the lint rule metadata (name, messages, severity)
2. **run() method**: Contains the logic to detect violations
3. **registry.addXXX()**: Registers AST node visitors (e.g., `addInstanceCreationExpression`, `addMethodInvocation`, etc.)
4. **reporter.atNode()**: Reports violations
5. **getFixes()**: Returns a list of automatic fixes (optional)

### Common AST Node Visitors:

- `addInstanceCreationExpression` - For widget constructors
- `addMethodInvocation` - For method calls
- `addFunctionDeclaration` - For function declarations
- `addClassDeclaration` - For class declarations
- `addVariableDeclaration` - For variable declarations

## Step 2: Register the Lint Rule

Add your lint rule to `lib/src/awesome_lints_plugin.dart`:

```dart
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'lints/avoid_single_child_column_or_row.dart';
import 'lints/your_new_lint_rule.dart'; // Add this

PluginBase createPlugin() => _AwesomeLints();

class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        AvoidSingleChildColumnOrRow(),
        YourNewLintRule(), // Add this
      ];
}
```

## Step 3: Create Unit Tests

Create a test file in `test/lints/<lint_name>_test.dart`:

**Example: `test/lints/avoid_single_child_column_or_row_test.dart`**

```dart
import 'package:awesome_lints/src/lints/avoid_single_child_column_or_row.dart';
import 'package:test/test.dart';

void main() {
  group('AvoidSingleChildColumnOrRow', () {
    test('lint code should be correct', () {
      const rule = AvoidSingleChildColumnOrRow();
      expect(rule.code.name, 'avoid_single_child_column_or_row');
      expect(
        rule.code.problemMessage,
        'Avoid using Column or Row with a single child. Consider removing the wrapper.',
      );
    });

    test('lint should have error severity WARNING', () {
      const rule = AvoidSingleChildColumnOrRow();
      expect(rule.code.errorSeverity.name, 'WARNING');
    });

    test('lint should provide correction message', () {
      const rule = AvoidSingleChildColumnOrRow();
      expect(
        rule.code.correctionMessage,
        'Remove the Column/Row wrapper and use the child directly.',
      );
    });
  });
}
```

## Step 4: Create Integration Test Fixtures

Create test fixture files in `test/fixtures/test_project/lib/<lint_name>/`:

### Structure:

```
test/fixtures/test_project/lib/<lint_name>/
  ├── should_trigger_lint.dart
  └── should_not_trigger_lint.dart
```

### Example: `should_trigger_lint.dart`

```dart
import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // This SHOULD trigger the lint warning
    final widget1 = Column(
      children: [
        Text('Single child'),
      ],
    );

    return Container();
  }
}
```

### Example: `should_not_trigger_lint.dart`

```dart
import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // This should NOT trigger - multiple children
    final widget1 = Column(
      children: [
        Text('First'),
        Text('Second'),
      ],
    );

    // This should NOT trigger - spread with multiple items
    final items = <Widget>[Text('Item 1'), Text('Item 2')];
    final widget2 = Column(
      children: [...items],
    );

    // This should NOT trigger - conditional with multiple total children
    final widget3 = Column(
      children: [
        Text('Always shown'),
        if (true) Text('Conditional'),
      ],
    );

    // This should NOT trigger - for loop with multiple iterations
    final widget4 = Row(
      children: [
        for (var i = 0; i < 3; i++) Text('Item $i'),
      ],
    );

    return Container();
  }
}
```

## Step 5: Verify and Analyze the Code

Run the following commands to ensure your code builds successfully without errors:

### 1. Format the code

```bash
dart format .
```

This will format all Dart files according to the Dart style guide.

### 2. Analyze the code

```bash
dart analyze
```

This will check for any errors, warnings, or lints in your code. You should see:

```
Analyzing awesome_lints...
No issues found!
```

### 3. Run unit tests

```bash
dart test
```

This will run all unit tests. You should see:

```
All tests passed!
```

### 4. Run integration tests

```bash
cd test/fixtures/test_project
flutter pub get
dart run custom_lint
```

This will run the custom lint on the test fixtures and show which files trigger warnings.

Expected output:

```
lib/avoid_single_child_column_or_row/should_trigger_lint.dart:11:18
  warning: Avoid using Column or Row with a single child. Consider removing the wrapper.
```

## Common Issues and Solutions

### Issue 1: Import conflicts with `LintCode`

**Error:**
```
'LintCode' is imported from both 'package:analyzer/...' and 'package:custom_lint_core/...'
```

**Solution:**
Use an alias for the analyzer import:
```dart
import 'package:analyzer/error/error.dart' as analyzer_error;
```

### Issue 2: `cast_from_null_always_fails`

**Error:**
```
This cast always throws an exception because the expression always evaluates to 'null'.
```

**Bad code:**
```dart
final item = list.firstWhere(
  (e) => e.condition,
  orElse: () => null as MyType,
);
```

**Solution:**
Use try-catch instead:
```dart
MyType? item;
try {
  item = list.firstWhere((e) => e.condition);
} catch (_) {
  return;
}
```

### Issue 3: Deprecated `withNullability`

**Error:**
```
'withNullability' is deprecated and shouldn't be used.
```

**Solution:**
Remove the parameter:
```dart
// Bad
final typeName = type.getDisplayString(withNullability: false);

// Good
final typeName = type.getDisplayString();
```

### Issue 4: Relative imports in tests

**Error:**
```
Can't use a relative path to import a library in 'lib'.
```

**Solution:**
Use package imports:
```dart
// Bad
import '../../lib/src/lints/my_lint.dart';

// Good
import 'package:awesome_lints/src/lints/my_lint.dart';
```

## Best Practices

1. **Name your lint rule descriptively** - Use `avoid_`, `prefer_`, or `use_` prefixes
2. **Provide clear messages** - Both `problemMessage` and `correctionMessage` should be helpful
3. **Handle null safely** - Always check for null before accessing properties
4. **Return early** - Use early returns to keep the code readable
5. **Test edge cases** - Include tests for both positive and negative cases
6. **Provide fixes when possible** - Implement `DartFix` to offer automatic corrections
7. **Document your lint** - Add comments explaining the lint's purpose and logic

## Testing Checklist

Before committing your lint rule, ensure:

- [ ] `dart format .` shows no changes needed
- [ ] `dart analyze` shows no issues
- [ ] `dart test` passes all tests
- [ ] Integration tests show expected warnings
- [ ] The lint rule has clear documentation
- [ ] Edge cases are handled properly
- [ ] Automatic fixes work correctly (if provided)

## Resources

- [custom_lint documentation](https://pub.dev/packages/custom_lint)
- [analyzer package API](https://pub.dev/documentation/analyzer/latest/)
- [AST nodes reference](https://pub.dev/documentation/analyzer/latest/dart_ast_ast/dart_ast_ast-library.html)
