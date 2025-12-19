import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NewlineBeforeCase extends DartLintRule {
  const NewlineBeforeCase() : super(code: _code);

  static const _code = LintCode(
    name: 'newline_before_case',
    problemMessage: 'Missing a blank line before case clause.',
    correctionMessage: 'Add a blank line before the case clause.',
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

      unit.visitChildren(_SwitchVisitor(lineInfo, reporter));
    });
  }

  @override
  List<Fix> getFixes() => [_AddBlankLineBeforeCase()];
}

class _SwitchVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final DiagnosticReporter reporter;

  _SwitchVisitor(this.lineInfo, this.reporter);

  @override
  void visitSwitchStatement(node) {
    super.visitSwitchStatement(node);

    final members = node.members;

    for (var i = 1; i < members.length; i++) {
      final currentMember = members[i];
      final previousMember = members[i - 1];

      // Check if current member is a case with statements (not just a fallthrough label)
      final hasStatements = currentMember.statements.isNotEmpty;

      // Skip if this is a fallthrough case (no statements, just a label)
      if (!hasStatements) {
        continue;
      }

      // Check if previous member also has statements
      final previousHasStatements = previousMember.statements.isNotEmpty;

      // Only lint if the previous case also had statements
      // (consecutive case labels without statements don't need blank lines)
      if (!previousHasStatements) {
        continue;
      }

      final previousMemberEndLine = lineInfo
          .getLocation(previousMember.end)
          .lineNumber;
      final currentMemberStartLine = lineInfo
          .getLocation(currentMember.offset)
          .lineNumber;

      // If there's no blank line between them (consecutive lines)
      if (currentMemberStartLine - previousMemberEndLine < 2) {
        reporter.atNode(currentMember, NewlineBeforeCase._code);
      }
    }
  }
}

class _AddBlankLineBeforeCase extends DartFix {
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

      unit.visitChildren(_CaseFixVisitor(lineInfo, reporter, analysisError));
    });
  }
}

class _CaseFixVisitor extends RecursiveAstVisitor<void> {
  final LineInfo lineInfo;
  final ChangeReporter reporter;
  final Diagnostic analysisError;

  _CaseFixVisitor(this.lineInfo, this.reporter, this.analysisError);

  @override
  void visitSwitchStatement(node) {
    super.visitSwitchStatement(node);

    final members = node.members;

    for (var i = 1; i < members.length; i++) {
      final currentMember = members[i];
      final previousMember = members[i - 1];

      // Check if this is the case that triggered the error
      if (!analysisError.sourceRange.intersects(currentMember.sourceRange)) {
        continue;
      }

      // Check if current member is a case with statements
      final hasStatements = currentMember.statements.isNotEmpty;
      if (!hasStatements) continue;

      // Check if previous member also has statements
      final previousHasStatements = previousMember.statements.isNotEmpty;
      if (!previousHasStatements) continue;

      final previousMemberEndLine = lineInfo
          .getLocation(previousMember.end)
          .lineNumber;
      final currentMemberStartLine = lineInfo
          .getLocation(currentMember.offset)
          .lineNumber;

      // If there's no blank line between them
      if (currentMemberStartLine - previousMemberEndLine < 2) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Add blank line before case',
          priority: 80,
        );

        changeBuilder.addDartFileEdit((builder) {
          // Insert a newline at the position before the case
          builder.addSimpleInsertion(currentMember.offset, '\n');
        });
      }
    }
  }
}
