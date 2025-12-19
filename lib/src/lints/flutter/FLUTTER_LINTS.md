# Flutter Lints

This document lists all Flutter-specific lint rules provided by Awesome Lints.

## Table of Contents

- [avoid-empty-setstate](#avoid-empty-setstate)
- [avoid-late-context](#avoid-late-context)
- [avoid-missing-controller](#avoid-missing-controller)
- [avoid-mounted-in-setstate](#avoid-mounted-in-setstate)
- [avoid-single-child-column-or-row](#avoid-single-child-column-or-row)
- [avoid-stateless-widget-initialized-fields](#avoid-stateless-widget-initialized-fields)
- [avoid-undisposed-instances](#avoid-undisposed-instances)
- [avoid-unnecessary-gesture-detector](#avoid-unnecessary-gesture-detector)
- [avoid-unnecessary-overrides-in-state](#avoid-unnecessary-overrides-in-state)
- [avoid-unnecessary-stateful-widgets](#avoid-unnecessary-stateful-widgets)
- [avoid-wrapping-in-padding](#avoid-wrapping-in-padding)
- [dispose-fields](#dispose-fields)
- [pass-existing-future-to-future-builder](#pass-existing-future-to-future-builder)
- [pass-existing-stream-to-stream-builder](#pass-existing-stream-to-stream-builder)
- [prefer-action-button-tooltip](#prefer-action-button-tooltip)
- [prefer-align-over-container](#prefer-align-over-container)
- [prefer-async-callback](#prefer-async-callback)
- [prefer-center-over-align](#prefer-center-over-align)
- [prefer-compute-over-isolate-run](#prefer-compute-over-isolate-run)
- [prefer-constrained-box-over-container](#prefer-constrained-box-over-container)
- [prefer-container](#prefer-container)
- [prefer-dedicated-media-query-methods](#prefer-dedicated-media-query-methods)
- [prefer-for-loop-in-children](#prefer-for-loop-in-children)
- [prefer-padding-over-container](#prefer-padding-over-container)
- [prefer-single-setstate](#prefer-single-setstate)
- [prefer-sized-box-square](#prefer-sized-box-square)
- [prefer-sliver-prefix](#prefer-sliver-prefix)
- [prefer-spacing](#prefer-spacing)
- [prefer-text-rich](#prefer-text-rich)
- [prefer-void-callback](#prefer-void-callback)
- [prefer-widget-private-members](#prefer-widget-private-members)
- [proper-super-calls](#proper-super-calls)

---

## avoid-empty-setstate

Warns when `setState` is called with an empty callback.

**Why?** Empty `setState` still triggers a re-render but is usually a bug. If you need to update state, add the changes inside the callback. If you just need to rebuild, consider using other approaches.

**Bad:**
```dart
setState(() {});
setState(() => null);
```

**Good:**
```dart
setState(() {
  _counter++;
});
```

---

## avoid-late-context

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

---

## avoid-missing-controller

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

---

## avoid-mounted-in-setstate

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

---

## avoid-single-child-column-or-row

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

---

## avoid-stateless-widget-initialized-fields

Warns when fields in `StatelessWidget` or `State` classes are initialized with non-constant expressions.

**Why?** Fields initialized with non-constant expressions are recalculated on every widget rebuild, which can lead to performance issues and unexpected behavior.

---

## avoid-undisposed-instances

Warns when classes that implement `Disposable` or have a `dispose()` method are not properly disposed.

**Why?** Failing to dispose of resources can lead to memory leaks and resource exhaustion.

---

## avoid-unnecessary-gesture-detector

Warns when `GestureDetector` is used unnecessarily where a simpler widget could be used instead.

**Why?** Using lighter-weight widgets like `InkWell` or `GestureRecognizer` when appropriate improves performance and code clarity.

---

## avoid-unnecessary-overrides-in-state

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

---

## avoid-unnecessary-stateful-widgets

Warns when a `StatefulWidget` doesn't actually use any state.

**Why?** If a widget doesn't use state, it should be a `StatelessWidget` for better performance and clarity.

---

## avoid-wrapping-in-padding

Warns when widgets are unnecessarily wrapped in `Padding` when the child widget has its own padding parameter.

**Why?** Many Flutter widgets have built-in padding parameters that are more efficient than wrapping in a separate `Padding` widget.

---

## dispose-fields

Warns when fields that implement `Disposable` or have a `dispose()` method are not disposed in the widget's `dispose()` method.

**Why?** Proper disposal of resources prevents memory leaks and ensures resources are cleaned up when no longer needed.

---

## pass-existing-future-to-future-builder

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

---

## pass-existing-stream-to-stream-builder

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

---

## prefer-action-button-tooltip

Recommends adding tooltips to action buttons for better accessibility.

**Why?** Tooltips help users understand what an action button does, improving accessibility and user experience.

---

## prefer-align-over-container

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

---

## prefer-async-callback

Recommends using `AsyncCallback` instead of `Future<void> Function()` for consistency with Flutter conventions.

**Why?** Using `AsyncCallback` provides semantic clarity and aligns with Flutter's naming conventions.

---

## prefer-center-over-align

Recommends using `Center` instead of `Align` when centering is the only requirement.

**Why?** `Center` is more explicit and semantically clear than `Align(alignment: Alignment.center)`.

---

## prefer-compute-over-isolate-run

Recommends using Flutter's `compute` function instead of `Isolate.run` for better Flutter integration.

**Why?** The `compute` function is Flutter's recommended way to run computations in a separate isolate, with better error handling and debugging support.

---

## prefer-constrained-box-over-container

Recommends using `ConstrainedBox` instead of `Container` when only constraints are needed.

**Why?** Using `ConstrainedBox` for constraint-only scenarios is more efficient and clearer in intent.

---

## prefer-container

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

---

## prefer-dedicated-media-query-methods

Recommends using specific `MediaQuery` methods instead of accessing the full `MediaQueryData`.

**Why?** Using specific methods like `MediaQuery.sizeOf(context)` is more efficient as it only listens to specific properties rather than all media query changes.

---

## prefer-for-loop-in-children

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

---

## prefer-padding-over-container

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

---

## prefer-single-setstate

Recommends consolidating multiple `setState` calls into a single call.

**Why?** Multiple `setState` calls trigger multiple rebuilds. Combining them into one improves performance.

---

## prefer-sized-box-square

Recommends using `SizedBox.square()` constructor when creating a square `SizedBox`.

**Why?** Using the `square` constructor is more concise and explicit about the intent.

---

## prefer-sliver-prefix

Recommends prefixing sliver widget class names with "Sliver" for consistency.

**Why?** Following Flutter's naming convention makes it clear which widgets are slivers and improves code readability.

---

## prefer-spacing

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

---

## prefer-text-rich

Recommends using `Text.rich()` instead of `RichText` for better consistency with Flutter conventions.

**Why?** `Text.rich()` provides the same functionality as `RichText` while being more consistent with other `Text` constructors.

---

## prefer-void-callback

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

---

## prefer-widget-private-members

Recommends making widget class members private when they're not part of the public API.

**Why?** Keeping widget internals private improves encapsulation and prevents misuse.

---

## proper-super-calls

Ensures that lifecycle methods in `State` classes properly call their super implementation.

**Why?** Forgetting to call super in lifecycle methods can lead to unexpected behavior and bugs.
