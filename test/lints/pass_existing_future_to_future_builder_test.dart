import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('PassExistingFutureToFutureBuilder', () {
    test('should trigger lint for inline future creation', () async {
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
              line.contains('pass_existing_future_to_future_builder'))
          .toList();

      final shouldNotTriggerIssues = output
          .split('\n')
          .where((line) =>
              line.contains('should_not_trigger_lint.dart') &&
              line.contains('pass_existing_future_to_future_builder'))
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
    });
  });
}
