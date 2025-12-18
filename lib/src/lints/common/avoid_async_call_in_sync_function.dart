import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
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
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
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

      // TODO: Add support for detecting assignments to Future-typed variables
      // if (_isAssignedToFutureVariable(node)) return;

      // Check if the invoked method is async
      final element = node.methodName.element;
      if (element is ExecutableElement2) {
        final returnType = element.returnType;
        if (_isFutureType(returnType) && element.firstFragment.isAsynchronous) {
          reporter.atNode(
            node.methodName,
            _code,
          );
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

      // TODO: Add support for detecting assignments to Future-typed variables
      // if (_isAssignedToFutureVariable(node)) return;

      // Check if the function returns a Future
      final element = node.element;
      if (element is ExecutableElement2) {
        final returnType = element.returnType;
        if (_isFutureType(returnType) && element.firstFragment.isAsynchronous) {
          reporter.atNode(
            node,
            _code,
          );
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
    final element = type.element3;
    if (element == null) return false;

    // Check if it's a Future or FutureOr
    final name = element.displayName;
    return name == 'Future' || name == 'FutureOr';
  }

  bool _isFutureTypeByName(DartType type) {
    // Alternative check using display string
    final typeStr = type.getDisplayString();
    return typeStr.startsWith('Future<') ||
        typeStr.startsWith('FutureOr<') ||
        typeStr == 'Future' ||
        typeStr == 'FutureOr';
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
          if (constructor is ConstructorElement2) {
            try {
              final parameter = constructor.formalParameters.firstWhere(
                (p) => p.name3 == parent.name.label.name,
              );
              return _isFutureType(parameter.type);
            } catch (_) {
              // Parameter not found
              return false;
            }
          }
        } else if (invocation is MethodInvocation) {
          final method = invocation.methodName.element;
          if (method is ExecutableElement2) {
            try {
              final parameter = method.formalParameters.firstWhere(
                (p) => p.name3 == parent.name.label.name,
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
          if (constructor is ConstructorElement2) {
            if (index < constructor.formalParameters.length) {
              return _isFutureType(constructor.formalParameters[index].type);
            }
          }
        } else if (invocation is MethodInvocation) {
          final method = invocation.methodName.element;
          if (method is ExecutableElement2) {
            if (index < method.formalParameters.length) {
              return _isFutureType(method.formalParameters[index].type);
            }
          }
        }
      }
    }

    return false;
  }

  bool _isAssignedToFutureVariable(AstNode node) {
    // Traverse up the tree to find assignment or variable declaration
    AstNode? current = node.parent;
    int depth = 0;
    const maxDepth = 5; // Limit traversal depth

    while (current != null && depth < maxDepth) {
      // Check if we found an assignment expression
      if (current is AssignmentExpression) {
        final leftType = current.leftHandSide.staticType;
        if (leftType != null) {
          if (_isFutureTypeByName(leftType)) {
            return true;
          }
        }
        // If we found an assignment but it's not to a Future, stop here
        return false;
      }

      // Check if we found a variable declaration
      if (current is VariableDeclaration) {
        // Try multiple ways to get the type
        final element = current.declaredFragment?.element;
        if (element != null) {
          if (_isFutureTypeByName(element.type)) {
            return true;
          }
        }
        // Also check initializer static type as fallback
        final initType = current.initializer?.staticType;
        if (initType != null && _isFutureTypeByName(initType)) {
          return true;
        }
        // If we found a variable declaration but it's not a Future, stop here
        return false;
      }

      // Stop if we reach certain boundaries
      if (current is FunctionDeclaration ||
          current is MethodDeclaration ||
          current is FunctionExpression) {
        break;
      }

      current = current.parent;
      depth++;
    }

    return false;
  }
}
