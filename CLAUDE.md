# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`awesome_lints` is a comprehensive Dart/Flutter custom lint package built on `custom_lint`. It provides 128 lint rules across 5 categories:
- **Flutter** (32 rules): Widget lifecycle, performance, anti-patterns
- **Common Dart** (65 rules): General Dart best practices, logic errors, code quality
- **Provider** (8 rules): Provider state management patterns
- **Bloc** (22 rules): Bloc/Cubit patterns and architecture
- **FakeAsync** (1 rule): Testing with fake_async

## Configuration Model (v2.1.0+)

**Important:** As of v2.1.0, all lint rules are **disabled by default**. Users must opt-in via:
- Preset configurations (recommended)
- Manual rule enablement

### Presets

Located in `lib/presets/`:
- `core.yaml` - ~15 essential rules
- `recommended.yaml` - ~40 balanced rules
- `strict.yaml` - All 128 rules (maintains v2.0.0 behavior)
- Category presets: `flutter.yaml`, `common.yaml`, `provider.yaml`, `bloc.yaml`, `fake_async.yaml`

### Usage in Test Fixtures

Test fixtures should use strict preset to validate all rules:

```yaml
# test/fixtures/test_project/analysis_options.yaml
include: package:awesome_lints/presets/strict.yaml
```

## Common Commands

### Setup and Dependencies
```bash
# Initial setup (uses FVM for Flutter version management)
./scripts/dev-setup.sh

# Install dependencies
fvm flutter pub get

# Install test fixture dependencies
cd test/fixtures/test_project && fvm flutter pub get && cd ../../..
```

### Development Commands
```bash
# Run all verification checks (format, analyze, custom_lint)
./verify.sh

# Format code
fvm dart format lib test

# Analyze code
fvm dart analyze lib
fvm dart analyze test

# Run custom_lint on test fixtures
fvm dart run custom_lint test
```

### Testing
```bash
# Test lints by running custom_lint on test fixtures
cd test/fixtures/test_project
fvm dart run custom_lint

# Expected: Lints only appear on lines marked with // expect_lint: <rule_name>
```

### Creating a New Lint
```bash
# Generate boilerplate for a new lint rule
./scripts/new-lint.sh <lint_name> <category>

# Example:
./scripts/new-lint.sh prefer_final_fields common
```

## Architecture

### Plugin Registration (`lib/src/awesome_lints_plugin.dart`)

The main plugin class `_AwesomeLints` implements `PluginBase` and returns all lint rules via `getLintRules()`. Rules are organized in separate lists by category (commonLintRules, flutterLintRules, etc.) and all instantiated directly in the plugin class.

**To add a new lint:**
1. Export it from the category file (e.g., `lib/src/lints/common/common.dart`)
2. Add the rule instance to the appropriate list in `awesome_lints_plugin.dart`

### Lint Rule Structure

All lint rules extend `DartLintRule` and follow this pattern:

```dart
class RuleName extends DartLintRule {
  const RuleName() : super(code: _code);

  static const _code = LintCode(
    name: 'rule_name',           // snake_case
    problemMessage: '...',        // What's wrong
    correctionMessage: '...',     // How to fix
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addNodeType((node) {
      // Lint logic: check conditions and call reporter.atNode/atToken
    });
  }
}
```

### Shared Utilities (`lib/src/utils/`)

**`ast_extensions.dart`**: Extensions on AST nodes for common operations
- `ArgumentList.getNamedArgument(String name)`: Get named argument by name
- `Expression.simpleIdentifierName`: Extract identifier name
- `InvocationExpression.isOnThis`: Check if method called on `this`

**`disposal_utils.dart`**: Resource disposal checking
- `DisposalUtils.hasDisposalMethod(DartType)`: Check if type has dispose/close/cancel method

**`type_utils.dart`**: Type checking and analysis utilities
- Type hierarchy checks, widget type detection, Provider/Bloc type utilities

Always prefer using these utilities over implementing similar logic in individual rules.

### Test Fixtures (`test/fixtures/test_project/`)

Test fixtures are organized by category and rule name:
```
test/fixtures/test_project/lib/<category>/<rule_name>/
├── should_trigger_lint.dart       # Code that should trigger the lint
└── should_not_trigger_lint.dart   # Valid code that shouldn't trigger
```

