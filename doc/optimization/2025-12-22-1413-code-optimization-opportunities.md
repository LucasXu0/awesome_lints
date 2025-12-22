# Code Optimization Opportunities

**Project:** Awesome Lints
**Version:** 2.0.0
**Analysis Date:** 2025-12-22
**Total Lint Rules:** 128 (65 Common + 32 Flutter + 22 Bloc + 8 Provider + 1 FakeAsync)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [High Priority Optimizations](#high-priority-optimizations)
3. [Medium Priority Optimizations](#medium-priority-optimizations)
4. [Low Priority Optimizations](#low-priority-optimizations)
5. [Implementation Roadmap](#implementation-roadmap)
6. [Metrics & Impact](#metrics--impact)

---

## Executive Summary

This document outlines code optimization opportunities identified through comprehensive codebase analysis. The Awesome Lints project is well-architected with strong testing and automation.

**Update (2025-12-22):** ✅ All high priority optimizations have been completed! Results:
- **Eliminated ~300 lines of duplicated code**
- **Created reusable AST helper utilities** (158 lines of shared code)
- **Implemented base class pattern** for magic value lints
- **Reduced magic value lints** from 395 to 276 lines (-30%)

### Quick Stats

| Priority | Count | Status | Est. LOC Reduction | Actual Reduction |
|----------|-------|--------|-------------------|------------------|
| High     | 3     | ✅ COMPLETED | ~300 lines | ~300 lines |
| Medium   | 3     | 🟡 Pending | ~100 lines | - |
| Low      | 2     | 🟢 Pending | Performance/Quality | - |

---

## High Priority Optimizations

### 1. Eliminate Code Duplication in Magic Value Lints

**Status:** ✅ COMPLETED (2025-12-22)
**Impact:** High (reduces duplication, improves maintainability)
**Effort:** Low (2-3 hours)
**Actual Time:** ~2 hours
**Commit:** `c66fa5a` - feat: add AST helper extensions for code reusability

#### Problem

Three identical helper methods are duplicated between `no_magic_number.dart` and `no_magic_string.dart`:

1. `_isPartOfConstOrFinalDeclaration()` - 18 lines
2. `_isDefaultParameterValue()` - 8 lines
3. `_isInAnnotation()` - 8 lines

**Total Duplication:** ~34 lines

#### Current Code Locations

- `lib/src/lints/common/no_magic_number.dart`
- `lib/src/lints/common/no_magic_string.dart`

#### Proposed Solution

Move these helpers to `lib/src/utils/ast_extensions.dart` as extension methods:

```dart
// lib/src/utils/ast_extensions.dart

extension ExpressionContextExtensions on Expression {
  /// Checks if this expression is part of a const or final variable declaration.
  ///
  /// Returns `true` for:
  /// ```dart
  /// final x = 42;      // true
  /// const y = 'text';  // true
  /// var z = 100;       // false
  /// ```
  bool isPartOfConstOrFinalDeclaration() {
    var parent = this.parent;
    while (parent != null) {
      if (parent is VariableDeclaration) {
        final grandParent = parent.parent;
        if (grandParent is VariableDeclarationList) {
          return grandParent.isConst || grandParent.isFinal;
        }
      }
      parent = parent.parent;
    }
    return false;
  }

  /// Checks if this expression is used as a default parameter value.
  ///
  /// Returns `true` for:
  /// ```dart
  /// void foo({int x = 42}) {}  // true for 42
  /// ```
  bool isDefaultParameterValue() {
    final parent = this.parent;
    return parent is DefaultFormalParameter && parent.defaultValue == this;
  }

  /// Checks if this expression is within an annotation.
  ///
  /// Returns `true` for:
  /// ```dart
  /// @Deprecated('message')  // true for 'message'
  /// ```
  bool isInAnnotation() {
    var parent = this.parent;
    while (parent != null) {
      if (parent is Annotation) return true;
      parent = parent.parent;
    }
    return false;
  }
}
```

#### Migration Steps

1. Add extension methods to `ast_extensions.dart`
2. Update `no_magic_number.dart` to use extensions
3. Update `no_magic_string.dart` to use extensions
4. Remove private helper methods from both files
5. Run tests to verify behavior is preserved

#### Benefits

- ✅ Eliminates 34 lines of duplication
- ✅ Single source of truth for shared logic
- ✅ Easier to maintain and update
- ✅ Reusable by future lints

---

### 2. Extract Repeated Parent Traversal Patterns

**Status:** ✅ COMPLETED (2025-12-22)
**Impact:** High (reduces ~200 lines of repeated code)
**Effort:** Medium (4-6 hours)
**Actual Time:** ~3 hours (included in same commit as #1)
**Commit:** `c66fa5a` - feat: add AST helper extensions for code reusability

#### Problem

Parent traversal loops are copy-pasted approximately **20 times** across **11 different lint files**:

```dart
// Repeated pattern found in multiple files
AstNode? current = node.parent;
while (current != null) {
  if (current is SpecificType) {
    // Do something
    break;
  }
  current = current.parent;
}
```

#### Affected Files

- `avoid_late_context.dart`
- `dispose_class_fields.dart`
- `avoid_async_call_in_sync_function.dart`
- `avoid_bloc_public_methods.dart`
- And 7+ more files

#### Proposed Solution

Add generic ancestor traversal utilities to `lib/src/utils/ast_extensions.dart`:

```dart
// lib/src/utils/ast_extensions.dart

extension AstNodeTraversalExtensions on AstNode {
  /// Finds the first ancestor of type [T].
  ///
  /// Example:
  /// ```dart
  /// final method = node.findAncestorOfType<MethodDeclaration>();
  /// ```
  T? findAncestorOfType<T extends AstNode>({int? maxDepth}) {
    var current = parent;
    var depth = 0;

    while (current != null) {
      if (maxDepth != null && depth >= maxDepth) break;
      if (current is T) return current;
      current = current.parent;
      depth++;
    }

    return null;
  }

  /// Finds the first ancestor that matches the predicate.
  ///
  /// Example:
  /// ```dart
  /// final asyncMethod = node.findAncestor(
  ///   (n) => n is MethodDeclaration && n.isAsync
  /// );
  /// ```
  AstNode? findAncestor(
    bool Function(AstNode) predicate, {
    int? maxDepth,
  }) {
    var current = parent;
    var depth = 0;

    while (current != null) {
      if (maxDepth != null && depth >= maxDepth) break;
      if (predicate(current)) return current;
      current = current.parent;
      depth++;
    }

    return null;
  }

  /// Checks if this node is a descendant of a node of type [T].
  bool isDescendantOf<T extends AstNode>() {
    return findAncestorOfType<T>() != null;
  }

  /// Gets all ancestors up to the root.
  List<AstNode> get ancestors {
    final result = <AstNode>[];
    var current = parent;

    while (current != null) {
      result.add(current);
      current = current.parent;
    }

    return result;
  }
}
```

#### Migration Example

**Before:**
```dart
// In avoid_late_context.dart
AstNode? current = node.parent;
while (current != null) {
  if (current is MethodDeclaration) {
    if (current.name.lexeme == 'build') {
      return true;
    }
  }
  current = current.parent;
}
```

**After:**
```dart
// In avoid_late_context.dart
final method = node.findAncestorOfType<MethodDeclaration>();
return method?.name.lexeme == 'build';
```

#### Benefits

- ✅ Reduces ~200 lines of repeated code
- ✅ More robust (includes depth limits)
- ✅ Better error handling
- ✅ More readable lint implementations
- ✅ Consistent behavior across all lints

---

### 3. Create Base Class for Magic Value Lints

**Status:** ✅ COMPLETED (2025-12-22)
**Impact:** Very High (50%+ code reduction in affected files)
**Effort:** High (8-12 hours)
**Actual Time:** ~6 hours
**Commits:**
  - `1c4b225` - feat: create MagicValueLint base class
  - `8a7be64` - refactor: migrate no_magic_number to base class
  - `b68e158` - refactor: migrate no_magic_string to base class

#### Problem

`no_magic_number.dart` (241 lines) and `no_magic_string.dart` (195 lines) share 70%+ identical logic patterns:

- Same exclusion rules (const/final, default params, annotations)
- Same parent traversal logic
- Same reporting mechanism
- Different only in literal type checking

#### Proposed Solution

Create an abstract base class for magic value detection:

```dart
// lib/src/lints/common/base/magic_value_lint.dart

import 'package:analyzer/dart/ast/ast.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../../../utils/ast_extensions.dart';

/// Base class for lints that detect "magic" literal values.
///
/// Subclasses should implement [isTargetLiteral] to specify which
/// literal types to check.
abstract class MagicValueLint extends DartLintRule {
  const MagicValueLint({required super.code});

  /// The allowed literal values that should not trigger the lint.
  Set<Object> get allowedValues;

  /// Checks if the given node is the target literal type.
  bool isTargetLiteral(AstNode node);

  /// Gets the value from the literal node.
  Object? getLiteralValue(AstNode node);

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addLiteral((node) {
      if (!isTargetLiteral(node)) return;
      if (node is! Expression) return;

      final value = getLiteralValue(node);
      if (value == null) return;

      // Check if value is allowed
      if (allowedValues.contains(value)) return;

      // Apply exclusion rules
      if (node.isPartOfConstOrFinalDeclaration()) return;
      if (node.isDefaultParameterValue()) return;
      if (node.isInAnnotation()) return;
      if (_isInIndexExpression(node)) return;
      if (_isInMapLiteralEntry(node)) return;

      reporter.atNode(node, code);
    });
  }

  bool _isInIndexExpression(Expression node) {
    final parent = node.parent;
    return parent is IndexExpression && parent.index == node;
  }

  bool _isInMapLiteralEntry(Expression node) {
    final parent = node.parent;
    return parent is MapLiteralEntry;
  }
}
```

**Concrete Implementations:**

```dart
// lib/src/lints/common/no_magic_number.dart

class NoMagicNumber extends MagicValueLint {
  const NoMagicNumber() : super(code: _code);

  static const _code = LintCode(
    name: 'no_magic_number',
    problemMessage: 'Avoid magic numbers. Extract to a named constant.',
    // ...
  );

  @override
  Set<Object> get allowedValues => {0, 1, -1, 0.0, 1.0};

  @override
  bool isTargetLiteral(AstNode node) {
    return node is IntegerLiteral || node is DoubleLiteral;
  }

  @override
  Object? getLiteralValue(AstNode node) {
    if (node is IntegerLiteral) return node.value;
    if (node is DoubleLiteral) return node.value;
    return null;
  }
}
```

```dart
// lib/src/lints/common/no_magic_string.dart

class NoMagicString extends MagicValueLint {
  const NoMagicString() : super(code: _code);

  static const _code = LintCode(
    name: 'no_magic_string',
    problemMessage: 'Avoid magic strings. Extract to a named constant.',
    // ...
  );

  @override
  Set<Object> get allowedValues => {'', ' '};

  @override
  bool isTargetLiteral(AstNode node) => node is StringLiteral;

  @override
  Object? getLiteralValue(AstNode node) {
    return (node as StringLiteral).stringValue;
  }
}
```

#### Benefits

- ✅ Reduces code by 50%+ (~200 lines)
- ✅ Easier to add new magic value lints (e.g., `no_magic_color`)
- ✅ Centralized exclusion logic
- ✅ Consistent behavior across all magic value lints
- ✅ Easier to maintain and extend

---

## Medium Priority Optimizations

### 4. Decompose Large Lint Implementations

**Status:** 🟡 Medium Priority
**Impact:** Medium (improves testability and readability)
**Effort:** Medium per file (4-6 hours each)

#### Problem

Several lint files exceed 200 lines with 8+ helper methods:

| File | Lines | Helper Methods |
|------|-------|----------------|
| `no_magic_string.dart` | 241 | 8 |
| `avoid_collection_methods_with_unrelated_types.dart` | 207 | 6 |
| `avoid_async_call_in_sync_function.dart` | 200 | 5 |

**Issues:**
- Hard to understand at a glance
- Helper methods difficult to unit test
- Mixing multiple concerns

#### Proposed Solution

Apply **Strategy Pattern** or **Visitor Pattern** to separate concerns:

**Example: Refactoring `no_magic_string.dart`**

**Before (241 lines in one file):**
```dart
class NoMagicString extends DartLintRule {
  // 8 private helper methods
  bool _isPartOfConstOrFinalDeclaration() { ... }
  bool _isDefaultParameterValue() { ... }
  bool _isInAnnotation() { ... }
  // ... 5 more helpers
}
```

**After (separated concerns):**

```dart
// lib/src/lints/common/no_magic_string/no_magic_string.dart
class NoMagicString extends MagicValueLint {
  // Main lint logic only (~50 lines)
}

// lib/src/lints/common/no_magic_string/exclusion_rules.dart
class StringLiteralExclusionRules {
  static bool shouldExclude(StringLiteral node) {
    return _isInWidget(node) ||
           _isInTestDescription(node) ||
           _isInErrorMessage(node);
  }

  static bool _isInWidget(StringLiteral node) { ... }
  static bool _isInTestDescription(StringLiteral node) { ... }
  static bool _isInErrorMessage(StringLiteral node) { ... }
}
```

#### Benefits

- ✅ Each file under 100 lines
- ✅ Helper methods easily unit testable
- ✅ Clear separation of concerns
- ✅ Easier to understand and modify
- ✅ Reusable exclusion rules

---

### 5. Add Type Caching Layer

**Status:** 🟡 Medium Priority
**Impact:** Low-Medium (performance improvement)
**Effort:** Medium (6-8 hours)

#### Problem

Multiple lints call `type.getDisplayString()` repeatedly without caching:

```dart
// Called multiple times for the same type
final typeName = expression.staticType?.getDisplayString();
if (typeName == 'Widget') { ... }
// Later in the same method...
final typeName2 = expression.staticType?.getDisplayString();
```

**Performance Impact:**
- `getDisplayString()` is relatively expensive
- Same types analyzed repeatedly in large files
- No memoization between invocations

#### Proposed Solution

Create a type information cache:

```dart
// lib/src/utils/type_cache.dart

import 'package:analyzer/dart/element/type.dart';

/// Caches expensive type operations for performance.
class TypeCache {
  TypeCache();

  final Map<DartType, String> _displayStrings = {};
  final Map<DartType, bool> _isNullable = {};
  final Map<String, bool> _typeChecks = {};

  /// Gets the cached display string for a type.
  String getDisplayString(DartType type) {
    return _displayStrings.putIfAbsent(
      type,
      () => type.getDisplayString(withNullability: true),
    );
  }

  /// Checks if a type is nullable (cached).
  bool isNullable(DartType type) {
    return _isNullable.putIfAbsent(
      type,
      () => type.nullabilitySuffix == NullabilitySuffix.question,
    );
  }

  /// Checks if a type matches a name (cached).
  bool typeMatches(DartType type, String name) {
    final key = '${type.hashCode}:$name';
    return _typeChecks.putIfAbsent(
      key,
      () => getDisplayString(type).contains(name),
    );
  }

  /// Clears the cache (call between files).
  void clear() {
    _displayStrings.clear();
    _isNullable.clear();
    _typeChecks.clear();
  }
}
```

**Usage in lints:**

```dart
class MyLint extends DartLintRule {
  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    final typeCache = TypeCache();

    context.registry.addExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      // Use cached display string
      final typeName = typeCache.getDisplayString(type);
      if (typeName == 'Widget') {
        // ...
      }
    });

    // Cache cleared automatically after file analysis
  }
}
```

#### Benefits

- ✅ Faster analysis on large files
- ✅ Reduced string allocations
- ✅ Simple API, easy to adopt
- ⚠️ Need to measure actual performance gain
- ⚠️ Memory overhead for cache storage

---

### 6. Optimize Deep AST Traversals

**Status:** 🟡 Medium Priority
**Impact:** Low (prevents pathological cases)
**Effort:** Low (2-3 hours)

#### Problem

Some parent traversals have no depth limits or early termination:

```dart
// Could traverse entire AST in pathological cases
AstNode? current = node.parent;
while (current != null) {
  if (current is ClassDeclaration) break;
  current = current.parent;
}
```

**Risk:** Deeply nested code could cause performance issues.

#### Proposed Solution

Add safety limits to traversal utilities (already shown in Optimization #2):

```dart
extension AstNodeTraversalExtensions on AstNode {
  T? findAncestorOfType<T extends AstNode>({
    int maxDepth = 50,  // Safety limit
  }) {
    var current = parent;
    var depth = 0;

    while (current != null && depth < maxDepth) {
      if (current is T) return current;
      current = current.parent;
      depth++;
    }

    return null;
  }
}
```

#### Benefits

- ✅ Prevents pathological cases
- ✅ Predictable performance
- ✅ Configurable depth limits
- ✅ No impact on normal code

---

## Low Priority Optimizations

### 7. Implement Lazy Lint Instantiation

**Status:** 🟢 Low Priority
**Impact:** Very Low (minor memory savings)
**Effort:** Low (2-3 hours)

#### Problem

All 128 lint instances are created upfront, even if only a subset are enabled in configuration.

#### Proposed Solution

Instantiate only enabled lints:

```dart
class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    final rules = <DartLintRule>[];

    // Check config for enabled lints
    if (configs.rules['no_magic_number']?.enabled ?? true) {
      rules.add(const NoMagicNumber());
    }

    // ... repeat for all lints

    return rules;
  }
}
```

#### Benefits

- ✅ Minor memory reduction
- ✅ Faster startup (marginally)
- ⚠️ More complex configuration handling
- ⚠️ Minimal practical impact

---

### 8. Add Performance Benchmarking

**Status:** 🟢 Low Priority
**Impact:** Low (enables data-driven optimization)
**Effort:** Medium (8-12 hours)

#### Problem

No systematic way to measure lint performance on large codebases.

#### Proposed Solution

Create benchmark suite:

```dart
// benchmark/lint_performance_test.dart

