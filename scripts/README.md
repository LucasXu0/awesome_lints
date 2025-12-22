# Development Scripts

This directory contains helper scripts for developing awesome_lints.

## Available Scripts

### `dev-setup.sh`

Sets up the development environment for awesome_lints.

**Usage:**
```bash
./scripts/dev-setup.sh
```

**What it does:**
- Checks for FVM installation
- Installs the correct Flutter version from `.fvmrc`
- Installs dependencies for the main project
- Installs dependencies for test fixtures
- Runs analysis and verification

**When to use:**
- First time setting up the project
- After pulling major changes
- When dependencies are out of sync

---

### `new-lint.sh`

Generates boilerplate for a new lint rule.

**Usage:**
```bash
./scripts/new-lint.sh <lint_name> <category>
```

**Arguments:**
- `lint_name` - Name in snake_case (e.g., `avoid_empty_setstate`)
- `category` - One of: `common`, `flutter`, `provider`, `bloc`, `fake_async`

**Example:**
```bash
./scripts/new-lint.sh prefer_final_fields common
```

**What it generates:**
- Lint implementation file in `lib/src/lints/<category>/<lint_name>.dart`
- Test fixture directory in `test/fixtures/test_project/lib/<category>/<lint_name>/`
- `should_trigger_lint.dart` - Examples that should trigger the lint
- `should_not_trigger_lint.dart` - Examples that should NOT trigger the lint
- Updates category export file

**Next steps after generating:**
1. Implement the lint logic in the generated file
2. Add test cases to the fixture files
3. Document the lint in `lib/src/lints/<category>/<CATEGORY>_LINTS.md`
4. Run `./verify.sh` to ensure everything works
5. Update `README.md` if the lint count changed

---

## Development Workflow

### Creating a New Lint

1. Generate the boilerplate:
   ```bash
   ./scripts/new-lint.sh my_new_lint flutter
   ```

2. Implement the lint logic in the generated file

3. Add test cases in the fixture directory

4. Document the lint in the appropriate LINTS.md file

5. Test your changes:
   ```bash
   fvm dart analyze
   ./verify.sh
   ```

### Using Shared Utilities

When implementing lints, prefer using shared utilities to avoid code duplication:

**For disposal checking:**
```dart
import '../../utils/disposal_utils.dart';

// Instead of implementing your own disposal checking
if (DisposalUtils.hasDisposalMethod(type)) {
  // Type has dispose, close, or cancel method
}
```

**For AST manipulation:**
```dart
import '../../utils/ast_extensions.dart';

// Get named arguments easily
final childrenArg = node.argumentList.getNamedArgument('children');

// Extract identifier names
final fieldName = expression.simpleIdentifierName;

// Check for 'this' references
if (invocation.isOnThis) {
  // Method called on current instance
}
```

---

## CI/CD Workflows

The project has several GitHub Actions workflows:

- **`lint.yml`** - Runs on every push/PR, checks formatting and analysis
- **`pr-validation.yml`** - Validates PRs for new lints (checks for tests, documentation)

When creating a PR with new lints, ensure:
- Test fixtures exist in `test/fixtures/test_project/lib/<category>/<lint_name>/`
- Documentation is added to the relevant `LINTS.md` file
- `README.md` lint count is updated if needed
- `./verify.sh` passes locally

---

## Tips

- Use `fvm` prefix for all commands to ensure correct Flutter/Dart version
- Run `./verify.sh` before committing to catch issues early
- Check existing lints in the same category for implementation examples
- Keep lint logic simple and focused on a single responsibility
- Document the "why" not just the "what" in lint messages