**Important patterns:**
- Files start with a massive `// ignore_for_file:` header (auto-generated)
- Use `// expect_lint: rule_name` comment on lines where lint should trigger
- Running `dart run custom_lint` in the test project validates all fixtures
- Test project has dependencies: flutter, provider, flutter_bloc, fake_async

**Auto-generate ignore headers:**
```bash
./scripts/generate-test-ignores.sh
```

### Category Organization

Each category (`common/`, `flutter/`, `provider/`, `bloc/`, `fake_async/`) contains:
- Individual lint rule files (snake_case.dart)
- A barrel export file (e.g., `common.dart`) that exports all rules
- A documentation file (e.g., `COMMON_LINTS.md`) listing all rules with examples

## Development Workflow

1. **Create new lint**: `./scripts/new-lint.sh <name> <category>`
2. **Implement logic**: Edit generated file in `lib/src/lints/<category>/<name>.dart`
3. **Add test cases**: Update fixtures in `test/fixtures/test_project/lib/<category>/<name>/`
4. **Document**: Add entry to `lib/src/lints/<category>/<CATEGORY>_LINTS.md`
5. **Verify**: Run `./verify.sh` to check formatting, analysis, and lint tests
6. **Update README**: Increment rule count in `README.md` if needed

## Documentation Templates

When creating project documentation, use the standardized templates in `doc/templates/`:

### Available Templates

- **FEATURE_TEMPLATE.md** - For documenting new features, breaking changes, and architectural decisions
  - Use for: Major features, breaking changes, system refactors
  - Naming: `doc/feature/YYYY-MM-DD-feature-name.md`

- **MIGRATION_TEMPLATE.md** - For version upgrade and migration guides
  - Use for: Breaking changes requiring user migration
  - Naming: `doc/migration/vX.Y-to-vA.B.md`

- **OPTIMIZATION_TEMPLATE.md** - For optimization opportunities and refactoring analysis
  - Use for: Code improvements, performance optimizations, technical debt reduction
  - Naming: `doc/optimization/YYYY-MM-DD-HHMM-optimization-name.md`

- **HOW_TO_TEMPLATE.md** - For step-by-step tutorials and guides
  - Use for: Developer tutorials, workflow documentation
  - Naming: `doc/how-to-task-name.md`

### Quick Usage

```bash
# Create a feature document
cp doc/templates/FEATURE_TEMPLATE.md doc/feature/$(date +%Y-%m-%d)-my-feature.md

# Create a migration guide
cp doc/templates/MIGRATION_TEMPLATE.md doc/migration/v2.1-to-v2.2.md

# Create an optimization document
cp doc/templates/OPTIMIZATION_TEMPLATE.md doc/optimization/$(date +%Y-%m-%d-%H%M)-my-optimization.md

# Create a how-to guide
cp doc/templates/HOW_TO_TEMPLATE.md doc/how-to-my-task.md
```

See `doc/templates/README.md` for detailed guidance and `doc/templates/QUICK_START.md` for quick reference.

## FVM (Flutter Version Manager)

This project uses FVM to ensure consistent Flutter/Dart versions:
- Version specified in `.fvmrc`
- Always prefix commands with `fvm`: `fvm dart`, `fvm flutter`
- CI/CD workflows also use FVM

## Verification Script

`verify.sh` replicates GitHub Actions checks:
1. Install dependencies (main project + test fixtures)
2. Check formatting (lib + test)
3. Run analysis (lib + test)
4. Run custom_lint on test fixtures

Always run this before committing to catch issues early.

## Key Conventions

- **Lint names**: Always snake_case (e.g., `avoid_non_null_assertion`)
- **Class names**: PascalCase matching the lint name (e.g., `AvoidNonNullAssertion`)
- **Error severity**: Most rules use `DiagnosticSeverity.WARNING`
- **Registry pattern**: Use `context.registry.add<NodeType>()` in the `run()` method
- **Reporting**: Use `reporter.atNode()`, `reporter.atToken()`, or `reporter.atOffset()` to report issues
- **Test expectations**: Use `// expect_lint: rule_name` comments in fixture files

## CI/CD Workflows

The project has GitHub Actions workflows that run on every push/PR:
- `lint.yml`: Formatting and analysis checks
- `test.yml`: Runs tests and verification script
- `pr-validation.yml`: Validates new lints have tests and documentation
