# Bloc Lint Rules

22 lint rules for the Bloc package to help you write better Bloc code and avoid common pitfalls.

## avoid-bloc-public-fields

Warns when a Bloc or Cubit has public fields.

**Why?**

It's recommended to keep the state of your Blocs private and only update it in event handlers. Public fields can lead to uncontrolled state modifications outside the intended event-handling flow, breaking the predictable state management pattern.

**Bad:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  int value = 1;  // Public field - avoid this
}
```

**Good:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  int _value = 1;  // Private field
}
```

## avoid-bloc-public-methods

Warns when a Bloc has public methods except the overridden ones.

**Why?**

When creating a Bloc, it's recommended to avoid exposing any custom public methods and instead notify the bloc of events by calling `add`. This maintains clear separation of concerns—event communication should flow through the `add` method rather than arbitrary public methods.

**Bad:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  void changeSate(int newState) {  // Public method - avoid this
    state = newState;
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}
```

**Good:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  void _changeSate(int newState) {  // Private method
    state = newState;
  }
}
```

## avoid-cubits

Warns when a Cubit is used.

**Why?**

This rule is recommended when you prefer using only Blocs throughout your codebase, need to leverage transformers and bloc concurrency packages, want to avoid exceptions from Cubits entering the main zone, or anticipate code complexity that may eventually require converting Cubits to Blocs.

**Bad:**

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}
```

**Good:**

Use a Bloc implementation instead of a Cubit.

## avoid-duplicate-bloc-event-handlers

Warns when a bloc declares multiple event handlers for the same event.

**Why?**

Adding multiple handlers for the same event type is usually a mistake. It creates confusion about which handler executes and can lead to unexpected behavior.

**Bad:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(_handle);
    on<CounterIncrementEvent>(_handleCorrect);  // Duplicate!
    on<CounterIncrementEvent>(_handleSync);      // Duplicate!
  }
}
```

**Good:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(_handlerWithAllLogic);
    on<CounterDecrementEvent>(_handle);
  }
}
```

## avoid-empty-build-when

Warns when a BlocBuilder or BlocConsumer does not specify the buildWhen condition.

**Why?**

Explicitly defining `buildWhen` parameters helps prevent unnecessary widget rebuilds, which enhances application performance. Without this condition, widgets may rebuild more frequently than needed.

**Bad:**

```dart
BlocBuilder<BlocA, BlocAState>(
  builder: (context, state) {
    // Missing buildWhen parameter
    return Text(state.value);
  },
)
```

**Good:**

```dart
BlocBuilder<BlocA, BlocAState>(
  buildWhen: (previousState, state) {
    return previousState.value != state.value;
  },
  builder: (context, state) {
    return Text(state.value);
  },
)
```

## avoid-existing-instances-in-bloc-provider

Warns when a BlocProvider returns an existing instance instead of creating a new one.

**Why?**

BlocProvider should create fresh instances rather than reusing existing ones to prevent potential state management issues and ensure proper lifecycle management.

**Bad:**

```dart
final existing = MyBloc();

BlocProvider(
  create: () => existing,  // Using existing instance
  child: MyWidget(),
)
```

**Good:**

```dart
BlocProvider(
  create: () => MyBloc(),  // Creating new instance
  child: MyWidget(),
)
```

## avoid-instantiating-in-bloc-value-provider

Warns when a BlocProvider.value returns a new instance instead of reusing an existing one.

**Why?**

Using `BlocProvider.value` with newly instantiated objects defeats the purpose of the `.value` constructor, which is designed to wrap and share already-existing instances.

**Bad:**

```dart
BlocProvider.value(
  value: MyBloc(),  // Creating new instance
  child: MyWidget(),
)
```

**Good:**

```dart
final myBloc = MyBloc();

BlocProvider.value(
  value: myBloc,  // Reusing existing instance
  child: MyWidget(),
)
```

## avoid-passing-bloc-to-bloc

Warns when a Bloc depends on another Bloc.

**Why?**

Blocs should only receive information through events or injected repositories via constructor. If you need a bloc to respond to another bloc, you should push the problem up to the presentation layer or down to the domain layer.

**Bad:**

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc(this.otherBloc) : super(InitialState());

  final OtherBloc otherBloc;  // Bloc depending on another Bloc
}
```

