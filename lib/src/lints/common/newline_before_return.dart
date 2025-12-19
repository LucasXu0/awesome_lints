import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NewlineBeforeReturn extends DartLintRule {
  const NewlineBeforeReturn() : super(code: _code);

  static const _code = LintCode(
    name: 'newline_before_return',
    problemMessage: 'Missing a blank line before return statement.',
    correctionMessage: 'Add a blank line before the return statement.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((unit) {
      final lineInfo = unit.lineInfo;

      unit.visitChildren(_ReturnVisitor(lineInfo, reporter));
    });
  }

  @override
  List<Fix> getFixes() => [_AddBlankLineBeforeReturn()];
}

class _ReturnVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final DiagnosticReporter reporter;

  _ReturnVisitor(this.lineInfo, this.reporter);

  @override
  void visitReturnStatement(ReturnStatement node) {
    super.visitReturnStatement(node);

    // Get the block that contains this return statement
    final block = node.thisOrAncestorOfType<Block>();
    if (block == null) return;

    final statements = block.statements;
    final returnIndex = statements.indexOf(node);

    // If this is the first statement in the block, no lint needed
    if (returnIndex <= 0) return;

    // Get the previous statement
    final previousStatement = statements[returnIndex - 1];

    final previousStatementEndLine = lineInfo
        .getLocation(previousStatement.end)
        .lineNumber;
    final returnStartLine = lineInfo.getLocation(node.offset).lineNumber;

    // If there's no blank line between them (consecutive lines)
    if (returnStartLine - previousStatementEndLine < 2) {
      reporter.atNode(node, NewlineBeforeReturn._code);
    }
  }
}

class _AddBlankLineBeforeReturn extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addCompilationUnit((unit) {
      final lineInfo = unit.lineInfo;

      unit.visitChildren(_ReturnFixVisitor(lineInfo, reporter, analysisError));
    });
  }
}

class _ReturnFixVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final ChangeReporter reporter;
  final Diagnostic analysisError;

  _ReturnFixVisitor(this.lineInfo, this.reporter, this.analysisError);

  @override
  void visitReturnStatement(ReturnStatement node) {
    super.visitReturnStatement(node);

    // Check if this is the return statement that triggered the error
    if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

    // Get the block that contains this return statement
    final block = node.thisOrAncestorOfType<Block>();
    if (block == null) return;

    final statements = block.statements;
    final returnIndex = statements.indexOf(node);

    // If this is the first statement, skip
    if (returnIndex <= 0) return;

    // Get the previous statement
    final previousStatement = statements[returnIndex - 1];

    final previousStatementEndLine = lineInfo
        .getLocation(previousStatement.end)
        .lineNumber;
    final returnStartLine = lineInfo.getLocation(node.offset).lineNumber;

    // If there's no blank line between them
    if (returnStartLine - previousStatementEndLine < 2) {
      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add blank line before return',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        // Insert a newline at the position before the return statement
        builder.addSimpleInsertion(node.offset, '\n');
      });
    }
  }
}
