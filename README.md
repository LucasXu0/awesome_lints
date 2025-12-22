# Awesome Lints

A comprehensive collection of custom lint rules for Dart and Flutter applications, built on top of the `custom_lint` package. These rules help you write cleaner, more maintainable, and bug-free code by catching common mistakes and enforcing best practices.

## Features

- 🎯 **32 Flutter-specific lints** - Catch Flutter widget issues, lifecycle problems, and performance pitfalls
- 🔍 **65 Common Dart lints** - General-purpose rules for any Dart codebase
- 📦 **8 Provider-specific lints** - Best practices for the Provider state management package
- 🧊 **22 Bloc-specific lints** - Best practices for the Bloc state management package
- ⏱️ **1 FakeAsync-specific lint** - Catch common testing mistakes with fake_async
- ⚡ **Fast analysis** - Built on custom_lint for efficient, real-time feedback
- 🛠️ **Easy to configure** - Flexible presets for different use cases, with optional customization
- 📚 **Well-documented** - Every rule includes examples and explanations

## Quick Start

### Installation

1. Add `awesome_lints` and `custom_lint` as dev dependencies:

```bash
dart pub add dev:awesome_lints
dart pub add dev:custom_lint
```

2. Configure `analysis_options.yaml` with a preset:

```yaml
analyzer:
  plugins:
    - custom_lint

# Choose a preset (recommended for most projects):
include: package:awesome_lints/presets/recommended.yaml
```

3. Run the linter:

```bash
# Analyze your project
dart run custom_lint

# Or with auto-fix support (where available)
dart run custom_lint --fix
```

### Usage in IDE

**VS Code:**
Install the [Dart extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) - custom_lint diagnostics will appear automatically.

**Android Studio / IntelliJ:**
Custom lint diagnostics will appear in the editor alongside standard Dart analysis.

**Watch Mode:**
For continuous analysis during development:
```bash
dart run custom_lint --watch
```

## Available Lints

### Flutter-Specific Rules

32 rules designed specifically for Flutter applications, covering:
- Widget lifecycle and state management
- Performance optimization
- Common Flutter anti-patterns
- Resource disposal
- Builder patterns and best practices

**[📖 View all Flutter lints →](lib/src/lints/flutter/FLUTTER_LINTS.md)**

Popular rules include:
- `avoid-late-context` - Prevents context usage in late field initializers
- `avoid-mounted-in-setstate` - Ensures proper mounted checks
- `prefer-spacing` - Use Flutter 3.27+ spacing parameter
- `pass-existing-future-to-future-builder` - Prevents future recreation on rebuild
- `prefer-container` - Suggests simplifying nested widgets

### Common Dart Rules

65 rules applicable to any Dart codebase, covering:
- Code quality and maintainability
- Logic errors and potential bugs
- Performance considerations
- Code style and consistency
- Null safety best practices

**[📖 View all Common lints →](lib/src/lints/common/COMMON_LINTS.md)**

Popular rules include:
- `avoid-non-null-assertion` - Warns about unsafe `!` operator usage
- `arguments-ordering` - Enforces parameter order consistency
- `no-equal-then-else` - Detects identical if/else branches
- `avoid-collection-equality-checks` - Prevents identity vs value equality bugs
- `no-magic-number` - Requires named constants for numeric literals

### Provider Rules

8 rules designed specifically for applications using the Provider package:
- Provider usage patterns and best practices
- Memory leak prevention
- Correctness checks for read/watch usage
- Code maintainability improvements

**[📖 View all Provider lints →](lib/src/lints/provider/PROVIDER_LINTS.md)**

Popular rules include:
- `avoid-read-inside-build` - Prevents read() usage in build methods
- `avoid-watch-outside-build` - Ensures watch() is only used in build
- `dispose-providers` - Checks for proper resource disposal
- `prefer-multi-provider` - Suggests MultiProvider over nested providers
- `prefer-provider-extensions` - Prefers context.read/watch over Provider.of

### Bloc Rules

22 rules designed specifically for applications using the Bloc package:
- Bloc/Cubit usage patterns and best practices
- Encapsulation and architectural correctness
- Event and state management
- Memory leak prevention
- Immutability enforcement

**[📖 View all Bloc lints →](lib/src/lints/bloc/BLOC_LINTS.md)**

Popular rules include:
- `avoid-bloc-public-fields` - Enforces private fields in Blocs/Cubits
- `avoid-bloc-public-methods` - Prevents public methods except overrides
- `avoid-passing-build-context-to-blocs` - Prevents BuildContext coupling
- `prefer-immutable-bloc-events` - Requires @immutable on event classes
- `prefer-sealed-bloc-state` - Requires sealed/final modifiers on state classes

### FakeAsync Rules

1 rule designed specifically for applications using the fake_async package for testing:
- Correctness checks for FakeAsync usage
- Prevent tests from always passing
- Ensure proper async testing patterns

**[📖 View all FakeAsync lints →](lib/src/lints/fake_async/FAKE_ASYNC_LINTS.md)**

Rules include:
- `avoid-async-callback-in-fake-async` - Prevents async callbacks in FakeAsync that aren't awaited

## Configuration

### Using Presets (Recommended)

`awesome_lints` provides preset configurations for different use cases:

| Preset | Rules | Use Case |
|--------|-------|----------|
| `core.yaml` | ~15 | Essential bug prevention only |
| `recommended.yaml` | ~40 | Balanced set (recommended for most projects) |
| `strict.yaml` | 128 | All rules (comprehensive analysis) |
| Category-specific | Varies | `flutter.yaml`, `common.yaml`, `provider.yaml`, `bloc.yaml`, `fake_async.yaml` |

**Quick Start (Recommended):**

