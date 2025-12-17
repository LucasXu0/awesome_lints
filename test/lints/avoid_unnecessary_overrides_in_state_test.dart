import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('AvoidUnnecessaryOverridesInState', () {
    test('should trigger lint for unnecessary overrides in State classes',
        () async {
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
              line.contains('avoid_unnecessary_overrides_in_state'))
          .toList();

      final shouldNotTriggerIssues = output
          .split('\n')
          .where((line) =>
              line.contains('should_not_trigger_lint.dart') &&
              line.contains('avoid_unnecessary_overrides_in_state'))
          .toList();

      // Verify: should_trigger_lint.dart should have exactly 4 issues
      expect(
        shouldTriggerIssues.length,
        4,
        reason: 'should_trigger_lint.dart should have exactly 4 lint issues',
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
