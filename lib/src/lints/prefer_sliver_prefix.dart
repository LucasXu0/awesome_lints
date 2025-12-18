import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSliverPrefix extends DartLintRule {
  const PreferSliverPrefix() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_sliver_prefix',
    problemMessage:
        'Add "Sliver" prefix to widget classes that return sliver widgets.',
    correctionMessage:
        'Rename the class to start with "Sliver" to indicate it returns a sliver widget.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Two-pass approach:
    // First pass: collect all StatefulWidget and State classes
    final Map<String, ClassDeclaration> statefulWidgetNodes = {};
    final Map<String, ClassDeclaration> stateNodes = {};
    final Map<String, String> stateToWidgetMap = {};

    // First pass: collect all classes
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element == null) return;

      final className = element.name3;
      if (className == null) return;

      final superType = element.supertype;
      if (superType == null) return;

      final superTypeName = superType.element3.name3;

      if (superTypeName == 'StatefulWidget') {
        statefulWidgetNodes[className] = node;
      } else if (superTypeName == 'State') {
        final typeArguments = superType.typeArguments;
        if (typeArguments.isNotEmpty) {
          final statefulWidgetType = typeArguments.first;
          final statefulWidgetName = statefulWidgetType.element3?.name3;
          if (statefulWidgetName != null) {
            stateNodes[className] = node;
            stateToWidgetMap[className] = statefulWidgetName;
          }
        }
      }
    });

    // Second pass: check for sliver return types
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element == null) return;

      final className = element.name3;
      if (className == null) return;

      // Skip if class name already starts with "Sliver"
      if (className.startsWith('Sliver')) return;

      final superType = element.supertype;
      if (superType == null) return;

      final superTypeName = superType.element3.name3;

      // Handle StatelessWidget
      if (superTypeName == 'StatelessWidget') {
        final visitor = _BuildMethodVisitor();
        node.visitChildren(visitor);

        if (visitor.buildMethod != null) {
          final returnsSliverWidget =
              _returnsSliverWidget(visitor.buildMethod!);

          if (returnsSliverWidget) {
            reporter.atNode(node, _code);
          }
        }
      }
      // Handle State<T>
      else if (superTypeName == 'State') {
        final statefulWidgetName = stateToWidgetMap[className];
        if (statefulWidgetName == null) return;

        // Skip if the StatefulWidget name already starts with "Sliver"
        if (statefulWidgetName.startsWith('Sliver')) return;

        final visitor = _BuildMethodVisitor();
        node.visitChildren(visitor);

        if (visitor.buildMethod != null) {
          final returnsSliverWidget =
              _returnsSliverWidget(visitor.buildMethod!);

          if (returnsSliverWidget) {
            // Report on the StatefulWidget class, not the State class
            final statefulWidgetNode = statefulWidgetNodes[statefulWidgetName];
            if (statefulWidgetNode != null) {
              reporter.atNode(statefulWidgetNode, _code);
            }
          }
        }
      }
    });
  }

  /// Checks if the build method returns a Sliver widget.
  bool _returnsSliverWidget(MethodDeclaration buildMethod) {
    final visitor = _ReturnTypeVisitor();
    buildMethod.visitChildren(visitor);

    // Check all return statements in the build method
    for (final returnStatement in visitor.returnStatements) {
      final expression = returnStatement.expression;
      if (expression == null) continue;

      if (_isSliverType(expression.staticType)) {
        return true;
      }
    }

    // Also check the expression body if it's an arrow function
    final functionBody = buildMethod.body;
    if (functionBody is ExpressionFunctionBody) {
      final expression = functionBody.expression;
      if (_isSliverType(expression.staticType)) {
        return true;
      }
    }

    return false;
  }

  /// Checks if a type is a Sliver widget type.
  bool _isSliverType(DartType? type) {
    if (type == null) return false;

    // Get the type name without type parameters
    final typeName = type.getDisplayString();

    // Also check the element name directly
    final elementName = type.element3?.name3 ?? '';

    // Check if the type name starts with "Sliver"
    // This covers SliverList, SliverGrid, SliverAppBar, SliverPadding, etc.
    return typeName.startsWith('Sliver') || elementName.startsWith('Sliver');
  }
}

/// Visitor to find the build method in a widget class.
class _BuildMethodVisitor extends RecursiveAstVisitor<void> {
  MethodDeclaration? buildMethod;

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    // Look for a method named "build" with a Widget return type
    if (node.name.lexeme == 'build') {
      buildMethod = node;
    }
    super.visitMethodDeclaration(node);
  }
}

/// Visitor to collect all return statements in a method.
class _ReturnTypeVisitor extends RecursiveAstVisitor<void> {
  final List<ReturnStatement> returnStatements = [];

  @override
  void visitReturnStatement(ReturnStatement node) {
    returnStatements.add(node);
    super.visitReturnStatement(node);
  }
}
