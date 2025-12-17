import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('AvoidEmptySetstate', () {
    test('should trigger lint when setState is empty', () async {
      final result = await Process.run(
        'dart',
        ['run', 'custom_lint'],
        workingDirectory: 'test/fixtures/test_project',
      );

      final output = '${result.stdout}\n${result.stderr}';
      final lines = output.split('\n');

      final shouldTriggerLintErrors = lines
          .where((line) =>
              line.contains('avoid_empty_setstate/should_trigger_lint.dart') &&
              line.contains('unfulfilled_expect_lint'))
          .toList();

      final shouldNotTriggerLintIssues = lines
          .where((line) =>
              line.contains('avoid_empty_setstate/should_not_trigger_lint.dart') &&
              line.contains('avoid_empty_setstate') &&
              !line.contains('unfulfilled_expect_lint'))
          .toList();

      if (shouldTriggerLintErrors.isNotEmpty) {
        print('Full custom_lint output for avoid_empty_setstate:');
        print(output);
      }

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