```yaml
# analysis_options.yaml
include: package:awesome_lints/presets/recommended.yaml
```

**Maintain v2.0.0 Behavior (All Rules):**

```yaml
# analysis_options.yaml
include: package:awesome_lints/presets/strict.yaml
```

**Gradual Adoption (Core Rules Only):**

```yaml
# analysis_options.yaml
include: package:awesome_lints/presets/core.yaml
```

### Custom Configuration

You can extend presets and customize rules:

```yaml
# Start with recommended preset
include: package:awesome_lints/presets/recommended.yaml

custom_lint:
  rules:
    # Enable additional rules
    - no_magic_number:
        allowed_numbers: [0, 1, -1, 100]
    - prefer_switch_expression

    # Disable specific rules from the preset
    - avoid_barrel_files: false
```

### Manual Configuration (Advanced)

Enable rules manually without a preset:

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  enable_all_lint_rules: false
  rules:
    - avoid_non_null_assertion
    - no_magic_number
    - avoid_late_context
    # ... list all desired rules
```

## Development

### Project Structure

```
awesome_lints/
├── lib/
│   └── src/
│       ├── lints/
│       │   ├── flutter/           # Flutter-specific lints
│       │   │   ├── FLUTTER_LINTS.md
│       │   │   └── *.dart
│       │   ├── common/            # Common Dart lints
│       │   │   ├── COMMON_LINTS.md
│       │   │   └── *.dart
│       │   ├── provider/          # Provider-specific lints
│       │   │   ├── PROVIDER_LINTS.md
│       │   │   └── *.dart
│       │   ├── bloc/              # Bloc-specific lints
│       │   │   ├── BLOC_LINTS.md
│       │   │   └── *.dart
│       │   └── fake_async/        # FakeAsync-specific lints
│       │       ├── FAKE_ASYNC_LINTS.md
│       │       └── *.dart
│       └── awesome_lints_plugin.dart
├── test/
│   └── fixtures/
│       └── test_project/          # Test cases for all rules
└── README.md
```

### Adding a New Lint Rule

1. **Create the rule file:**
   - For Flutter rules: `lib/src/lints/flutter/your_rule_name.dart`
   - For common rules: `lib/src/lints/common/your_rule_name.dart`
   - For Provider rules: `lib/src/lints/provider/your_rule_name.dart`
   - For Bloc rules: `lib/src/lints/bloc/your_rule_name.dart`
   - For FakeAsync rules: `lib/src/lints/fake_async/your_rule_name.dart`

2. **Implement the `DartLintRule` class:**
```dart
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class YourRuleName extends DartLintRule {
  const YourRuleName() : super(code: _code);

  static const _code = LintCode(
    name: 'your_rule_name',
    problemMessage: 'Description of the problem',
    correctionMessage: 'How to fix it',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // Your lint logic here
  }
}
```

3. **Register the rule:**
   - Add export to `lib/src/lints/flutter/flutter.dart`, `lib/src/lints/common/common.dart`, `lib/src/lints/provider/provider.dart`, `lib/src/lints/bloc/bloc.dart`, or `lib/src/lints/fake_async/fake_async.dart`
   - Add the rule instance in `lib/src/awesome_lints_plugin.dart`

4. **Create test fixtures:**
```
test/fixtures/test_project/lib/your_rule_name/
├── should_trigger_lint.dart       # Use // expect_lint: your_rule_name
└── should_not_trigger_lint.dart   # Valid code that shouldn't trigger
```

5. **Document the rule:**
   - Add entry to `FLUTTER_LINTS.md`, `COMMON_LINTS.md`, `PROVIDER_LINTS.md`, `BLOC_LINTS.md`, or `FAKE_ASYNC_LINTS.md`
   - Include "Why?", "Bad", and "Good" examples

### Running Tests

```bash
# Navigate to test project
cd test/fixtures/test_project

# Install dependencies
flutter pub get

# Run the linter (this validates all test fixtures)
dart run custom_lint
```

Expected output: Lints should only appear on lines marked with `// expect_lint: rule_name`.

### Testing Locally

To test your rules in a real project:

```yaml
# In your test project's pubspec.yaml
dev_dependencies:
  awesome_lints:
    path: /absolute/path/to/awesome_lints
  custom_lint: ^0.7.0
```

## Requirements

- Dart SDK: 3.10.0 or higher
- Flutter SDK: 3.0.0 or higher (for Flutter-specific rules)
- custom_lint: ^0.7.0

## Contributing

Contributions are welcome! When submitting new rules:

1. Ensure the rule catches real-world problems or enforces valuable best practices
2. Provide clear documentation with examples
3. Include comprehensive test fixtures
4. Follow the existing code structure and style

### Documentation Templates

To maintain consistency across project documentation, use the templates in `doc/templates/`:

- **[Feature Documentation](doc/templates/FEATURE_TEMPLATE.md)** - For new features and breaking changes
- **[Migration Guides](doc/templates/MIGRATION_TEMPLATE.md)** - For version upgrade guides
- **[Optimization Docs](doc/templates/OPTIMIZATION_TEMPLATE.md)** - For code improvements and refactoring
- **[How-to Guides](doc/templates/HOW_TO_TEMPLATE.md)** - For tutorials and step-by-step guides

See [doc/templates/README.md](doc/templates/README.md) for detailed usage instructions and [doc/templates/QUICK_START.md](doc/templates/QUICK_START.md) for a quick reference.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Resources

- [custom_lint documentation](https://pub.dev/packages/custom_lint)
- [custom_lint_builder documentation](https://pub.dev/packages/custom_lint_builder)
- [Dart analyzer package](https://pub.dev/packages/analyzer)

## Acknowledgments

Built with [custom_lint](https://pub.dev/packages/custom_lint) by [Invertase](https://invertase.io).
