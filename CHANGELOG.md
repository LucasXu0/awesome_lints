# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2025-12-22

### BREAKING CHANGES

**Rules are now disabled by default (opt-in model)**

Previous versions (v2.0.0 and earlier) enabled all 128 rules automatically.
Starting with v2.1.0, rules must be explicitly enabled or configured via presets.

**Migration Required:**

To maintain v2.0.0 behavior (all rules enabled):

```yaml
# analysis_options.yaml
include: package:awesome_lints/presets/strict.yaml
```

To adopt the recommended preset (recommended for most projects):

```yaml
# analysis_options.yaml
include: package:awesome_lints/presets/recommended.yaml
```

For gradual adoption (core essential rules only):

```yaml
# analysis_options.yaml
include: package:awesome_lints/presets/core.yaml
```

See [Migration Guide](doc/feature/2025-12-22-opt-in-rules-by-default.md#migration-guide) for detailed instructions.

### Features

**New Preset Configurations:**

- `core.yaml` - Essential rules only (~15 rules)
  - Critical bug prevention
  - Null safety issues
  - Flutter lifecycle errors
  - Recommended for new projects

- `recommended.yaml` - Balanced rule set (~40 rules)
  - Includes all core rules
  - Code quality improvements
  - Common mistake prevention
  - Recommended for most projects

- `strict.yaml` - All rules enabled (128 rules)
  - Maintains v2.0.0 behavior
  - Comprehensive analysis
  - Recommended for very strict projects

- Category-specific presets:
  - `flutter.yaml` - All 32 Flutter rules
  - `common.yaml` - All 65 common Dart rules
  - `provider.yaml` - All 8 Provider rules
  - `bloc.yaml` - All 22 Bloc rules
  - `fake_async.yaml` - All FakeAsync rules

### Documentation

- Added comprehensive [Migration Guide](doc/feature/2025-12-22-opt-in-rules-by-default.md)
- Updated README with preset usage examples
- Updated all category documentation files
- Added preset comparison guide

### Migration Examples

**Before (v2.0.0):**
```yaml
# All rules enabled by default
custom_lint:
  rules:
    - avoid_non_null_assertion: false  # Must disable unwanted
    - no_magic_number: false           # Must disable unwanted
```

**After (v2.1.0):**
```yaml
# Use preset or enable specific rules
include: package:awesome_lints/presets/recommended.yaml

# Or enable specific rules only
custom_lint:
  enable_all_lint_rules: false
  rules:
    - avoid_late_context
    - prefer_early_return
```

---

## [2.0.0] - 2025-12-19

### Major Release - Framework-Specific Lints

🎉 Major expansion with 42 new lint rules across three new categories: Bloc, Provider, and FakeAsync, plus 11 new common lint rules!

#### New Categories

**Bloc Lints (22 rules)**

Framework-specific lints for the Bloc state management library:

- `avoid-bloc-public-fields` - Warns when a Bloc or Cubit has public fields
- `avoid-bloc-public-methods` - Warns when a Bloc has public methods except overridden ones
- `avoid-cubits` - Warns when a Cubit is used
- `avoid-duplicate-bloc-event-handlers` - Detects multiple handlers for the same event
- `avoid-empty-build-when` - Requires buildWhen condition in BlocBuilder/BlocConsumer
- `avoid-existing-instances-in-bloc-provider` - Prevents reusing instances in BlocProvider
- `avoid-instantiating-in-bloc-value-provider` - Prevents new instances in BlocProvider.value
- `avoid-passing-bloc-to-bloc` - Prevents Bloc dependencies on other Blocs
- `avoid-passing-build-context-to-blocs` - Prevents BuildContext in Bloc events/methods
- `avoid-returning-value-from-cubit-methods` - Ensures Cubits communicate via state
- `check-is-not-closed-after-async-gap` - Requires isClosed checks in async handlers
- `emit-new-bloc-state-instances` - Prevents emitting existing state instances
- `handle-bloc-event-subclasses` - Ensures all event subclasses are handled
- `prefer-bloc-event-suffix` - Enforces "Event" suffix for event classes
- `prefer-bloc-extensions` - Suggests context.read()/watch() over BlocProvider.of()
- `prefer-bloc-state-suffix` - Enforces "State" suffix for state classes
- `prefer-correct-bloc-provider` - Ensures BlocProvider is used for Blocs
- `prefer-immutable-bloc-events` - Requires @immutable on Bloc events
- `prefer-immutable-bloc-state` - Requires @immutable on Bloc state
- `prefer-multi-bloc-provider` - Suggests MultiBlocProvider for nested providers
- `prefer-sealed-bloc-events` - Requires sealed/final modifiers on event classes
- `prefer-sealed-bloc-state` - Requires sealed/final modifiers on state classes

**Provider Lints (8 rules)**

Framework-specific lints for the Provider state management library:

- `avoid-instantiating-in-value-provider` - Prevents new instances in Provider.value
- `avoid-read-inside-build` - Warns about read() usage in build methods
- `avoid-watch-outside-build` - Warns about watch()/select() outside build
- `dispose-providers` - Ensures proper disposal of provided resources
- `prefer-immutable-selector-value` - Requires immutable values in Selector
- `prefer-multi-provider` - Suggests MultiProvider for nested providers
- `prefer-nullable-provider-types` - Recommends nullable provider types
- `prefer-provider-extensions` - Suggests context extensions over Provider.of()

**FakeAsync Lints (1 rule)**

Testing-focused lints for the fake_async package:

- `avoid-async-callback-in-fake-async` - Prevents async callbacks in FakeAsync

#### New Common Lints (11 rules)

Enhanced common lints with new best practice rules:

- `prefer-async-await` - Suggests async/await over Future API
- `prefer-contains` - Suggests contains() over indexOf() != -1
- `prefer-correct-for-loop-increment` - Validates for-loop increment expressions
- `prefer-correct-json-casts` - Ensures proper JSON type casting
- `prefer-early-return` - Recommends early returns to reduce nesting
- `prefer-first` - Suggests first over [0] or elementAt(0)
- `prefer-iterable-of` - Suggests Iterable.of() over manual iteration
- `prefer-last` - Suggests last over [length - 1]
- `prefer-named-boolean-parameters` - Requires named parameters for booleans
- `prefer-return-await` - Suggests explicit return await in try blocks
- `prefer-switch-expression` - Recommends switch expressions over statements

### Documentation

- Added BLOC_LINTS.md with comprehensive Bloc lint documentation
- Added PROVIDER_LINTS.md with comprehensive Provider lint documentation
- Added FAKE_ASYNC_LINTS.md with FakeAsync lint documentation
- Updated test fixtures and configuration for new rules

### Summary

Version 2.0.0 introduces:
- **42 new lint rules** (22 Bloc + 8 Provider + 1 FakeAsync + 11 Common)
- **3 new framework-specific categories** (Bloc, Provider, FakeAsync)
- **Total of 128 lint rules** across all categories
- Enhanced coverage for popular Flutter state management solutions
- Improved testing practices with FakeAsync support

---

## [1.0.0] - 2025-12-19

### Initial Release

🎉 First stable release of Awesome Lints - a comprehensive collection of custom lint rules for Dart and Flutter applications.

#### Flutter-Specific Lints (32 rules)

**Widget Lifecycle & State Management:**
- `avoid-empty-setstate` - Warns when setState is called with an empty callback
- `avoid-late-context` - Prevents context access in late field initializers
- `avoid-mounted-in-setstate` - Ensures mounted checks occur before setState calls
- `avoid-stateless-widget-initialized-fields` - Warns about non-constant field initialization in StatelessWidget
- `avoid-unnecessary-overrides-in-state` - Detects unnecessary method overrides in State classes
- `avoid-unnecessary-stateful-widgets` - Warns when StatefulWidget doesn't use state
- `dispose-fields` - Ensures proper disposal of disposable fields
- `proper-super-calls` - Validates lifecycle method super calls

**Widget Building & Performance:**
- `avoid-missing-controller` - Warns when text fields lack controllers or callbacks
- `avoid-single-child-column-or-row` - Detects unnecessary Column/Row with single child
- `avoid-undisposed-instances` - Warns about undisposed Disposable instances
- `avoid-unnecessary-gesture-detector` - Suggests lighter alternatives to GestureDetector
- `avoid-wrapping-in-padding` - Prevents unnecessary Padding wrappers
- `pass-existing-future-to-future-builder` - Prevents inline future creation in FutureBuilder
- `pass-existing-stream-to-stream-builder` - Prevents inline stream creation in StreamBuilder
- `prefer-single-setstate` - Recommends consolidating multiple setState calls

**Widget Optimization:**
- `prefer-align-over-container` - Suggests Align instead of Container for alignment-only
- `prefer-center-over-align` - Suggests Center instead of Align(alignment: Alignment.center)
- `prefer-constrained-box-over-container` - Suggests ConstrainedBox for constraints-only scenarios
- `prefer-container` - Suggests Container to replace nested containerizable widgets
- `prefer-padding-over-container` - Suggests Padding instead of Container for padding-only

**Widget Best Practices:**
- `prefer-action-button-tooltip` - Recommends tooltips for action buttons
- `prefer-async-callback` - Suggests AsyncCallback instead of Future<void> Function()
- `prefer-compute-over-isolate-run` - Recommends compute over Isolate.run
- `prefer-dedicated-media-query-methods` - Suggests specific MediaQuery methods
- `prefer-for-loop-in-children` - Suggests for-loops over .map().toList() in children
- `prefer-sized-box-square` - Suggests SizedBox.square() for square boxes
- `prefer-sliver-prefix` - Enforces "Sliver" prefix for sliver widgets
- `prefer-spacing` - Suggests spacing parameter over SizedBox (Flutter 3.27+)
- `prefer-text-rich` - Suggests Text.rich() over RichText
- `prefer-void-callback` - Suggests VoidCallback over void Function()
- `prefer-widget-private-members` - Recommends private members for widget internals

#### Common Dart Lints (54 rules)

**Code Quality & Logic:**
- `arguments-ordering` - Enforces named arguments in declaration order
- `avoid-collapsible-if` - Suggests combining nested if statements
- `avoid-complex-arithmetic-expressions` - Warns about overly complex arithmetic
- `avoid-complex-conditions` - Warns about complex conditional expressions
- `avoid-complex-loop-conditions` - Warns about complex loop conditions
- `avoid-contradictory-expressions` - Detects logical contradictions
- `avoid-constant-assert-conditions` - Warns about constant assert conditions
- `avoid-constant-conditions` - Warns about constant if/while conditions
- `avoid-constant-switches` - Warns about constant switch expressions
- `binary-expression-operand-order` - Enforces consistent operand ordering

**Anti-Patterns & Potential Bugs:**
- `avoid-accessing-collections-by-constant-index` - Suggests first/last over [0]/[length-1]
- `avoid-accessing-other-classes-private-members` - Prevents accessing private members
- `avoid-always-null-parameters` - Warns about parameters always passed as null
- `avoid-assigning-to-static-field` - Warns about static field mutation
- `avoid-assignments-as-conditions` - Prevents assignments in conditions
- `avoid-async-call-in-sync-function` - Warns about unawaited async calls
- `avoid-bitwise-operators-with-booleans` - Prevents & and | with booleans
- `avoid-cascade-after-if-null` - Warns about cascades after ?.
- `avoid-collection-equality-checks` - Warns about == on collections
- `avoid-collection-methods-with-unrelated-types` - Detects type mismatches in collection methods
- `avoid-collection-mutating-methods` - Warns about mutating immutable collections
- `avoid-continue` - Suggests alternatives to continue statements
- `avoid-declaring-call-method` - Warns about call method declarations
- `avoid-non-null-assertion` - Warns about ! operator usage

**Type Safety:**
- `avoid-bottom-type-in-patterns` - Prevents Never in patterns
- `avoid-bottom-type-in-records` - Prevents Never in records
- `avoid-casting-to-extension-type` - Warns about extension type casts
- `no-object-declaration` - Prevents Object type usage

**Code Duplication & Redundancy:**
- `avoid-adjacent-strings` - Warns about adjacent string literals
- `avoid-conditions-with-boolean-literals` - Prevents comparing with true/false
- `avoid-duplicate-cascades` - Detects duplicate cascade operations
- `avoid-duplicate-collection-elements` - Warns about duplicate collection elements
- `no-boolean-literal-compare` - Prevents explicit true/false comparisons
- `no-equal-arguments` - Detects identical arguments to different parameters
- `no-equal-conditions` - Warns about duplicate conditions in if-else chains
- `no-equal-nested-conditions` - Warns about redundant nested conditions
- `no-equal-switch-case` - Detects switch cases with identical bodies
- `no-equal-switch-expression-cases` - Warns about switch cases returning same value
- `no-equal-then-else` - Detects identical if-else branches

**Code Style & Formatting:**
- `double-literal-format` - Enforces consistent double literal formatting
- `newline-before-case` - Enforces blank lines before case clauses
- `newline-before-constructor` - Enforces blank lines before constructors
- `newline-before-method` - Enforces blank lines before methods
- `newline-before-return` - Enforces blank lines before return statements

**Code Cleanliness:**
- `avoid-barrel-files` - Warns about barrel file pattern
- `avoid-commented-out-code` - Detects commented-out code
- `avoid-default-tostring` - Warns about default toString() usage
- `avoid-deprecated-usage` - Warns about deprecated API usage
- `avoid-double-slash-imports` - Prevents // in import paths
- `no-empty-block` - Warns about empty code blocks
- `no-empty-string` - Warns about empty string usage

**Resource Management:**
- `dispose-class-fields` - Ensures disposal of disposable class fields

**Magic Values:**
- `no-magic-number` - Requires named constants for numeric literals
- `no-magic-string` - Requires named constants for repeated strings

### Documentation

- Added comprehensive README.md with quick start guide
- Created FLUTTER_LINTS.md with detailed documentation for all Flutter rules
- Created COMMON_LINTS.md with detailed documentation for all common rules
- Each lint includes "Why?", "Bad", and "Good" examples

### Features

- All lints enabled by default
- Support for custom_lint configuration
- Compatible with Dart 3.10.0+
- Compatible with Flutter 3.0.0+
- IDE integration (VS Code, Android Studio, IntelliJ)
- Watch mode support for continuous analysis

---

## Future Releases

Future releases will be documented here. We follow semantic versioning:

- **MAJOR** version for incompatible API changes
- **MINOR** version for new functionality in a backward compatible manner
- **PATCH** version for backward compatible bug fixes

[2.1.0]: https://github.com/LucasXu0/awesome_lints/releases/tag/v2.1.0
[2.0.0]: https://github.com/LucasXu0/awesome_lints/releases/tag/v2.0.0
[1.0.0]: https://github.com/LucasXu0/awesome_lints/releases/tag/v1.0.0
