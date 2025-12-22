// Test cases that should NOT trigger binary_expression_operand_order lint

void testCorrectOperandOrder() {
  int b = 5;
  String str = 'world';
  bool flag = true;

  // Correct: variable on the left, literal on the right
  final a = b + 1;
  final c = b - 10;
  final d = b * 2;
  final e = str + 'hello';
  final f = flag && true;
  final g = flag || false;
  final h = b == 5;
  final i = b > 10;

  // Both operands are variables
  final j = b + b;
  final k = str + str;

  // Both operands are literals (acceptable)
  final l = 1 + 2;
  final m = 'hello' + 'world';
}
