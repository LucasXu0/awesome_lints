// This file should trigger the avoid_bottom_type_in_records lint

// expect_lint: avoid_bottom_type_in_records
typedef NullableRecord = ({String str, void hello});

// expect_lint: avoid_bottom_type_in_records
(Null, int) nullable() => (null, 1);

// expect_lint: avoid_bottom_type_in_records
(void hello, Never never) function() => (null, throw Exception());
