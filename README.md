# Awesome Lints

Custom lint rules for Flutter applications using the `custom_lint` package.

## Available Lints

### avoid-late-context

Warns when `context` is accessed in `late` field initializers in `State` classes.

**Why?** Using `context` in late field initializers can result in unexpected behavior. Late fields are initialized lazily (when first accessed), not during object construction, so the context may not be available or valid at initialization time.

**Bad:**
```dart
class _MyWidgetState extends State<MyWidget> {
  late final _theme = Theme.of(context);
  late final _mediaQuery = MediaQuery.of(context);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

**Good:**
```dart
class _MyWidgetState extends State<MyWidget> {
  late final ThemeData _theme;
  late final MediaQueryData _mediaQuery;

  @override
  void initState() {
    super.initState();
    _theme = Theme.of(context);
    _mediaQuery = MediaQuery.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### avoid-mounted-in-setstate

Detects when `mounted` checks occur inside `setState` callbacks. The mounted check should be before the `setState` call, not inside it.

**Why?** Checking `mounted` inside a `setState` callback is too late and can lead to exceptions. The widget may become unmounted between the check and the state update execution.

**Bad:**
```dart
setState(() {
  if (mounted) {
    // Update state
  }
});
```

**Good:**
```dart
if (mounted) {
  setState(() {
    // Update state
  });
}
```

### avoid-missing-controller

Warns when `TextField`, `TextFormField`, or `EditableText` widgets lack adequate mechanisms for tracking user input changes.

**Why?** Without a controller or change callback, widget state fails to update when users modify the field, potentially causing the UI to become out of sync with user input. Text input widgets should include either a `TextEditingController` or an `onChanged`/`onSaved` callback to properly manage input state.

**Bad:**
```dart
TextField();

TextFormField(
  decoration: InputDecoration(labelText: 'Name'),
);
```

**Good:**
```dart
TextField(
  controller: TextEditingController(),
);

TextFormField(
  onChanged: (value) {
    // Handle input change
  },
);

TextFormField(
  onSaved: (value) {
    // Save the value
  },
);
```

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

### avoid-unnecessary-overrides-in-state

Detects unnecessary method overrides in `State` classes that only call super with no additional logic.

**Why?** Overriding methods just to call super adds unnecessary code. Unlike the standard rule, this checks State classes even with `@protected` annotations.

**Bad:**
```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() => super.initState();
}
```

**Good:**
```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### pass-existing-future-to-future-builder

Warns when futures are created inline in `FutureBuilder`'s future parameter instead of being created beforehand.

**Why?** Creating futures inline causes the asynchronous task to restart every time the parent widget rebuilds. The future should be initialized in `initState`, `didUpdateWidget`, or `didChangeDependencies`.

**Bad:**
```dart
class MyWidget extends Widget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getValue(),  // Created during build
      builder: ...,
    );
  }
}
```

**Good:**
```dart
class MyWidget extends Widget {
  final _future = getValue();  // Created beforehand

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: ...,
    );
  }
}
```

### pass-existing-stream-to-stream-builder

Warns when streams are created inline in `StreamBuilder`'s stream parameter instead of being created beforehand.

**Why?** Creating streams inline causes the asynchronous task to restart every time the parent widget rebuilds. The stream should be initialized in `initState`, `didUpdateWidget`, or `didChangeDependencies`.

**Bad:**
```dart
class MyWidget extends Widget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getValue(),  // Created during build
      builder: ...,
    );
  }

  Stream<String> getValue() => Stream.fromIterable(['1', '2', '3']);
}
```

**Good:**
```dart
class MyWidget extends Widget {
  final _stream = getValue();  // Created beforehand

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: ...,
    );
  }

  static Stream<String> getValue() => Stream.fromIterable(['1', '2', '3']);
}
```

### prefer-void-callback

Recommends using the `VoidCallback` typedef instead of `void Function()` for improved code clarity and consistency.

**Why?** Using `VoidCallback` provides semantic clarity and makes code more readable by explicitly conveying intent.

**Bad:**
```dart
void fn(void Function() callback) {
  final void Function()? onPressed = null;
  List<void Function()> callbacks;
}
```

**Good:**
```dart
void fn(VoidCallback callback) {
  final VoidCallback? onPressed = null;
  List<VoidCallback> callbacks;
}
```

### prefer-align-over-container

Recommends using `Align` instead of `Container` when only alignment is needed.

**Why?** Using `Align` for alignment-only scenarios is more efficient and clearer in intent. The `Container` widget is heavyweight and designed for multiple purposes, while `Align` is the appropriate lightweight alternative when only alignment is required.

**Bad:**
```dart
Container(
  alignment: Alignment.topRight,
  child: Text('Hello'),
)
```

**Good:**
```dart
Align(
  alignment: Alignment.topRight,
  child: Text('Hello'),
)

