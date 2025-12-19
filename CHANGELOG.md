# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[1.0.0]: https://github.com/your-username/awesome_lints/releases/tag/v1.0.0