**Good:**

Push dependencies to repositories or handle inter-bloc communication through the presentation layer.

## avoid-passing-build-context-to-blocs

Warns when a Bloc event or a Cubit method accept BuildContext.

**Why?**

Passing BuildContext creates unnecessary coupling between Blocs and widgets and should be avoided. It can also introduce subtle bugs when the context becomes unmounted during asynchronous operations.

**Bad:**

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(BuildContext context) async {  // Avoid BuildContext parameter
    emit(state + 1);
  }
}
```

**Good:**

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() async {
    emit(state + 1);
  }
}
```

## avoid-returning-value-from-cubit-methods

Warns when a Cubit method returns a value.

**Why?**

Cubits should communicate state changes through emitted states rather than returning values directly. This maintains clarity about the reactive flow and ensures predictable state management patterns.

**Bad:**

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  String getAsString() => state.toString();  // Returning value
}
```

**Good:**

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // Listen to Cubit state changes instead
}
```

## check-is-not-closed-after-async-gap

Warns when an async handler does not have isClosed check before dispatching an event after an async gap.

**Why?**

When async operations complete in Bloc handlers, the Bloc may have been closed by the time execution resumes. Dispatching events to a closed Bloc can cause runtime errors.

**Bad:**

```dart
on<CounterDecrementEvent>((event, emit) async {
  emit(state + 1);
  await Future.delayed(const Duration(seconds: 3));
  add(CounterDecrementEvent());  // Missing isClosed check
});
```

**Good:**

```dart
on<CounterDecrementEvent>((event, emit) async {
  emit(state + 1);
  await Future.delayed(const Duration(seconds: 3));
  if (!isClosed) {
    add(CounterDecrementEvent());
  }
});
```

## emit-new-bloc-state-instances

Warns when an emit invocation receives the existing state instead of a newly created instance.

**Why?**

Passing existing state objects can create issues when the state is not properly updating. State management frameworks rely on object identity changes to detect updates.

**Bad:**

```dart
on<CounterDecrementEvent>((event, emit) async {
  emit(state);  // Reusing existing state instance
});
```

**Good:**

```dart
on<CounterDecrementEvent>((event, emit) async {
  emit(state + 1);              // Creates new value
  emit(state.copyWith(...));    // Creates new instance
});
```

## handle-bloc-event-subclasses

Warns when a bloc does not handle all event subclasses.

**Why?**

Blocs are expected to handle all event subclasses or the event class itself. This prevents situations where certain event types are silently ignored.

**Bad:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(_handle);
    // Missing: on<CounterDecrementEvent>
  }
}
```

**Good:**

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(_handle);
    on<CounterDecrementEvent>(_handle);  // All subclasses handled
  }
}
```

## prefer-bloc-event-suffix

Warns when a Bloc event class name does not match the configured pattern.

**Why?**

Enforcing a standardized naming convention (default: ending with "Event") for Bloc event classes improves code readability and makes it immediately clear which classes represent Bloc events.

**Bad:**

```dart
class SomeClass {}

class CounterBloc extends Bloc<SomeClass, int> {  // Event class doesn't end with 'Event'
  CounterBloc() : super(0);
}
```

**Good:**

```dart
class SomeEvent {}

class CounterBloc extends Bloc<SomeEvent, int> {
  CounterBloc() : super(0);
}
```

## prefer-bloc-extensions

Suggests using context.read() or context.watch() instead of BlocProvider.of(context).

**Why?**

Using context extensions produces more concise code, promotes consistency, and reduces the likelihood of forgetting `listen: false` when read behavior is expected.

**Bad:**

```dart
final value = BlocProvider.of<String>(context);
final bloc = BlocProvider.of<MyBloc>(context, listen: false);
```

**Good:**

```dart
final value = context.watch<String>();
final bloc = context.read<MyBloc>();
```

## prefer-bloc-state-suffix

Warns when a Bloc state class name does not match the configured pattern.

**Why?**

