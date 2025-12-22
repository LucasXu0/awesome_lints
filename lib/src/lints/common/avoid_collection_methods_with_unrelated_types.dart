import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/type_compatibility_checker.dart';

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

  static const _typeChecker = TypeCompatibilityChecker();

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
        if (!_typeChecker.isValidMapKey(targetType, indexType)) {
          reporter.atNode(index, _code);
        }
      } else if (targetType.isDartCoreList) {
        if (!_typeChecker.isValidListIndex(indexType)) {
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

    if (!_typeChecker.isValidCollectionElement(collectionType, argumentType)) {
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
    if (_mapKeyMethods.contains(methodName)) {
      if (!_typeChecker.isValidMapKey(mapType, argumentType)) {
        reporter.atNode(argument, _code);
      }
    } else if (_mapValueMethods.contains(methodName)) {
      if (!_typeChecker.isValidMapValue(mapType, argumentType)) {
        reporter.atNode(argument, _code);
      }
    }
  }
}
