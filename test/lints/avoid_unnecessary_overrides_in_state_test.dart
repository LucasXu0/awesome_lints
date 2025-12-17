import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('AvoidUnnecessaryOverridesInState', () {
    test('should trigger lint for unnecessary overrides in State', () async {
      final result = await Process.run(
        'dart',
        ['run', 'custom_lint'],
        workingDirectory: 'test/fixtures/test_project',
      );

      final output = '${result.stdout}\n${result.stderr}';
      final lines = output.split('\n');

      final shouldTriggerLintErrors = lines
          .where((line) =>
              line.contains('avoid_unnecessary_overrides_in_state/should_trigger_lint.dart') &&
              line.contains('unfulfilled_expect_lint'))
          .toList();

      final shouldNotTriggerLintIssues = lines
          .where((line) =>
              line.contains('avoid_unnecessary_overrides_in_state/should_not_trigger_lint.dart') &&
              line.contains('avoid_unnecessary_overrides_in_state') &&
              !line.contains('unfulfilled_expect_lint'))
          .toList();

      expect(
        shouldTriggerLintErrors.length,
        0,
        reason: 'should_trigger_lint.dart should have no unfulfilled_expect_lint errors',
      );

      expect(
        shouldNotTriggerLintIssues.length,
        0,
        reason:
            'should_not_trigger_lint.dart should not trigger any false positives',
      );
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}