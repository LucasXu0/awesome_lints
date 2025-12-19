import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCollectionMethodsWithUnrelatedTypes extends DartLintRule {
  const AvoidCollectionMethodsWithUnrelatedTypes() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_collection_methods_with_unrelated_types',
    problemMessage:
        'Collection method is called with an incompatible type that will never match.',
    correctionMessage:
        'Ensure the argument type matches the collection\'s element type.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  // Methods that take an element type parameter
  static const _elementMethods = {
    'contains',
    'remove',
    'indexOf',
    'lastIndexOf',
  };

  // Map-specific methods
  static const _mapKeyMethods = {'containsKey', 'remove'};

  static const _mapValueMethods = {'containsValue'};

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // Check method invocations
    context.registry.addMethodInvocation((node) {
      final methodName = node.methodName.name;

      // Check if it's a relevant method
      if (!_elementMethods.contains(methodName) &&
          !_mapKeyMethods.contains(methodName) &&
          !_mapValueMethods.contains(methodName)) {
        return;
      }

      // Get the target type
      final target = node.realTarget;
      if (target == null) return;

      final targetType = target.staticType;
      if (targetType == null || targetType is! InterfaceType) return;

      // Get the argument
      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final argument = arguments.first;
      final argumentType = argument.staticType;
      if (argumentType == null) return;

      // Check the collection type and expected parameter type
      if (targetType.isDartCoreList || targetType.isDartCoreSet) {
        _checkListOrSetMethod(
          targetType,
          argumentType,
          methodName,
          argument,
          reporter,
        );
      } else if (targetType.isDartCoreMap) {
        _checkMapMethod(
          targetType,
          argumentType,
          methodName,
          argument,
          reporter,
        );
      }
    });

    // Check index access (e.g., map[key])
    context.registry.addIndexExpression((node) {
      final target = node.realTarget;
      final targetType = target.staticType;

      if (targetType == null || targetType is! InterfaceType) return;

      final index = node.index;
      final indexType = index.staticType;
      if (indexType == null) return;

      if (targetType.isDartCoreMap) {
        final typeArgs = targetType.typeArguments;
        if (typeArgs.isNotEmpty) {
          final keyType = typeArgs[0];
          if (!_isCompatibleType(indexType, keyType)) {
            reporter.atNode(index, _code);
          }
        }
      } else if (targetType.isDartCoreList) {
        // List indexing should be int
        if (!indexType.isDartCoreInt) {
          reporter.atNode(index, _code);
        }
      }
    });
  }

  void _checkListOrSetMethod(
    InterfaceType collectionType,
    DartType argumentType,
    String methodName,
    Expression argument,
    DiagnosticReporter reporter,
  ) {
    if (!_elementMethods.contains(methodName)) return;

    final typeArgs = collectionType.typeArguments;
    if (typeArgs.isEmpty) return; // Dynamic collection

    final elementType = typeArgs.first;

    if (!_isCompatibleType(argumentType, elementType)) {
      reporter.atNode(argument, _code);
    }
  }

  void _checkMapMethod(
    InterfaceType mapType,
    DartType argumentType,
    String methodName,
    Expression argument,
    DiagnosticReporter reporter,
  ) {
    final typeArgs = mapType.typeArguments;
    if (typeArgs.length < 2) return; // Dynamic map

    if (_mapKeyMethods.contains(methodName)) {
      final keyType = typeArgs[0];
      if (!_isCompatibleType(argumentType, keyType)) {
        reporter.atNode(argument, _code);
      }
    } else if (_mapValueMethods.contains(methodName)) {
      final valueType = typeArgs[1];
      if (!_isCompatibleType(argumentType, valueType)) {
        reporter.atNode(argument, _code);
      }
    }
  }

  bool _isCompatibleType(DartType argumentType, DartType expectedType) {
    // Check if types have dynamic element (dynamic type)
    if (argumentType.element?.name == 'dynamic' ||
        expectedType.element?.name == 'dynamic') {
      return true;
    }

    // Object is compatible with everything
    if (expectedType.isDartCoreObject) {
      return true;
    }

    // Null type is compatible with nullable types
    if (argumentType.element?.name == 'Null') {
      return true;
    }

    // Check if argument type is exactly the expected type
    if (argumentType == expectedType) {
      return true;
    }

    // Check subtype relationship for interface types
    if (argumentType is InterfaceType && expectedType is InterfaceType) {
      if (argumentType.element == expectedType.element) {
        return true;
      }
    }

    // Simple name-based check for compatibility
    // This is a simplified approach that may have some false negatives
    // but avoids the complexity of full type hierarchy analysis
    final argName = argumentType.element?.name;
    final expName = expectedType.element?.name;

    if (argName == expName) {
      return true;
    }

    // Check for num/int/double compatibility
    if (expName == 'num' && (argName == 'int' || argName == 'double')) {
      return true;
    }
    if (expName == 'int' && argName == 'int') {
      return true;
    }
    if (expName == 'double' && argName == 'double') {
      return true;
    }

    // If types are completely different, they're incompatible
    return false;
  }
}
