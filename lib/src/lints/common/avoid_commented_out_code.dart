import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCommentedOutCode extends DartLintRule {
  const AvoidCommentedOutCode() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_commented_out_code',
    problemMessage: 'Avoid commented out code.',
    correctionMessage:
        'Remove commented out code. Use version control to track code history instead.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  // Patterns that indicate code rather than regular comments
  // Made more conservative to avoid false positives
  static final _codePatterns = [
    // Variable declarations with assignment
    RegExp(
        r'^\s*//\s*(void|int|String|double|bool|var|final|const)\s+\w+\s*='),
    // Class/enum/typedef declarations
    RegExp(r'^\s*//\s*(class|enum|typedef|extension)\s+\w+\s*[{<]'),
    // Function declarations with body
    RegExp(r'^\s*//\s*\w+\s*\([^)]*\)\s*\{'),
    // Control flow statements
    RegExp(r'^\s*//\s*(if|for|while|switch|try)\s*\('),
    // Return/throw statements
    RegExp(r'^\s*//\s*(return|throw)\s+'),
    // Assignments (must have = and value)
    RegExp(r'^\s*//\s*[\w.]+\s*=\s*\w+'),
    // Method calls with semicolon
    RegExp(r'^\s*//\s*[\w.]+\.\w+\([^)]*\);'),
    // Import/export statements
    RegExp(r'^\s*//\s*(import|export)\s+[' "'" r'"]'),
    // Annotations
    RegExp(r'^\s*//\s*@\w+\('),
    // Closing braces (only standalone)
    RegExp(r'^\s*//\s*}\s*$'),
  ];

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((node) {
      final lineInfo = node.lineInfo;
      _processTokens(node.beginToken, lineInfo, reporter);
    });
  }

  void _processTokens(Token token, LineInfo lineInfo, ErrorReporter reporter) {
    Token? currentToken = token;

    while (currentToken != null) {
      // Check all comments (both documentation and regular comments)
      _processCommentToken(currentToken.precedingComments, lineInfo, reporter);

      if (currentToken.isEof) {
        break;
      }

      currentToken = currentToken.next;
    }
  }

  void _processCommentToken(
      Token? commentToken, LineInfo lineInfo, ErrorReporter reporter) {
    Token? current = commentToken;

    while (current != null) {
      final commentText = current.lexeme;

      // Check if this looks like commented out code
      if (_looksLikeCode(commentText)) {
        reporter.atOffset(
          offset: current.offset,
          length: current.length,
          errorCode: _code,
        );
      }

      current = current.next;
    }
  }

  bool _looksLikeCode(String comment) {
    // Skip documentation comments
    if (comment.startsWith('///') || comment.startsWith('/**')) {
      return false;
    }

    // Skip special marker comments
    if (comment.contains('TODO:') ||
        comment.contains('FIXME:') ||
        comment.contains('NOTE:') ||
        comment.contains('HACK:') ||
        comment.contains('XXX:')) {
      return false;
    }

    // Skip linter directive comments
    if (comment.contains('ignore:') ||
        comment.contains('ignore_for_file:') ||
        comment.contains('expect_lint:') ||
        comment.contains('coverage:') ||
        comment.contains('flutter:') ||
        comment.contains('dart format') ||
        comment.contains('analyzer:') ||
        comment.contains('lint:') ||
        comment.contains('pragma:')) {
      return false;
    }

    // Skip explanatory comments (start with common words followed by colon)
    if (RegExp(r'^\s*//\s*(Valid|Invalid|Test|Example|Note|Warning|Error|Info|'
            r'Good|Bad|Correct|Incorrect|Expected|Actual|Input|Output|Result|'
            r'Before|After|Step|Case|Scenario|Given|When|Then):')
        .hasMatch(comment)) {
      return false;
    }

    // Skip comments that are clearly sentences (start with capital letter and contain common words)
    final commentText = comment.replaceFirst(RegExp(r'^\s*//\s*'), '');
    if (commentText.isNotEmpty &&
        commentText[0] == commentText[0].toUpperCase() &&
        (commentText.contains(' is ') ||
            commentText.contains(' are ') ||
            commentText.contains(' the ') ||
            commentText.contains(' to ') ||
            commentText.contains(' a ') ||
            commentText.contains(' an ') ||
            commentText.contains(' with ') ||
            commentText.contains(' for ') ||
            commentText.contains(' that ') ||
            commentText.contains(' this '))) {
      return false;
    }

    // Check against code patterns
    for (final pattern in _codePatterns) {
      if (pattern.hasMatch(comment)) {
        return true;
      }
    }

    return false;
  }
}