// Container is acceptable when other properties are present
Container(
  alignment: Alignment.topRight,
  transform: Matrix4.skewY(0.3),
  child: Text('Hello'),
)
```

### prefer-container

Suggests using a single `Container` instead of nested widgets when possible.

**Why?** The `Container` widget uses various widgets under the hood (e.g., `Align`, `Padding`, `DecoratedBox`, etc.). When multiple such widgets are nested together, they can often be replaced with a single `Container`, reducing nesting levels and improving code maintainability.

**Bad:**
```dart
Align(
  alignment: Alignment.center,
  child: Padding(
    padding: EdgeInsets.all(8),
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.black),
      child: Text('Hello'),
    ),
  ),
)
```

**Good:**
```dart
Container(
  alignment: Alignment.center,
  padding: EdgeInsets.all(8),
  decoration: BoxDecoration(color: Colors.black),
  child: Text('Hello'),
)
```

**Note:** This lint triggers when 3 or more containerizable widgets are nested (minimum sequence depth).

### prefer-for-loop-in-children

Suggests using for-loop syntax instead of functional methods in widget list arguments.

**Why?** For-loops are generally more straightforward and readable than functional programming patterns like `.map().toList()` or `fold()` when building lists of widgets.

**Bad:**
```dart
Column(
  children: items.map((item) => Text(item)).toList(),
)

Row(
  children: [...items.map((item) => Text(item)).toList()],
)
```

**Good:**
```dart
Column(
  children: [
    for (final item in items) Text(item),
  ],
)

Row(
  children: [
    for (var i = 0; i < items.length; i++) Text(items[i]),
  ],
)
```

### prefer-padding-over-container

Recommends using `Padding` instead of `Container` when only padding or margin is needed.

**Why?** Using `Padding` when you only need padding functionality is clearer and more semantically appropriate than using `Container`. The `Container` widget is a heavyweight component designed for multiple purposes. When only padding is needed, `Padding` is the appropriate lightweight alternative that communicates intent more effectively.

**Bad:**
```dart
Container(
  padding: EdgeInsets.all(8),
  child: Text('Hello'),
);

Container(
  margin: EdgeInsets.all(16),
  child: Text('World'),
);
```

**Good:**
```dart
Padding(
  padding: EdgeInsets.all(8),
  child: Text('Hello'),
);

// Container is acceptable when other properties are present
Container(
  padding: EdgeInsets.all(8),
  color: Colors.blue,
  child: Text('World'),
);
```

### prefer-spacing

Recommends using the `spacing` parameter in `Row`, `Column`, and `Flex` widgets instead of inserting `SizedBox` widgets for spacing.

**Why?** Flutter 3.27+ provides a built-in `spacing` parameter that offers a cleaner, more maintainable way to add gaps between children. Using `SizedBox` for spacing creates unnecessary widget instances and adds visual clutter to the code.

**Bad:**
```dart
Column(
  children: [
    Text('First'),
    SizedBox(height: 10),
    Text('Second'),
    SizedBox(height: 10),
    Text('Third'),
  ],
)

Row(
  children: [
    Icon(Icons.star),
    SizedBox(width: 8),
    Text('Rating'),
  ],
)
```

**Good:**
```dart
Column(
  spacing: 10,
  children: [
    Text('First'),
    Text('Second'),
    Text('Third'),
  ],
)

Row(
  spacing: 8,
  children: [
    Icon(Icons.star),
    Text('Rating'),
  ],
)
```

**Note:** This lint requires Flutter 3.27 or later. The `spacing` parameter is only available in these versions.

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
```

**Note:** All lints are enabled by default. The `custom_lint: rules:` section is optional and only needed if you want to configure specific rule behavior in the future.

3. Run the linter:

```bash
dart run custom_lint
```

## Testing

Run custom_lint to verify all rules:
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
4. Create test fixtures with `// expect_lint` comments:
   - `test/fixtures/test_project/lib/<lint_name>/should_trigger_lint.dart` - Use `// expect_lint: <rule_name>` above lines that should trigger
   - `test/fixtures/test_project/lib/<lint_name>/should_not_trigger_lint.dart` - Valid code that should not trigger

### Project Structure

```
lib/
  src/
    lints/
      <lint_name>.dart              # Lint rule implementation
    awesome_lints_plugin.dart       # Plugin registration
test/
  fixtures/
    test_project/
      lib/
        <lint_name>/
          should_trigger_lint.dart   # Use // expect_lint comments
          should_not_trigger_lint.dart
      analysis_options.yaml
      pubspec.yaml
```
