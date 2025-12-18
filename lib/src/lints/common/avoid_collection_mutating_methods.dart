import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCollectionMutatingMethods extends DartLintRule {
  const AvoidCollectionMutatingMethods() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_collection_mutating_methods',
    problemMessage:
        'Avoid calling mutating methods on collections as they can cause unexpected side effects.',
    correctionMessage:
        'Consider creating a copy of the collection before mutating it, or ensure this behavior is intentional.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  // Common mutating methods for collections
  static const _mutatingMethods = {
    // List methods
    'add',
    'addAll',
    'insert',
    'insertAll',
    'remove',
    'removeAt',
    'removeLast',
    'removeRange',
    'removeWhere',
    'retainWhere',
    'clear',
    'sort',
    'shuffle',
    'fillRange',
    'replaceRange',
    'setAll',
    'setRange',
    // Set methods (add, remove, clear already listed)
    // Map methods
    'putIfAbsent',
    'update',
    'updateAll',
    'addEntries',
  };

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if the method name is in the list of mutating methods
      final methodName = node.methodName.name;
      if (!_mutatingMethods.contains(methodName)) {
        return;
      }

      // Check if the target is a collection
      final target = node.realTarget;
      if (target == null) return;

      final targetType = target.staticType;
      if (targetType == null) return;

      if (_isCollectionType(targetType)) {
        reporter.atNode(
          node.methodName,
          _code,
        );
      }
    });
  }

  bool _isCollectionType(DartType type) {
    return type.isDartCoreList || type.isDartCoreSet || type.isDartCoreMap;
  }
}
