import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAsyncCallInSyncFunction extends DartLintRule {
  const AvoidAsyncCallInSyncFunction() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_async_call_in_sync_function',
    problemMessage:
        'Avoid calling async functions in synchronous contexts without awaiting or handling the Future.',
    correctionMessage:
        'Make the function async and await the call, use unawaited(), or call .ignore() on the Future.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Skip if we're already in an async context
      if (_isInAsyncContext(node)) return;

      // Skip if the invocation is awaited
      if (_isAwaited(node)) return;

      // Skip if wrapped in unawaited() or .ignore()
      if (_isHandled(node)) return;

      // Skip if passed to a parameter that expects a Future
      if (_isPassedToFutureParameter(node)) return;

      // Check if the invoked method is async
      final element = node.methodName.element;
      if (element is ExecutableElement) {
        final returnType = element.returnType;
        if (_isFutureType(returnType) && element.firstFragment.isAsynchronous) {
          reporter.atNode(node.methodName, _code);
        }
      }
    });

    context.registry.addFunctionExpressionInvocation((node) {
      // Skip if we're already in an async context
      if (_isInAsyncContext(node)) return;

      // Skip if the invocation is awaited
      if (_isAwaited(node)) return;

      // Skip if wrapped in unawaited() or .ignore()
      if (_isHandled(node)) return;

      // Skip if passed to a parameter that expects a Future
      if (_isPassedToFutureParameter(node)) return;

      // Check if the function returns a Future
      final element = node.element;
      if (element is ExecutableElement) {
        final returnType = element.returnType;
        if (_isFutureType(returnType) && element.firstFragment.isAsynchronous) {
          reporter.atNode(node, _code);
        }
      }
    });
  }

  bool _isInAsyncContext(AstNode node) {
    AstNode? current = node;
    while (current != null) {
      if (current is FunctionExpression) {
        return current.body.isAsynchronous;
      }
      if (current is MethodDeclaration) {
        return current.body.isAsynchronous;
      }
      if (current is FunctionDeclaration) {
        return current.functionExpression.body.isAsynchronous;
      }
      if (current is ConstructorDeclaration) {
        // Constructors can't be async
        return false;
      }
      current = current.parent;
    }
    return false;
  }

  bool _isAwaited(AstNode node) {
    final parent = node.parent;
    return parent is AwaitExpression;
  }

  bool _isHandled(AstNode node) {
    final parent = node.parent;

    // Check for unawaited(asyncCall())
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is MethodInvocation) {
        if (grandParent.methodName.name == 'unawaited') {
          return true;
        }
      }
    }

    // Check for asyncCall().ignore()
    if (parent is PropertyAccess || parent is MethodInvocation) {
      final methodName = parent is PropertyAccess
          ? parent.propertyName.name
          : (parent as MethodInvocation).methodName.name;
      if (methodName == 'ignore') {
        return true;
      }
    }

    return false;
  }

  bool _isFutureType(DartType type) {
    final element = type.element;
    if (element == null) return false;

    // Check if it's a Future or FutureOr
    final name = element.displayName;
    return name == 'Future' || name == 'FutureOr';
  }

  bool _isPassedToFutureParameter(AstNode node) {
    final parent = node.parent;

    // Check if this is a named argument
    if (parent is NamedExpression) {
      final argumentList = parent.parent;
      if (argumentList is ArgumentList) {
        final invocation = argumentList.parent;

        // Get the parameter element for this named argument
        if (invocation is InstanceCreationExpression) {
          final constructor = invocation.constructorName.element;
          if (constructor is ConstructorElement) {
            try {
              final parameter = constructor.formalParameters.firstWhere(
                (p) => p.name == parent.name.label.name,
              );
              return _isFutureType(parameter.type);
            } catch (_) {
              // Parameter not found
              return false;
            }
          }
        } else if (invocation is MethodInvocation) {
          final method = invocation.methodName.element;
          if (method is ExecutableElement) {
            try {
              final parameter = method.formalParameters.firstWhere(
                (p) => p.name == parent.name.label.name,
              );
              return _isFutureType(parameter.type);
            } catch (_) {
              // Parameter not found
              return false;
            }
          }
        }
      }
    }

    // Check if this is a positional argument
    if (parent is ArgumentList) {
      final invocation = parent.parent;
      final index = parent.arguments.indexOf(node as Expression);

      if (index >= 0) {
        if (invocation is InstanceCreationExpression) {
          final constructor = invocation.constructorName.element;
          if (constructor is ConstructorElement) {
            if (index < constructor.formalParameters.length) {
              return _isFutureType(constructor.formalParameters[index].type);
            }
          }
        } else if (invocation is MethodInvocation) {
          final method = invocation.methodName.element;
          if (method is ExecutableElement) {
            if (index < method.formalParameters.length) {
              return _isFutureType(method.formalParameters[index].type);
            }
          }
        }
      }
    }

    return false;
  }
}
