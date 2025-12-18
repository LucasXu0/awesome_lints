// ignore_for_file: dead_code, unused_local_variable, unused_field

class Test {
  // Field with specific type
  int data = 1;

  // Field with String type
  String _value = 'string';

  // Field with Map type
  Map<String, dynamic> complexData = {'key': 'value'};

  // Field with dynamic type (not Object)
  dynamic dynamicData = 'anything';

  // Getter with specific return type
  int get getter => 1;

  // Getter with String return type
  String get dataGetter => _value;

  // Method with specific return type
  String doWork() {
    return 'result';
  }

  // Method with int return type and parameters
  int process(String input) {
    return input.length;
  }

  // Method with void return type
  void compute() {
    print(data);
  }

  // Method with specific return type and complex logic
  num calculate() {
    return data * 2;
    
return 0;
  }

  // Setter with specific parameter type (setters don't have return types to check)
  set value(String newValue) {
    _value = newValue;
  }
}

class Repository {
  // Field with specific type
  Map<String, dynamic> cache = {};

  // Getter with specific return type
  Map<String, dynamic> get data => cache;

  // Method with specific return type
  dynamic fetch(String id) {
    return cache[id];
  }

  // Method with nullable return type
  String? findById(String id) {
    final result = cache[id];
    
return result as String?;
  }
}

class GenericContainer<T> {
  // Generic field
  T? item;

  // Generic method return type
  T? getItem() {
    return item;
  }

  // Specific types for different items
  int item1 = 1;
  String item2 = 'string';
  List<int> item3 = [1, 2, 3];

  // Method with specific return type
  List<dynamic> getAllItems() {
    return [item1, item2, item3];
  }
}

class TypedContainer {
  // Using dynamic instead of Object
  dynamic value1 = 1;
  dynamic value2 = 'string';

  // Using specific types
  num numericValue = 42;
  String stringValue = 'text';
  List<dynamic> listValue = [1, 2, 3];

  // Methods with specific return types
  dynamic getDynamic() => value1;
  
num getNumeric() => numericValue;
  
String getString() => stringValue;
}
