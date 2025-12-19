# Provider Lint Rules

8 lint rules for the Provider package to help you write better Provider code and avoid common pitfalls.

## avoid-instantiating-in-value-provider

Warns when a `Provider.value` returns a new instance instead of reusing an existing one.

**Tags:** #correctness

**Why?**

Creating fresh instances in value providers defeats the pattern's intent. Value providers should encapsulate pre-existing objects, enabling proper sharing and avoiding unnecessary object creation that can impact performance and memory usage.

**Bad:**

```dart
Provider.value(
  value: MyService(),  // Creates new instance
  child: MyWidget(),
);
```

**Good:**

```dart
final myService = MyService();

Provider.value(
  value: myService,  // Reuses existing instance
  child: MyWidget(),
);
```

## avoid-read-inside-build

Warns when a `read` method is used inside the `build` method.

**Tags:** #correctness

**Why?**

`read` is designed to read the value one time. When used inside the `build` method, it can lead to missing events when the provided value changes, preventing your widget from rebuilding properly.

**Bad:**

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.read<int>();  // Won't rebuild when value changes
    return Text('$value');
  }
}
```

**Good:**

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.watch<int>();  // Rebuilds when value changes
    return Text('$value');
  }
}
```

## avoid-watch-outside-build

Warns when `watch` or `select` methods are used outside of the `build` method.

**Tags:** #correctness

**Why?**

`watch` is designed to subscribe to changes, which is not needed when the value is read outside of the `build` method. This creates unnecessary subscriptions. Use `read` instead for one-time value access.

**Bad:**

```dart
void onButtonPressed(BuildContext context) {
  final value = context.watch<String>();  // Creates unnecessary subscription
  print(value);
}
```

**Good:**

```dart
void onButtonPressed(BuildContext context) {
  final value = context.read<String>();  // One-time access
  print(value);
}
```

## dispose-providers

Warns when a provided class with a `dispose`, `close`, or `cancel` method does not have this method called in the Provider `dispose` callback.

**Tags:** #memory-leak #correctness

**Why?**

Proper resource cleanup prevents memory leaks in Flutter applications. When providers manage stateful services, forgetting to dispose them can accumulate resources and degrade app performance over time.

**Bad:**

```dart
Provider(
  create: () => MyService(),  // MyService has a dispose() method
  child: MyWidget(),
);

class MyService {
  void dispose() {
    // cleanup
  }
}
```

**Good:**

```dart
Provider(
  create: () => MyService(),
  dispose: (value) => value.dispose(),  // Properly disposes the service
  child: MyWidget(),
);

class MyService {
  void dispose() {
    // cleanup
  }
}
```

## prefer-immutable-selector-value

Warns when a `Selector` returns a mutable value.

**Tags:** #correctness

**Why?**

Returning a mutable value can lead to skipped or incorrect rebuilds. The Selector widget relies on value equality to determine when to rebuild, and mutable objects can break this optimization logic.

**Bad:**

```dart
Selector<MyModel, MyData>(
  selector: (context, model) => MyData(model.value),  // Mutable class
  builder: (context, data, child) => Text(data.toString()),
);

class MyData {
  final int value;
  MyData(this.value);
}
```

**Good:**

```dart
@immutable
class MyData {
  final int value;
  const MyData(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyData && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

Selector<MyModel, MyData>(
  selector: (context, model) => MyData(model.value),
  builder: (context, data, child) => Text(data.toString()),
);
```

## prefer-multi-provider

Warns when multiple nested Providers can be replaced with `MultiProvider` instead.

**Tags:** #readability #maintainability

**Why?**

Nested providers create deeper widget hierarchies, making code harder to read and maintain. Using `MultiProvider` flattens this structure, providing clearer organization of multiple provider declarations.

**Bad:**

```dart
Provider<ServiceA>(
  create: () => ServiceA(),
  child: Provider<ServiceB>(
    create: () => ServiceB(),
    child: Provider<ServiceC>(
      create: () => ServiceC(),
      child: MyWidget(),
    ),
  ),
);
```

**Good:**

```dart
MultiProvider(
  providers: [
    Provider<ServiceA>(create: () => ServiceA()),
    Provider<ServiceB>(create: () => ServiceB()),
    Provider<ServiceC>(create: () => ServiceC()),
  ],
  child: MyWidget(),
);
```

## prefer-nullable-provider-types

Warns when a specified type of `context.watch`, `context.read`, or `Provider.of` is non-nullable.

**Tags:** #maintainability #types

**Why?**

Making provider types nullable ensures developers explicitly handle scenarios where a provided value might not be available, reducing runtime errors and improving code robustness. This is especially important when dealing with conditionally provided values.

**Bad:**

```dart
final value = context.watch<String>();  // Assumes value always exists
final anotherValue = context.read<int>();
Provider.of<MyService>(context);
```

**Good:**

```dart
final value = context.watch<String?>();  // Can handle missing values
final anotherValue = context.read<int?>();
Provider.of<MyService?>(context);
```

## prefer-provider-extensions

Warns when using `Provider.of()` instead of `context.read()` or `context.watch()`.

**Tags:** #readability #maintainability

**Why?**

Using context extensions is shorter, helps keep the codebase consistent, and makes it less likely to forget `listen: false` when `read` behavior is expected. The extension methods are more explicit about their intent.

**Bad:**

```dart
final value = Provider.of<String>(context);
final service = Provider.of<MyService>(context, listen: false);
```

**Good:**

```dart
final value = context.watch<String>();
final service = context.read<MyService>();
```

---

## Summary

These 8 Provider-specific lint rules help you:
- Avoid common Provider usage mistakes
- Prevent memory leaks from undisposed resources
- Write more maintainable and readable code
- Follow Provider best practices
- Catch correctness issues at compile time

All rules are enabled by default and can be configured in your `analysis_options.yaml` file.
