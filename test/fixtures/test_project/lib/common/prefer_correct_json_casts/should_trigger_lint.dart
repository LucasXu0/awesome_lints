// This file should trigger the prefer_correct_json_casts lint

void parseJson() {
  final json = {'items': {}, 'values': []};

  // Direct cast to Map with type arguments - BAD
  // expect_lint: prefer_correct_json_casts
  final items = json['items'] as Map<String, int>;

  // Direct cast to List with type arguments - BAD
  // expect_lint: prefer_correct_json_casts
  final values = json['values'] as List<int>;

  // Another example with different types
  // expect_lint: prefer_correct_json_casts
  final data = json['data'] as Map<String, Object?>;

  // List with Object type
  // expect_lint: prefer_correct_json_casts
  final objects = json['objects'] as List<Object>;

  // Nested generics
  // expect_lint: prefer_correct_json_casts
  final nested = json['nested'] as Map<String, List<int>>;
}

void handleJsonResponse(dynamic response) {
  // expect_lint: prefer_correct_json_casts
  final map = response as Map<String, dynamic>;

  // expect_lint: prefer_correct_json_casts
  final list = response as List<String>;
}
