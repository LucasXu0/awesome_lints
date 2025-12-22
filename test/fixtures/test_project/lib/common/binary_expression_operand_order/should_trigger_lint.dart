// Test cases that should trigger binary_expression_operand_order lint

void testBinaryOperations() {
  int b = 5;
  String str = 'world';
  bool flag = true;

  // expect_lint: binary_expression_operand_order
  final a = 1 + b;

  // expect_lint: binary_expression_operand_order
  final c = 10 - b;

  // expect_lint: binary_expression_operand_order
  final d = 2 * b;

  // expect_lint: binary_expression_operand_order
  final e = 'hello' + str;

  // expect_lint: binary_expression_operand_order
  final f = true && flag;

  // expect_lint: binary_expression_operand_order
  final g = false || flag;

  // expect_lint: binary_expression_operand_order
  final h = 5 == b;

  // expect_lint: binary_expression_operand_order
  final i = 10 > b;
}
