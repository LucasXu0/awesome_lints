import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferWidgetPrivateMembers extends DartLintRule {
  const PreferWidgetPrivateMembers() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_widget_private_members',
    problemMessage:
        'Make widget members private to encapsulate implementation details.',
    correctionMessage:
        'Prefix the member name with an underscore (_) to make it private.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  // Standard State lifecycle methods that should not trigger the lint
  static const _stateLifecycleMethods = {
    'build',
    'initState',
    'didChangeDependencies',
    'didUpdateWidget',
    'reassemble',
    'deactivate',
    'dispose',
    'activate',
    'setState',
  };

  // Standard Widget lifecycle methods that should not trigger the lint
  static const _widgetLifecycleMethods = {
    'build',
    'createElement',
    'createState',
    'debugFillProperties',
    'toStringShort',
    'toStringShallow',
    'toStringDeep',
    'toDiagnosticsNode',
  };

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
      if (classNode == null) return;

      final classType = _getClassType(classNode);
      if (classType == null) return;

      _checkMethod(node, classType, reporter);
    });

    context.registry.addFieldDeclaration((node) {
      final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
      if (classNode == null) return;

      final classType = _getClassType(classNode);
      if (classType == null) return;

      _checkField(node, classType, reporter);
    });
  }

  /// Determines if the class extends State, Widget, StatefulWidget, or StatelessWidget
  _ClassType? _getClassType(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return null;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.element2?.displayName;

    switch (superclassName) {
      case 'State':
        return _ClassType.state;
      case 'StatefulWidget':
        return _ClassType.statefulWidget;
      case 'StatelessWidget':
        return _ClassType.statelessWidget;
      case 'Widget':
        return _ClassType.widget;
      default:
        return null;
    }
  }

  /// Checks if a method should trigger the lint
  void _checkMethod(
    MethodDeclaration method,
    _ClassType classType,
    ErrorReporter reporter,
  ) {
    final methodName = method.name.lexeme;

    // Skip private methods (already start with _)
    if (methodName.startsWith('_')) return;

    // Skip static methods
    if (method.isStatic) return;

    // Skip methods with @override annotation
    if (_hasOverrideAnnotation(method)) return;

    // Skip lifecycle methods based on class type
    if (classType == _ClassType.state &&
        _stateLifecycleMethods.contains(methodName)) {
      return;
    }

    if ((classType == _ClassType.widget ||
            classType == _ClassType.statefulWidget ||
            classType == _ClassType.statelessWidget) &&
        _widgetLifecycleMethods.contains(methodName)) {
      return;
    }

    // Report public method
    reporter.atNode(method, _code);
  }

  /// Checks if a field should trigger the lint
  void _checkField(
    FieldDeclaration field,
    _ClassType classType,
    ErrorReporter reporter,
  ) {
    // Only check fields for State classes
    if (classType != _ClassType.state) return;

    // Skip static fields
    if (field.isStatic) return;

    // Check each variable in the field declaration
    for (final variable in field.fields.variables) {
      final fieldName = variable.name.lexeme;

      // Skip private fields (already start with _)
      if (fieldName.startsWith('_')) continue;

      // Report public field
      reporter.atNode(variable, _code);
    }
  }

  /// Checks if a method has the @override annotation
  bool _hasOverrideAnnotation(MethodDeclaration method) {
    for (final annotation in method.metadata) {
      if (annotation.name.name == 'override') {
        return true;
      }
    }
    return false;
  }
}

enum _ClassType {
  state,
  widget,
  statefulWidget,
  statelessWidget,
}
