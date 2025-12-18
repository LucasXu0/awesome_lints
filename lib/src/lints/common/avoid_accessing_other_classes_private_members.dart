import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAccessingOtherClassesPrivateMembers extends DartLintRule {
  const AvoidAccessingOtherClassesPrivateMembers() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_accessing_other_classes_private_members',
    problemMessage: 'Avoid accessing private members of other classes.',
    correctionMessage:
        'Make the member public or provide a public getter/method.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addPropertyAccess((node) {
      _checkPrivateAccess(node, node.propertyName, reporter);
    });

    context.registry.addPrefixedIdentifier((node) {
      _checkPrivateAccess(node, node.identifier, reporter);
    });

    context.registry.addMethodInvocation((node) {
      _checkPrivateAccess(node, node.methodName, reporter);
    });
  }

  void _checkPrivateAccess(
    AstNode node,
    SimpleIdentifier identifier,
    ErrorReporter reporter,
  ) {
    final name = identifier.name;

    // Check if it's a private member (starts with _)
    if (!name.startsWith('_')) return;

    final element = identifier.element;
    if (element == null) return;

    // Get the enclosing class of the member being accessed
    ClassElement2? memberClass;
    if (element is PropertyAccessorElement2) {
      memberClass = element.enclosingElement2 as ClassElement2?;
    } else if (element is FieldElement2) {
      memberClass = element.enclosingElement2 as ClassElement2?;
    } else if (element is MethodElement2) {
      memberClass = element.enclosingElement2 as ClassElement2?;
    }

    if (memberClass == null) return;

    // Get the enclosing class of the code making the access
    ClassElement2? currentClass;
    AstNode? current = node;
    while (current != null) {
      if (current is ClassDeclaration) {
        currentClass = current.declaredFragment?.element;
        break;
      }
      current = current.parent;
    }

    // If accessing from a different class, report it
    if (currentClass != null && currentClass != memberClass) {
      reporter.atNode(
        identifier,
        _code,
      );
    }
  }
}
