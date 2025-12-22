# Common Dart Lints

This document lists all general Dart lint rules provided by Awesome Lints that apply to any Dart codebase.

## Configuration

As of v2.1.0, these rules are **disabled by default**. To enable:

**All Common Dart rules:**
```yaml
include: package:awesome_lints/presets/common.yaml
```

**Individual rules:**
```yaml
custom_lint:
  enable_all_lint_rules: false
  rules:
    - avoid_non_null_assertion
    - no_equal_then_else
```

**Recommended preset (includes subset of Common rules):**
```yaml
include: package:awesome_lints/presets/recommended.yaml
```

---

## Table of Contents

- [arguments-ordering](#arguments-ordering)
- [avoid-accessing-collections-by-constant-index](#avoid-accessing-collections-by-constant-index)
- [avoid-accessing-other-classes-private-members](#avoid-accessing-other-classes-private-members)
- [avoid-adjacent-strings](#avoid-adjacent-strings)
- [avoid-always-null-parameters](#avoid-always-null-parameters)
- [avoid-assigning-to-static-field](#avoid-assigning-to-static-field)
- [avoid-assignments-as-conditions](#avoid-assignments-as-conditions)
- [avoid-async-call-in-sync-function](#avoid-async-call-in-sync-function)
- [avoid-barrel-files](#avoid-barrel-files)
- [avoid-bitwise-operators-with-booleans](#avoid-bitwise-operators-with-booleans)
- [avoid-bottom-type-in-patterns](#avoid-bottom-type-in-patterns)
- [avoid-bottom-type-in-records](#avoid-bottom-type-in-records)
- [avoid-cascade-after-if-null](#avoid-cascade-after-if-null)
- [avoid-casting-to-extension-type](#avoid-casting-to-extension-type)
- [avoid-collapsible-if](#avoid-collapsible-if)
- [avoid-collection-equality-checks](#avoid-collection-equality-checks)
- [avoid-collection-methods-with-unrelated-types](#avoid-collection-methods-with-unrelated-types)
- [avoid-collection-mutating-methods](#avoid-collection-mutating-methods)
- [avoid-commented-out-code](#avoid-commented-out-code)
- [avoid-complex-arithmetic-expressions](#avoid-complex-arithmetic-expressions)
- [avoid-complex-conditions](#avoid-complex-conditions)
- [avoid-complex-loop-conditions](#avoid-complex-loop-conditions)
- [avoid-conditions-with-boolean-literals](#avoid-conditions-with-boolean-literals)
- [avoid-constant-assert-conditions](#avoid-constant-assert-conditions)
- [avoid-constant-conditions](#avoid-constant-conditions)
- [avoid-constant-switches](#avoid-constant-switches)
- [avoid-continue](#avoid-continue)
- [avoid-contradictory-expressions](#avoid-contradictory-expressions)
- [avoid-declaring-call-method](#avoid-declaring-call-method)
- [avoid-default-tostring](#avoid-default-tostring)
- [avoid-deprecated-usage](#avoid-deprecated-usage)
- [avoid-double-slash-imports](#avoid-double-slash-imports)
- [avoid-duplicate-cascades](#avoid-duplicate-cascades)
- [avoid-duplicate-collection-elements](#avoid-duplicate-collection-elements)
- [avoid-non-null-assertion](#avoid-non-null-assertion)
- [binary-expression-operand-order](#binary-expression-operand-order)
- [dispose-class-fields](#dispose-class-fields)
- [double-literal-format](#double-literal-format)
- [newline-before-case](#newline-before-case)
- [newline-before-constructor](#newline-before-constructor)
- [newline-before-method](#newline-before-method)
- [newline-before-return](#newline-before-return)
- [no-boolean-literal-compare](#no-boolean-literal-compare)
- [no-empty-block](#no-empty-block)
- [no-empty-string](#no-empty-string)
- [no-equal-arguments](#no-equal-arguments)
- [no-equal-conditions](#no-equal-conditions)
- [no-equal-nested-conditions](#no-equal-nested-conditions)
- [no-equal-switch-case](#no-equal-switch-case)
- [no-equal-switch-expression-cases](#no-equal-switch-expression-cases)
- [no-equal-then-else](#no-equal-then-else)
- [no-magic-number](#no-magic-number)
- [no-magic-string](#no-magic-string)
- [no-object-declaration](#no-object-declaration)
- [prefer-async-await](#prefer-async-await)
- [prefer-contains](#prefer-contains)
- [prefer-correct-for-loop-increment](#prefer-correct-for-loop-increment)
- [prefer-correct-json-casts](#prefer-correct-json-casts)
- [prefer-early-return](#prefer-early-return)
- [prefer-first](#prefer-first)
- [prefer-iterable-of](#prefer-iterable-of)
- [prefer-last](#prefer-last)
- [prefer-named-boolean-parameters](#prefer-named-boolean-parameters)
- [prefer-return-await](#prefer-return-await)
- [prefer-switch-expression](#prefer-switch-expression)

---

## arguments-ordering

Warns when named arguments are not in the same order as their parameter declarations.

**Why?** Keeping named arguments in the same order as parameter declarations improves code readability and makes it easier to verify all required parameters are provided.

**Bad:**
```dart
void createUser({
  required String name,
  required int age,
  required String email,
}) {}

// Arguments out of order
createUser(
  email: 'test@example.com',
  name: 'John',
  age: 30,
);
```

**Good:**
```dart
void createUser({
  required String name,
  required int age,
  required String email,
}) {}

// Arguments in declaration order
createUser(
  name: 'John',
  age: 30,
  email: 'test@example.com',
);
```

---

## avoid-accessing-collections-by-constant-index

Warns when collections are accessed using constant indices, especially when accessing the first or last element.

**Why?** Using named accessors like `first` and `last` is more expressive and less error-prone than numeric indices.

---

## avoid-accessing-other-classes-private-members

Warns when private members of other classes are accessed.

**Why?** Accessing private members breaks encapsulation and can lead to brittle code that breaks when the implementation changes.

---

## avoid-adjacent-strings

Warns when string literals are placed adjacent to each other without concatenation.

**Why?** Adjacent strings are concatenated automatically in Dart, which can be confusing and lead to bugs if unintentional.

---

## avoid-always-null-parameters

Warns when function parameters are always passed as `null`.

**Why?** If a parameter is always null, it should be removed or made optional with a null default value.

---

## avoid-assigning-to-static-field

Warns when static fields are assigned new values outside of initialization.

**Why?** Modifying static fields creates shared mutable state that can lead to bugs in multi-threaded or async code.

---

## avoid-assignments-as-conditions

Warns when assignments are used as conditions in if statements or loops.

**Why?** Assignments as conditions are often mistakes (using `=` instead of `==`) and make code harder to understand.

---

## avoid-async-call-in-sync-function

Warns when async functions are called without awaiting in synchronous functions.

**Why?** Calling async functions without awaiting can lead to race conditions and lost error handling.

---

## avoid-barrel-files

Warns when barrel files (files that only export other files) are detected.

**Why?** Barrel files can slow down compilation and make dependency management harder. Direct imports are more explicit.

---

## avoid-bitwise-operators-with-booleans

Warns when bitwise operators (`&`, `|`, `^`) are used with boolean values instead of logical operators.

**Why?** Using `&` or `|` with booleans is likely a mistake. Use `&&` or `||` for logical operations.

---

## avoid-bottom-type-in-patterns

Warns when the bottom type (`Never`) is used in patterns.

**Why?** Using `Never` in patterns is usually a mistake as no value can match the bottom type.

---

## avoid-bottom-type-in-records

Warns when the bottom type (`Never`) is used in record type definitions.

**Why?** Using `Never` in records is usually a mistake and creates unusable record types.

---

## avoid-cascade-after-if-null

Warns when cascade operators are used after null-aware operators.

**Why?** Cascades after `?.` can be confusing as the cascade operates on the result of the entire expression.

---

## avoid-casting-to-extension-type

Warns when values are cast to extension types.

**Why?** Extension types are compile-time constructs. Runtime casting to extension types is likely a mistake.

---

## avoid-collapsible-if

Warns when nested if statements can be combined into a single if with a logical AND.

**Why?** Collapsing nested ifs reduces nesting levels and improves readability.

---

## avoid-collection-equality-checks

Warns when collections are compared using `==` instead of deep equality checks.

**Why?** The `==` operator compares identity for most collections, not contents. Use packages like `collection` for deep equality.

---

## avoid-collection-methods-with-unrelated-types

Warns when collection methods are called with types unrelated to the collection's type parameter.

**Why?** Calling methods like `contains()` with unrelated types is likely a mistake and will always return false.

---

## avoid-collection-mutating-methods

Warns when mutating methods are called on collections that should be immutable.

**Why?** Mutating collections that are intended to be immutable can lead to unexpected behavior.

---

## avoid-commented-out-code

Warns when code appears to be commented out.

**Why?** Commented-out code clutters the codebase. Use version control instead of commenting out code.

---

## avoid-complex-arithmetic-expressions

Warns when arithmetic expressions become too complex.

**Why?** Complex expressions are hard to understand and maintain. Break them into smaller, named intermediate values.

---

## avoid-complex-conditions

Warns when conditional expressions become too complex.

**Why?** Complex conditions are hard to understand and test. Extract them into well-named variables or methods.

---

## avoid-complex-loop-conditions

Warns when loop conditions become too complex.

**Why?** Complex loop conditions make it hard to understand when the loop terminates. Simplify or extract to a method.

---

## avoid-conditions-with-boolean-literals

Warns when boolean conditions explicitly compare with `true` or `false`.

**Why?** Comparing with boolean literals is redundant. Use the boolean value directly.

---

## avoid-constant-assert-conditions

Warns when assert conditions are constant values.

**Why?** Assert conditions should check dynamic values. Constant conditions indicate a logic error.

---

## avoid-constant-conditions

Warns when if/while conditions are constant values that can be evaluated at compile time.

**Why?** Constant conditions indicate dead code or logic errors. The branch is either always or never taken.

---

## avoid-constant-switches

Warns when switch expressions/statements have constant expressions that always match the same case.

**Why?** Constant switch expressions indicate dead code. The same case will always be selected.

---

## avoid-continue

Warns when `continue` is used in loops.

**Why?** Using `continue` can make control flow harder to follow. Consider restructuring the loop logic.

---

## avoid-contradictory-expressions

Warns when expressions contain logical contradictions that make them always true or false.

**Why?** Contradictory expressions indicate logic errors that should be fixed.

---

## avoid-declaring-call-method

Warns when classes declare a `call` method.

**Why?** The `call` method makes objects callable like functions, which can be confusing. Consider using a regular method instead.

---

## avoid-default-tostring

Warns when the default `toString()` implementation is used in string interpolation or concatenation.

**Why?** The default `toString()` returns unhelpful strings like `Instance of 'ClassName'`. Override it for better output.

---

## avoid-deprecated-usage

Warns when deprecated APIs are used.

**Why?** Deprecated APIs may be removed in future versions. Use the recommended alternatives.

---

## avoid-double-slash-imports

Warns when imports use double slashes (`//`) in paths.

**Why?** Double slashes in import paths can cause issues and are usually mistakes.

---

## avoid-duplicate-cascades

Warns when the same cascade operation is repeated.

**Why?** Duplicate cascades are redundant and may indicate a copy-paste error.

---

## avoid-duplicate-collection-elements

Warns when collection literals contain duplicate constant elements.

**Why?** Duplicate elements in sets are redundant. In lists and maps, they may indicate copy-paste errors.

---

## avoid-non-null-assertion

Warns when the non-null assertion operator (`!`) is used on property access and method invocations.

**Why?** The non-null assertion operator checks at runtime and can cause exceptions if the value is null. Using null-aware operators or proper null handling is safer and more explicit.

**Bad:**
```dart
class Test {
  String? field;
  Test? object;

  void method() {
    field!.contains('other');
    object!.field!.contains('other');
    object!.method();
  }
}
```

**Good:**
```dart
class Test {
  String? field;
  Test? object;

  void method() {
    // Use null-aware operators
    field?.contains('other');
    object?.field?.contains('other');
    object?.method();

    // Or proper null checks
    if (field != null) {
      field.contains('other');
    }
  }
}
```

---

## binary-expression-operand-order

Recommends a consistent order for binary expression operands (e.g., putting variables before constants).

**Why?** Consistent operand ordering improves code readability and makes patterns more recognizable.

---

## dispose-class-fields

Warns when class fields that implement `Disposable` or have a `dispose()` method are not disposed.

**Why?** Proper disposal of resources prevents memory leaks and ensures cleanup.

---

## double-literal-format

Enforces consistent formatting for double literals.

**Why?** Consistent number formatting improves code readability.

---

## newline-before-case

Enforces blank lines before case clauses in switch statements.

**Why?** Blank lines before cases improve readability of switch statements with complex case bodies.

---

## newline-before-constructor

Enforces blank lines before constructor declarations.

**Why?** Blank lines before constructors visually separate them from fields and improve code organization.

---

## newline-before-method

Enforces blank lines before method declarations.

**Why?** Blank lines before methods improve code readability by visually separating different methods.

---

## newline-before-return

Enforces blank lines before return statements.

**Why?** Blank lines before returns improve readability by clearly marking function exit points.

---

## no-boolean-literal-compare

Warns when boolean values are explicitly compared to `true` or `false`.

**Why?** Comparing booleans to literals is redundant. Use the boolean value or its negation directly.

---

## no-empty-block

Warns when code blocks are empty.

**Why?** Empty blocks are often mistakes or indicate incomplete implementation. Add a comment if intentional.

---

## no-empty-string

Warns when empty strings are used as default values or compared against.

**Why?** Using empty strings can be error-prone. Consider using null or a more descriptive constant.

---

## no-equal-arguments

Warns when the same expression is passed multiple times to different parameters.

**Why?** Duplicate arguments are often copy-paste errors.

---

## no-equal-conditions

Warns when multiple conditions in if-else chains check the same thing.

**Why?** Equal conditions indicate logic errors - the second condition will never be evaluated.

---

## no-equal-nested-conditions

Warns when nested conditions repeat the same check as outer conditions.

**Why?** Nested equal conditions are redundant - if the outer condition passed, the inner is always true.

---

## no-equal-switch-case

Warns when switch cases have identical code blocks.

**Why?** Duplicate case bodies often indicate copy-paste errors or cases that should be combined.

---

## no-equal-switch-expression-cases

Warns when switch expression cases return the same value.

**Why?** Cases returning the same value should be combined or indicate a logic error.

---

## no-equal-then-else

Warns when if-else branches have identical code.

**Why?** If both branches do the same thing, the condition is pointless. Remove it or fix the logic error.

---

## no-magic-number

Warns when numeric literals appear in code without explanation.

**Why?** Magic numbers make code hard to understand. Use named constants instead.

---

## no-magic-string

Warns when string literals appear repeatedly in code.

**Why?** Magic strings are error-prone and hard to maintain. Use named constants for repeated strings.

---

## no-object-declaration

Warns when variables are declared with type `Object`.

**Why?** Using `Object` as a type provides no type safety. Use more specific types or `dynamic` if truly needed.

---

## prefer-async-await

Warns when `.then()` is used on Future objects instead of async/await syntax.

**Why?** The async/await syntax is more readable, provides better error handling with try/catch, and makes the control flow clearer compared to chaining `.then()` callbacks.

**Bad:**
```dart
Future<String> fetchData() {
  return getData().then((data) {
    return processData(data);
  }).then((processed) {
    return saveData(processed);
  });
}
```

**Good:**
```dart
Future<String> fetchData() async {
  final data = await getData();
  final processed = await processData(data);
  return await saveData(processed);
}
```

---

## prefer-contains

Warns when `indexOf() != -1` or `indexOf() == -1` is used instead of the more expressive `contains()` method.

**Why?** Using `contains()` is more readable and expresses intent more clearly than comparing the result of `indexOf()` with -1.

**Bad:**
```dart
void checkValue(List<int> numbers) {
  if (numbers.indexOf(5) != -1) {
    print('Found');
  }

  if (numbers.indexOf(10) == -1) {
    print('Not found');
  }
}
```

**Good:**
```dart
void checkValue(List<int> numbers) {
  if (numbers.contains(5)) {
    print('Found');
  }

  if (!numbers.contains(10)) {
    print('Not found');
  }
}
```

---

## prefer-correct-for-loop-increment

Warns when a for loop increments or decrements a different variable than the one used in the loop condition.

**Why?** Incrementing the wrong variable in a for loop is a common bug, especially in nested loops. This can cause infinite loops or incorrect iteration behavior.

**Bad:**
```dart
void processMatrix(List<List<int>> matrix) {
  for (int i = 0; i < matrix.length; j++) { // Incrementing j instead of i
    print(matrix[i]);
  }
}

void nestedLoop() {
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 5; i++) { // Incrementing i instead of j
      print('$i, $j');
    }
  }
}
```

**Good:**
```dart
void processMatrix(List<List<int>> matrix) {
  for (int i = 0; i < matrix.length; i++) {
    print(matrix[i]);
  }
}

void nestedLoop() {
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 5; j++) {
      print('$i, $j');
    }
  }
}
```

---

## prefer-correct-json-casts

Warns when direct casting is used with JSON data instead of the safer `.cast()` method.

**Why?** Direct casting of JSON data (e.g., `as Map<String, dynamic>`) can fail at runtime if the JSON structure doesn't match expectations. Using `.cast()` provides better runtime type checking and clearer error messages.

**Bad:**
```dart
void parseJson(dynamic json) {
  final map = json as Map<String, dynamic>;
  final list = json['items'] as List<String>;
}
```

**Good:**
```dart
void parseJson(dynamic json) {
  final map = (json as Map).cast<String, dynamic>();
  final list = (json['items'] as List).cast<String>();
}
```

---

## prefer-early-return

Warns when a function body consists of a single if statement with no else clause.

**Why?** Early returns reduce nesting and improve readability by handling edge cases first. This pattern makes the main logic flow clearer and easier to understand.

**Bad:**
```dart
void processUser(User? user) {
  if (user != null) {
    print('Processing ${user.name}');
    user.save();
    sendNotification(user);
  }
}
```

**Good:**
```dart
void processUser(User? user) {
  if (user == null) return;

  print('Processing ${user.name}');
  user.save();
  sendNotification(user);
}
```

---

## prefer-first

Warns when `[0]` or `elementAt(0)` is used to access the first element of a collection.

**Why?** Using the `.first` property is more expressive and clearly communicates the intent to access the first element.

**Bad:**
```dart
void printFirst(List<String> items) {
  print(items[0]);
  print(items.elementAt(0));
}
```

**Good:**
```dart
void printFirst(List<String> items) {
  print(items.first);
}
```

---

## prefer-iterable-of

Warns when `List.from()` or `Set.from()` is used with a compatible type instead of the type-safe alternative constructors.

**Why?** Using `List.of()` or `Set.of()` provides better type safety and performance when the source iterable's element type is compatible with the target type. The `.of()` constructor preserves type information without unnecessary runtime checks.

**Bad:**
```dart
void convertList(List<int> numbers) {
  final list = List<num>.from(numbers); // Unnecessary conversion
  final set = Set<int>.from(numbers);
}
```

**Good:**
```dart
void convertList(List<int> numbers) {
  final list = List<num>.of(numbers);
  final set = Set<int>.of(numbers);
}
```

---

## prefer-last

Warns when `[length - 1]` or `elementAt(length - 1)` is used to access the last element of a collection.

**Why?** Using the `.last` property is more expressive and clearly communicates the intent to access the last element, while also being less error-prone.

**Bad:**
```dart
void printLast(List<String> items) {
  print(items[items.length - 1]);
  print(items.elementAt(items.length - 1));
}
```

**Good:**
```dart
void printLast(List<String> items) {
  print(items.last);
}
```

---

## prefer-named-boolean-parameters

Warns when boolean parameters are positional instead of named.

**Why?** Boolean parameters are hard to understand at call sites without looking at the function signature. Named parameters make the code self-documenting and prevent errors from argument order confusion.

**Bad:**
```dart
void createUser(String name, bool isAdmin, bool isActive) {
  // implementation
}

// Hard to understand what these booleans mean
createUser('John', true, false);
```

**Good:**
```dart
void createUser(
  String name, {
  required bool isAdmin,
  required bool isActive,
}) {
  // implementation
}

// Clear and self-documenting
createUser('John', isAdmin: true, isActive: false);
```

---

## prefer-return-await

Warns when a Future is returned from a try block without using await.

**Why?** Returning a Future from a try block without await can cause exceptions to escape the catch handler. The exception will occur after the function returns, bypassing your error handling. Always await Futures in try blocks to ensure proper exception handling.

**Bad:**
```dart
Future<String> fetchData() async {
  try {
    return anotherAsyncMethod(); // Exception escapes catch
  } catch (e) {
    print('Error: $e'); // Won't catch exceptions from anotherAsyncMethod
    rethrow;
  }
}
```

**Good:**
```dart
Future<String> fetchData() async {
  try {
    return await anotherAsyncMethod(); // Exceptions caught properly
  } catch (e) {
    print('Error: $e'); // Will catch exceptions
    rethrow;
  }
}
```

---

## prefer-switch-expression

Warns when a switch statement can be converted to a more concise switch expression (Dart 3.0+).

**Why?** Switch expressions are more concise, less verbose, and enforce exhaustiveness checking. They're ideal for assignments and returns where each case produces a value.

**Bad:**
```dart
String getStatusMessage(Status status) {
  String message;
  switch (status) {
    case Status.pending:
      message = 'Waiting';
      break;
    case Status.active:
      message = 'Running';
      break;
    case Status.completed:
      message = 'Done';
      break;
  }
  return message;
}
```

**Good:**
```dart
String getStatusMessage(Status status) {
  return switch (status) {
    Status.pending => 'Waiting',
    Status.active => 'Running',
    Status.completed => 'Done',
  };
}
```