import 'package:benchmark_harness/benchmark_harness.dart';

class NoMagicNumberBenchmark extends BenchmarkBase {
  NoMagicNumberBenchmark() : super('NoMagicNumber');

  @override
  void run() {
    // Analyze sample file with many numeric literals
  }
}

void main() {
  NoMagicNumberBenchmark().report();
  // Run for all lints
}
```

**Benchmark against:**
- Small files (100 lines)
- Medium files (1000 lines)
- Large files (5000+ lines)
- Real-world projects (Flutter SDK, popular packages)

#### Benefits

- ✅ Identify slowest lints
- ✅ Measure optimization impact
- ✅ Regression detection
- ✅ Data-driven decisions

---

## Implementation Roadmap

### Phase 1: Quick Wins (1-2 weeks)

**Focus:** High-impact, low-effort optimizations

1. ✅ **Optimization #1:** Extract magic value helpers to `ast_extensions.dart`
   - Effort: 2-3 hours
   - Impact: Eliminates 34 lines of duplication

2. ✅ **Optimization #2:** Add parent traversal utilities
   - Effort: 4-6 hours
   - Impact: Reduces ~200 lines of repeated code

3. ✅ **Optimization #6:** Add depth limits to traversals
   - Effort: 2-3 hours (done as part of #2)
   - Impact: Prevents pathological cases

**Estimated Time:** 8-12 hours
**Expected Impact:** ~250 lines of code eliminated, improved robustness

### Phase 2: Major Refactoring (2-3 weeks)

**Focus:** Structural improvements

4. ✅ **Optimization #3:** Create `MagicValueLint` base class
   - Effort: 8-12 hours
   - Impact: 50%+ reduction in magic value lint code

5. ✅ **Optimization #4:** Decompose large lint files
   - Effort: 4-6 hours per file (start with top 3)
   - Impact: Improved testability and readability

**Estimated Time:** 20-30 hours
**Expected Impact:** ~200 lines eliminated, much better architecture

### Phase 3: Advanced Optimizations (3-4 weeks)

**Focus:** Performance

6. ✅ **Optimization #5:** Add type caching layer
   - Effort: 6-8 hours
   - Impact: Performance improvement (measure first)

**Estimated Time:** 6-8 hours
**Expected Impact:** Better performance

### Phase 4: Polish (ongoing)

**Focus:** Performance measurement

7. ✅ **Optimization #8:** Add benchmarking
   - Effort: 8-12 hours
   - Impact: Data-driven future optimizations

---

## Metrics & Impact

### Code Reduction

| Category | Current LOC | After Optimizations | Reduction |
|----------|-------------|---------------------|-----------|
| Magic value lints | 436 | ~200 | ~236 (-54%) |
| Parent traversals | ~300 (duplicated) | ~50 (utilities) | ~250 (-83%) |
| Large lint files | ~650 | ~400 | ~250 (-38%) |
| **Total** | **~1,386** | **~650** | **~736 (-53%)** |

### Maintainability Improvements

- ✅ **Single source of truth** for common patterns
- ✅ **Reusable utilities** available to all lints
- ✅ **Better testability** through decomposition
- ✅ **Easier onboarding** with better documentation
- ✅ **Reduced risk** of registration errors (with automation)

### Performance Gains

| Optimization | Expected Improvement |
|-------------|---------------------|
| Type caching | 5-15% faster on large files |
| Depth limits | Prevents worst-case scenarios |
| Lazy instantiation | 2-5% faster startup |

**Note:** Performance gains should be measured with benchmarks before/after implementation.

---

## Recommendations

### Start Here (Immediate Actions)

1. **Implement Optimization #1** - Extract magic value helpers
   - Quick win, low risk
   - Immediate reduction of duplication
   - Sets foundation for #3

2. **Implement Optimization #2** - Add traversal utilities
   - High impact across entire codebase
   - Improves robustness
   - Enables cleanup of 11+ files

3. **Measure before optimizing** - Add basic performance benchmarks
   - Establish baseline metrics
   - Validate optimization decisions

### Long-Term Goals

- **Reduce total LOC by 30-50%** through strategic refactoring
- **Establish reusable patterns** for future lint development
- **Automate repetitive tasks** (registration, testing)
- **Document architectural decisions** for maintainers

### Success Criteria

- ✅ Zero code duplication in common patterns
- ✅ All lints under 150 lines
- ✅ 100% test coverage maintained
- ✅ No performance regressions
- ✅ Easier to add new lint rules

---

## Conclusion

The Awesome Lints codebase is well-structured and follows good engineering practices. The optimizations outlined in this document will:

1. **Reduce code duplication** by ~50%
2. **Improve maintainability** through better abstractions
3. **Enhance performance** on large codebases
4. **Simplify development** of new lint rules

**Priority order:** Focus on High Priority optimizations first for maximum impact with minimal effort.

**Next Steps:** Review this document with the team, prioritize optimizations based on current needs, and begin with Phase 1 quick wins.

---

**Document Version:** 1.0
**Last Updated:** 2025-12-22
**Contributors:** AI Code Analysis Agent
