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
  static final _codePatterns = [
    RegExp(
        r'^\s*//\s*(void|int|String|double|bool|var|final|const|class|enum|typedef)\s+\w+'),
    RegExp(r'^\s*//\s*\w+\s*\(.*\)\s*[{;]'), // function calls or declarations
    RegExp(
        r'^\s*//\s*(if|for|while|switch|try|return|throw)\s*[\(]'), // control flow
    RegExp(r'^\s*//\s*[\w.]+\s*=\s*[^=]'), // assignments
    RegExp(r'^\s*//\s*}'), // closing braces
    RegExp(r'^\s*//\s*[\w.]+\.\w+\('), // method calls
    RegExp(r'^\s*//\s*@\w+'), // annotations
    RegExp(r'^\s*//\s*import\s+'), // import statements
    RegExp(r'^\s*//\s*export\s+'), // export statements
    RegExp(r'^\s*//\s*\w+\s*:\s*\w+'), // named parameters or map entries
    RegExp(r'^\s*//\s*print\s*\('), // print statements
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
    // Skip documentation comments and special comments
    if (comment.startsWith('///') ||
        comment.startsWith('/**') ||
        comment.contains('TODO:') ||
        comment.contains('FIXME:') ||
        comment.contains('NOTE:') ||
        comment.contains('HACK:') ||
        comment.contains('XXX:')) {
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
