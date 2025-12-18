// Test cases that should NOT trigger the avoid_collapsible_if lint

// ignore_for_file: dead_code

void test() {
  final bool a = true;
  final bool b = true;
  final bool c = true;

  // Valid: Outer if has else clause
  if (a) {
    if (b) {
      print('both true');
    }
  } else {
    print('a is false');
  }

  // Valid: Inner if has else clause
  if (a) {
    if (b) {
      print('both true');
    } else {
      print('b is false');
    }
  }

  // Valid: Multiple statements in outer if block
  if (a) {
    print('a is true');
    if (b) {
      print('b is also true');
    }
  }

  // Valid: Simple if without nesting
  if (a) {
    print('a is true');
  }

  // Valid: Already merged conditions
  if (a && b) {
    print('both true');
  }

  // Valid: Nested if with statements before inner if
  if (a) {
    final value = 42;
    if (b) {
      print(value);
    }
  }

  // Valid: Nested if with statements after inner if
  if (a) {
    if (b) {
      print('both true');
    }
    print('after inner if');
  }

  // Valid: OR condition (not collapsible the same way)
  if (a || b) {
    print('at least one true');
  }

  // Valid: Three-level nesting where inner has else
  if (a) {
    if (b) {
      if (c) {
        print('all true');
      } else {
        print('c is false');
      }
    } else {
      print('b is false');
    }
  }

  // Valid: Outer if without braces (expression statement)
  if (a) print('single line');

  // Valid: Inner if is else-if chain
  if (a) {
    if (b) {
      print('case 1');
    } else if (c) {
      print('case 2');
    }
  }
}
