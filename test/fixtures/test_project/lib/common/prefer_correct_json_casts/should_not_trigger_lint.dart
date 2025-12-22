// This file should NOT trigger the prefer_correct_json_casts lint

void parseJsonCorrectly() {
  final json = {'items': {}, 'values': []};

  // Correct: cast to base type first, then use .cast() - GOOD
  final items = (json['items'] as Map).cast<String, int>();

  // Correct: cast to base type first, then use .cast() for List - GOOD
  final values = (json['values'] as List).cast<int>();

  // Direct cast to Map without type arguments is fine
  final mapNoTypes = json['items'] as Map;

  // Direct cast to List without type arguments is fine
  final listNoTypes = json['values'] as List;
}

void handleOtherCasts(dynamic value) {
  // Casting to other types is fine
  final str = value as String;
  final num = value as int;
  final obj = value as Object;

  // Casting to custom types is fine
  final custom = value as MyClass;
}

class MyClass {}
