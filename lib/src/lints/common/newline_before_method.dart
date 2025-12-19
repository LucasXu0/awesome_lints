import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NewlineBeforeMethod extends DartLintRule {
  const NewlineBeforeMethod() : super(code: _code);

  static const _code = LintCode(
    name: 'newline_before_method',
    problemMessage: 'Missing a blank line before this method declaration.',
    correctionMessage: 'Add a blank line before the method declaration.',
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

      unit.visitChildren(_MethodVisitor(lineInfo, reporter));
    });
  }

  @override
  List<Fix> getFixes() => [_AddBlankLineBeforeMethod()];
}

class _MethodVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final DiagnosticReporter reporter;

  _MethodVisitor(this.lineInfo, this.reporter);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);

    final members = node.members;

    for (var i = 0; i < members.length; i++) {
      final member = members[i];

      // Only check method declarations
      if (member is! MethodDeclaration) continue;

      // If this is the first member, no lint needed
      if (i <= 0) continue;

      // Get the previous member
      final previousMember = members[i - 1];

      final previousMemberEndLine = lineInfo
          .getLocation(previousMember.end)
          .lineNumber;
      final methodStartLine = lineInfo.getLocation(member.offset).lineNumber;

      // If there's no blank line between them (consecutive lines)
      if (methodStartLine - previousMemberEndLine < 2) {
        reporter.atNode(member, NewlineBeforeMethod._code);
      }
    }
  }
}

class _AddBlankLineBeforeMethod extends DartFix {
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

      unit.visitChildren(_MethodFixVisitor(lineInfo, reporter, analysisError));
    });
  }
}

class _MethodFixVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final ChangeReporter reporter;
  final Diagnostic analysisError;

  _MethodFixVisitor(this.lineInfo, this.reporter, this.analysisError);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);

    final members = node.members;

    for (var i = 0; i < members.length; i++) {
      final member = members[i];

      // Only check method declarations
      if (member is! MethodDeclaration) continue;

      // Check if this is the method that triggered the error
      if (!analysisError.sourceRange.intersects(member.sourceRange)) continue;

      // If this is the first member, skip
      if (i <= 0) continue;

      // Get the previous member
      final previousMember = members[i - 1];

      final previousMemberEndLine = lineInfo
          .getLocation(previousMember.end)
          .lineNumber;
      final methodStartLine = lineInfo.getLocation(member.offset).lineNumber;

      // If there's no blank line between them
      if (methodStartLine - previousMemberEndLine < 2) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Add blank line before method',
          priority: 80,
        );

        changeBuilder.addDartFileEdit((builder) {
          // Insert a newline at the position before the method
          builder.addSimpleInsertion(member.offset, '\n');
        });
      }
    }
  }
}
