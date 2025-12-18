// This file should NOT trigger the avoid_bottom_type_in_records lint

import 'dart:async';

// Using Future<void> instead of void
typedef NullableRecord = ({String str, Future<void> hello});

// Using nullable int instead of Null
(int?, int) nullable() => (null, 1);

// Using proper types
(String, int) correct() => ('str', 1);
