import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferIterableOf extends DartLintRule {
  const PreferIterableOf() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_iterable_of',
    problemMessage:
        'Prefer using .of() over .from() when the source and target types are compatible.',
    correctionMessage:
        'Use .of() for compile-time type safety. Use .from() only when converting between different types.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // List.from() and Set.from() are factory constructors, not methods
    context.registry.addInstanceCreationExpression((node) {
      final constructorName = node.constructorName;
      final typeName = constructorName.type.name.lexeme;
      final factoryName = constructorName.name?.name;

      // Check if it's List.from or Set.from
      if ((typeName != 'List' && typeName != 'Set') || factoryName != 'from') {
        return;
      }

      // Get the type arguments of the created instance
      final createdType = node.staticType;
      if (createdType == null || createdType is! InterfaceType) return;

      final targetTypeArgs = createdType.typeArguments;
      if (targetTypeArgs.isEmpty) return; // Dynamic type

      final targetElementType = targetTypeArgs.first;

      // Get the argument passed to .from()
      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final argument = arguments.first;
      final argumentType = argument.staticType;
      if (argumentType == null) return;

      // For list/set literals and other iterables
      InterfaceType? argumentInterfaceType;
      if (argumentType is InterfaceType) {
        argumentInterfaceType = argumentType;
      } else {
        return; // Can't analyze non-interface types
      }

      // Get the element type of the source iterable
      final sourceElementType = _getIterableElementType(argumentInterfaceType);
      if (sourceElementType == null) return;

      // Check if the types are compatible (exact match only)
      if (_areTypesCompatible(sourceElementType, targetElementType)) {
        reporter.atNode(constructorName, _code);
      }
    });
  }

  /// Extracts the element type from an Iterable type
  DartType? _getIterableElementType(InterfaceType type) {
    // Check if it has type arguments (List<T>, Set<T>, etc.)
    if (type.typeArguments.isNotEmpty) {
      return type.typeArguments.first;
    }

    return null;
  }

  /// Checks if source and target types are exactly the same
  /// (no subtype relationships, only exact matches)
  bool _areTypesCompatible(DartType sourceType, DartType targetType) {
    // If types are dynamic, we can't determine compatibility
    if (sourceType is DynamicType || targetType is DynamicType) {
      return false;
    }

    // Check if types are exactly equal using display string
    // This ensures int != num, String != Object, etc.
    final sourceString = sourceType.getDisplayString();
    final targetString = targetType.getDisplayString();

    return sourceString == targetString;
  }
}