Requiring state classes to follow a predictable naming convention (typically ending with "State") helps developers quickly identify state classes and understand code intent.

**Bad:**

```dart
class SomeClass {}

class CounterBloc extends Bloc<CounterEvent, SomeClass> {  // State class doesn't end with 'State'
  CounterBloc() : super(SomeClass());
}
```

**Good:**

```dart
class SomeState {}

class CounterBloc extends Bloc<CounterEvent, SomeState> {
  CounterBloc() : super(SomeState());
}
```

## prefer-correct-bloc-provider

Warns when a Bloc is provided not with a BlocProvider.

**Why?**

If you use both `bloc` and `provider` packages, it becomes easy to accidentally use the wrong Provider for your Blocs. This rule ensures proper architectural patterns.

**Bad:**

```dart
Provider<BlocA>(
  create: (context) => BlocA(),  // Using Provider instead of BlocProvider
  child: MyWidget(),
)
```

**Good:**

```dart
BlocProvider<BlocA>(
  create: (context) => BlocA(),
  child: MyWidget(),
)
```

## prefer-immutable-bloc-events

Warns when a Bloc event does not have the @immutable annotation.

**Why?**

Immutable bloc events ensure predictable state management and prevent unintended mutations that could cause subtle bugs.

**Bad:**

```dart
sealed class CounterEvent {}

class CounterIncrement extends CounterEvent {}  // Missing @immutable
```

**Good:**

```dart
@immutable
sealed class CounterEvent {}

@immutable
class CounterIncrement extends CounterEvent {}
```

## prefer-immutable-bloc-state

Warns when a Bloc state does not have the @immutable annotation.

**Why?**

Having immutable state objects helps ensure you always pass a newly created object to `emit` invocations and avoid any issues with the state not being updated.

**Bad:**

```dart
sealed class CounterState {}

class CounterIncrement extends CounterState {}  // Missing @immutable
```

**Good:**

```dart
@immutable
sealed class CounterState {}

@immutable
class CounterIncrement extends CounterState {}
```

## prefer-multi-bloc-provider

Warns when a BlocProvider / BlocListener / RepositoryProvider can be replaced with a Multi version.

**Why?**

Replacing nested providers with multi-provider versions improves readability and reduces widget tree nesting level.

**Bad:**

```dart
BlocProvider<BlocA>(
  create: (context) => BlocA(),
  child: BlocProvider<BlocB>(
    create: (context) => BlocB(),
    child: BlocProvider<BlocC>(
      create: (context) => BlocC(),
      child: MyWidget(),
    ),
  ),
)
```

**Good:**

```dart
MultiBlocProvider(
  providers: [
    BlocProvider<BlocA>(create: (context) => BlocA()),
    BlocProvider<BlocB>(create: (context) => BlocB()),
    BlocProvider<BlocC>(create: (context) => BlocC()),
  ],
  child: MyWidget(),
)
```

## prefer-sealed-bloc-events

Warns when Bloc events do not have a sealed or final modifier.

**Why?**

Using sealed or final modifiers on Bloc event classes improves type safety and prevents unintended subclassing, creating a controlled event hierarchy.

**Bad:**

```dart
abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}  // Missing sealed/final
```

**Good:**

```dart
sealed class CounterEvent {}

final class CounterIncrementEvent extends CounterEvent {}
```

## prefer-sealed-bloc-state

Warns when Bloc state classes do not have a sealed or final modifier.

**Why?**

Using sealed or final modifiers prevents unintended subclassing and ensures that only explicitly defined state variants can exist, protecting the state hierarchy.

**Bad:**

```dart
abstract class CounterState {}

class CounterIncrementState extends CounterState {}  // Missing sealed/final
```

**Good:**

```dart
sealed class CounterState {}

final class CounterIncrementState extends CounterState {}
```

---

## Summary

These 22 Bloc-specific lint rules help you:
- Enforce proper encapsulation and architectural patterns
- Prevent common Bloc usage mistakes
- Write more maintainable and readable code
- Follow Bloc best practices
- Catch correctness issues at compile time
- Improve performance through proper widget rebuilding

All rules are enabled by default and can be configured in your `analysis_options.yaml` file.
