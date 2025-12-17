import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('AvoidUnnecessaryGestureDetector', () {
    test('should trigger lint when GestureDetector has no callbacks', () async {
      final result = await Process.run(
        'dart',
        ['run', 'custom_lint'],
        workingDirectory: 'test/fixtures/test_project',
      );

      final output = '${result.stdout}\n${result.stderr}';
      final lines = output.split('\n');

      final shouldTriggerLintErrors = lines
          .where((line) =>
              line.contains('avoid_unnecessary_gesture_detector/should_trigger_lint.dart') &&
              line.contains('unfulfilled_expect_lint'))
          .toList();

      final shouldNotTriggerLintIssues = lines
          .where((line) =>
              line.contains('avoid_unnecessary_gesture_detector/should_not_trigger_lint.dart') &&
              line.contains('avoid_unnecessary_gesture_detector') &&
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