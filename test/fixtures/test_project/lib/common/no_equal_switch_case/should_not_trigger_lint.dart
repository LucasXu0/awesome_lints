// ignore_for_file: dead_code, unused_local_variable

void allDifferentCases() {
  final str = '1';

  switch (str) {
    case '1':
      print('one');
      break;
    
case '2':
      print('two');
      break;
    
case '3':
      print('three');
      break;
  }
}

void combinedCasesWithSameBody() {
  final str = 'test';

  switch (str) {
    case 'a':
    case 'b':
      print('same');
      break;
    
case 'c':
      print('different');
      break;
  }
}

void emptyCases() {
  final value = 5;

  switch (value) {
    case 1:
    case 2:
    case 3:
      print('combined');
      break;
  }
}

void differentMultipleStatements() {
  final str = 'test';

  switch (str) {
    case 'a':
      print('first');
      print('line');
      break;
    
case 'b':
      print('second');
      print('different');
      break;
    
case 'c':
      print('third');
      print('unique');
      break;
  }
}

void differentReturnValues() {
  final value = 'a';

  switch (value) {
    case 'a':
      return;
    
case 'b':
      print('different');
      return;
    
case 'c':
      break;
  }
}

void defaultCase() {
  final value = 10;

  switch (value) {
    case 1:
      print('one');
      break;
    
case 2:
      print('two');
      break;
    
default:
      print('default');
  }
}

void singleCase() {
  final str = 'test';

  switch (str) {
    case 'a':
      print('only one');
      break;
  }
}

void differentComplexBodies() {
  final value = 10;

  switch (value) {
    case 1:
      if (value > 0) {
        print('positive');
      }
      break;
    
case 2:
      if (value < 0) {
        print('negative');
      }
      break;
    
case 3:
      if (value == 0) {
        print('zero');
      }
      break;
  }
}

void differentMethodCalls() {
  final str = 'test';

  switch (str) {
    case 'a':
      print('hello'.toUpperCase());
      break;
    
case 'b':
      print('world'.toLowerCase());
      break;
    
case 'c':
      print('test'.trim());
      break;
  }
}

void differentVariableNames() {
  final num = 10;

  switch (num) {
    case 1:
      final x = 5;
      print(x);
      break;
    
case 2:
      final y = 5;
      print(y);
      break;
    
case 3:
      final z = 5;
      print(z);
      break;
  }
}
