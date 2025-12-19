import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class HandleBlocEventSubclasses extends DartLintRule {
  const HandleBlocEventSubclasses() : super(code: _code);

  static const _code = LintCode(
    name: 'handle_bloc_event_subclasses',
    problemMessage:
        'Bloc should handle all event subclasses or the event class itself.',
    correctionMessage:
        'Add handlers for all event subclasses or handle the parent event class.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isBloc(node)) return;

      // Get the event type from Bloc<Event, State>
      final extendsClause = node.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      final typeArguments = superclass.typeArguments?.arguments;
      if (typeArguments == null || typeArguments.isEmpty) return;

      final eventType = typeArguments.first;
      final eventTypeName = eventType.toString();

      // Find all event handlers registered
      final handledEvents = <String>{};
      for (final member in node.members) {
        if (member is ConstructorDeclaration) {
          member.body.visitChildren(_EventHandlerVisitor(handledEvents));
        }
      }

      // Check if the parent event class is handled
      if (handledEvents.contains(eventTypeName)) {
        // Parent class is handled, no need to check subclasses
        return;
      }

      // This is a simplified check - in a real implementation, you would
      // need to find all subclasses of the event type and verify they're all handled
      // For now, we'll just check if there are any handlers at all
      if (handledEvents.isEmpty) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isBloc(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc';
  }
}

class _EventHandlerVisitor extends GeneralizingAstVisitor<void> {
  _EventHandlerVisitor(this.handledEvents);

  final Set<String> handledEvents;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    if (node.methodName.name == 'on') {
      final typeArguments = node.typeArguments?.arguments;
      if (typeArguments != null && typeArguments.isNotEmpty) {
        handledEvents.add(typeArguments.first.toString());
      }
    }
  }
}
