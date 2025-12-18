import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NewlineBeforeConstructor extends DartLintRule {
  const NewlineBeforeConstructor() : super(code: _code);

  static const _code = LintCode(
    name: 'newline_before_constructor',
    problemMessage: 'Missing a blank line before this constructor declaration.',
    correctionMessage: 'Add a blank line before the constructor declaration.',
    errorSeverity: analyzer_error.ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((unit) {
      final lineInfo = unit.lineInfo;

      unit.visitChildren(_ConstructorVisitor(lineInfo, reporter));
    });
  }

  @override
  List<Fix> getFixes() => [_AddBlankLineBeforeConstructor()];
}

class _ConstructorVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final ErrorReporter reporter;

  _ConstructorVisitor(this.lineInfo, this.reporter);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);

    final members = node.members;

    for (var i = 0; i < members.length; i++) {
      final member = members[i];

      // Only check constructor declarations
      if (member is! ConstructorDeclaration) continue;

      // If this is the first member, no lint needed
      if (i <= 0) continue;

      // Get the previous member
      final previousMember = members[i - 1];

      final previousMemberEndLine =
          lineInfo.getLocation(previousMember.end).lineNumber;
      final constructorStartLine =
          lineInfo.getLocation(member.offset).lineNumber;

      // If there's no blank line between them (consecutive lines)
      if (constructorStartLine - previousMemberEndLine < 2) {
        reporter.atNode(
          member,
          NewlineBeforeConstructor._code,
        );
      }
    }
  }
}

class _AddBlankLineBeforeConstructor extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    analyzer_error.AnalysisError analysisError,
    List<analyzer_error.AnalysisError> others,
  ) {
    context.registry.addCompilationUnit((unit) {
      final lineInfo = unit.lineInfo;

      unit.visitChildren(_ConstructorFixVisitor(
        lineInfo,
        reporter,
        analysisError,
      ));
    });
  }
}

class _ConstructorFixVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final ChangeReporter reporter;
  final analyzer_error.AnalysisError analysisError;

  _ConstructorFixVisitor(this.lineInfo, this.reporter, this.analysisError);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);

    final members = node.members;

    for (var i = 0; i < members.length; i++) {
      final member = members[i];

      // Only check constructor declarations
      if (member is! ConstructorDeclaration) continue;

      // Check if this is the constructor that triggered the error
      if (!analysisError.sourceRange.intersects(member.sourceRange)) continue;

      // If this is the first member, skip
      if (i <= 0) continue;

      // Get the previous member
      final previousMember = members[i - 1];

      final previousMemberEndLine =
          lineInfo.getLocation(previousMember.end).lineNumber;
      final constructorStartLine =
          lineInfo.getLocation(member.offset).lineNumber;

      // If there's no blank line between them
      if (constructorStartLine - previousMemberEndLine < 2) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Add blank line before constructor',
          priority: 80,
        );

        changeBuilder.addDartFileEdit((builder) {
          // Insert a newline at the position before the constructor
          builder.addSimpleInsertion(member.offset, '\n');
        });
      }
    }
  }
}
