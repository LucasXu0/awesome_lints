import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('AvoidSingleChildColumnOrRow', () {
    test('should trigger lint for actual single child cases', () async {
      // Run custom_lint on the test project
      final result = await Process.run(
        'dart',
        ['run', 'custom_lint'],
        workingDirectory: 'test/fixtures/test_project',
      );

      // custom_lint output can be in either stdout or stderr
      final output = '${result.stdout}\n${result.stderr}';

      // Parse issues by file
      final shouldTriggerIssues = output
          .split('\n')
          .where((line) =>
              line.contains('should_trigger_lint.dart') &&
              line.contains('avoid_single_child_column_or_row'))
          .toList();

      final shouldNotTriggerIssues = output
          .split('\n')
          .where((line) =>
              line.contains('should_not_trigger_lint.dart') &&
              line.contains('avoid_single_child_column_or_row'))
          .toList();

      // Verify: should_trigger_lint.dart should have exactly 5 issues
      expect(
        shouldTriggerIssues.length,
        5,
        reason: 'should_trigger_lint.dart should have exactly 5 lint issues',
      );

      // Verify: should_not_trigger_lint.dart should have 0 issues
      expect(
        shouldNotTriggerIssues.length,
        0,
        reason:
            'should_not_trigger_lint.dart should not trigger any false positives',
      );

      // Verify the total issue count
      final summaryLine =
          output.split('\n').lastWhere((line) => line.contains('issues found'));
      expect(
        summaryLine,
        contains('5 issues found'),
        reason: 'Total issues should be exactly 5',
      );
    });
  });
}

// Note: For comprehensive integration testing of custom_lint rules,
// it's recommended to use the following approach:
//
// 1. Create a test Flutter project in test/fixtures/
// 2. Add your lint rule to the analysis_options.yaml
// 3. Create test files with both valid and invalid code
// 4. Run custom_lint on the test project
// 5. Verify the expected warnings are generated
//
// Example structure:
// test/
//   fixtures/
//     test_project/
//       lib/
//         single_child_column.dart      # Should trigger warning
//         multiple_children_column.dart # Should NOT trigger warning
//       analysis_options.yaml
//       pubspec.yaml
//
// This approach provides end-to-end testing of your lint rule
// in a real Flutter environment.
