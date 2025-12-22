void basicDuplicateCase() {
  final str = '1';

  switch (str) {
    case '1':
      print('hello world');
      break;

    case '2':
      print('same');
      break;

    case '3':
      print('same');
      break;
  }
}

void multipleDuplicateCases() {
  final value = 5;

  switch (value) {
    case 1:
      print('one');
      break;

    case 2:
      print('duplicate');
      break;

    case 3:
      print('duplicate');
      break;

    case 4:
      print('duplicate');
      break;
  }
}

void duplicateMultipleStatements() {
  final str = 'test';

  switch (str) {
    case 'a':
      print('first');
      print('line');
      break;

    case 'b':
      print('second');
      break;

    case 'c':
      print('first');
      print('line');
      break;
  }
}

void duplicateWithVariable() {
  final num = 10;

  switch (num) {
    case 1:
      final x = 5;
      print(x);
      break;

    case 2:
      final y = 10;
      print(y);
      break;

    case 3:
      final x = 5;
      print(x);
      break;
  }
}

void duplicateReturnStatement() {
  final value = 'a';

  switch (value) {
    case 'a':
      return;

    case 'b':
      print('different');
      break;

    case 'c':
      return;
  }
}

void duplicateMethodCall() {
  final str = 'test';

  switch (str) {
    case 'a':
      print('hello'.toUpperCase());
      break;

    case 'b':
      print('different');
      break;

    case 'c':
      print('hello'.toUpperCase());
      break;
  }
}

void duplicateWithContinue() {
  final value = 1;

  myLoop:
  for (var i = 0; i < 5; i++) {
    switch (value) {
      case 1:
        continue myLoop;

      case 2:
        print('different');
        break;

      case 3:
        continue myLoop;
    }
  }
}

void duplicateComplexBody() {
  final value = 10;

  switch (value) {
    case 1:
      if (value > 0) {
        print('positive');
      }
      break;

    case 2:
      print('two');
      break;

    case 3:
      if (value > 0) {
        print('positive');
      }
      break;
  }
}

void duplicateEmptyPrint() {
  final str = 'x';

  switch (str) {
    case 'a':
      print('A');
      break;

    case 'b':
      print('not empty');
      break;

    case 'c':
      print('A');
      break;
  }
}

void duplicateThrow() {
  final value = 5;

  switch (value) {
    case 1:
      throw Exception('error');

    case 2:
      print('ok');
      break;

    case 3:
      throw Exception('error');
  }
}
