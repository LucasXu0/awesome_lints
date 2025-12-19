import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEmptyBlock extends DartLintRule {
  const NoEmptyBlock() : super(code: _code);

  static const _code = LintCode(
    name: 'no_empty_block',
    problemMessage: 'Avoid empty blocks as they may indicate missing code.',
    correctionMessage:
        'Add implementation or a TODO comment explaining why the block is empty.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBlock((node) {
      // Check if the block is empty (no statements)
      if (node.statements.isEmpty) {
        // Check if there are any comments in the block
        final hasComments = _hasComments(node);

        // Only report if there are no comments
        if (!hasComments) {
          reporter.atNode(node, _code);
        }
      }
    });
  }

  bool _hasComments(Block block) {
    // Check for comments in the token stream
    final leftBracket = block.leftBracket;
    final rightBracket = block.rightBracket;

    // Check if there are any comments between the braces
    var token = leftBracket.next;
    while (token != null && token != rightBracket) {
      if (token.precedingComments != null) {
        return true;
      }
      token = token.next;
    }

    // Also check the right bracket's preceding comments
    if (rightBracket.precedingComments != null) {
      return true;
    }

    return false;
  }
}
