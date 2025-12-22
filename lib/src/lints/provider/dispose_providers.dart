import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/ast_extensions.dart';
import '../../utils/disposal_utils.dart';

class DisposeProviders extends DartLintRule {
  const DisposeProviders() : super(code: _code);

  static const _code = LintCode(
    name: 'dispose_providers',
    problemMessage:
        'Provider creates a disposable object but does not call its dispose method.',
    correctionMessage:
        'Add a dispose callback to the Provider that calls the dispose/close/cancel method.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!_isProvider(node)) return;

      // Only check if there's a create function
      final createFunction = _getCreateFunction(node);
      if (createFunction == null) return;

      // Get the type from the Provider's type argument
      final createdType = _getProviderTypeArgument(node);
      if (createdType == null) return;

      if (_hasDisposeMethod(createdType)) {
        final disposeCallback = _getDisposeCallback(node);
        if (disposeCallback == null) {
          reporter.atNode(node.constructorName, _code);
        }
      }
    });
  }

  bool _isProvider(InstanceCreationExpression node) {
    final typeName = node.constructorName.type.name.lexeme;
    // Match any Provider variant (Provider, ChangeNotifierProvider, etc.)
    return typeName.contains('Provider') && !typeName.contains('Multi');
  }

  Expression? _getCreateFunction(InstanceCreationExpression node) {
    return node.argumentList.getNamedArgument('create')?.expression;
  }

  ClassElement? _getProviderTypeArgument(InstanceCreationExpression node) {
    // Get the type argument from Provider<T>
    final typeArguments = node.constructorName.type.typeArguments;
    if (typeArguments == null || typeArguments.arguments.isEmpty) {
      return null;
    }

    final typeArg = typeArguments.arguments.first;
    if (typeArg is NamedType) {
      final type = typeArg.type;
      if (type != null) {
        final element = type.element;
        if (element is ClassElement) {
          return element;
        }
      }
    }
    return null;
  }

  bool _hasDisposeMethod(ClassElement classElement) {
    // Check if the class has any disposal method (dispose, close, or cancel)
    ClassElement? current = classElement;
    while (current != null) {
      for (final method in current.methods) {
        if (DisposalUtils.disposalMethods.contains(method.name)) {
          return true;
        }
      }
      final supertype = current.supertype;
      current = supertype?.element is ClassElement
          ? supertype!.element as ClassElement
          : null;
    }

    return false;
  }

  Expression? _getDisposeCallback(InstanceCreationExpression node) {
    return node.argumentList.getNamedArgument('dispose')?.expression;
  }
}
