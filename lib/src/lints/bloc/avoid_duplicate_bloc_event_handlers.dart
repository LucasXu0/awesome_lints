import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDuplicateBlocEventHandlers extends DartLintRule {
  const AvoidDuplicateBlocEventHandlers() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_duplicate_bloc_event_handlers',
    problemMessage:
        'Avoid declaring multiple event handlers for the same event type.',
    correctionMessage:
        'Remove duplicate event handlers and consolidate logic into a single handler.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isBlocOrCubit(node)) return;

      // Find all event handler registrations
      final eventHandlers = <String, List<MethodInvocation>>{};

      for (final member in node.members) {
        if (member is ConstructorDeclaration) {
          member.body.visitChildren(_EventHandlerVisitor(eventHandlers));
        }
      }

      // Report duplicates
      for (final entry in eventHandlers.entries) {
        if (entry.value.length > 1) {
          // Report all duplicates except the first one
          for (var i = 1; i < entry.value.length; i++) {
            reporter.atNode(entry.value[i], _code);
          }
        }
      }
    });
  }

  bool _isBlocOrCubit(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc' || superclassName == 'Cubit';
  }
}

class _EventHandlerVisitor extends GeneralizingAstVisitor<void> {
  _EventHandlerVisitor(this.eventHandlers);

  final Map<String, List<MethodInvocation>> eventHandlers;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    // Check if it's an 'on' method call
    if (node.methodName.name == 'on') {
      // Get the type argument (event type)
      final typeArguments = node.typeArguments?.arguments;
      if (typeArguments != null && typeArguments.isNotEmpty) {
        final eventType = typeArguments.first.toString();
        eventHandlers.putIfAbsent(eventType, () => []).add(node);
      }
    }
  }
}
