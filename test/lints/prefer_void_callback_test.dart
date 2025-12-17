import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('PreferVoidCallback', () {
    test('should trigger lint for void Function() cases', () async {
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
              line.contains('prefer_void_callback'))
          .toList();

      final shouldNotTriggerIssues = output
          .split('\n')
          .where((line) =>
              line.contains('should_not_trigger_lint.dart') &&
              line.contains('prefer_void_callback'))
          .toList();

      // Verify: should_trigger_lint.dart should have exactly 12 issues
      // (1 function param, 2 variables, 1 return type, 2 generics,
      // 2 class fields, 1 typedef, 1 constructor param, 1 optional param, 1 named param)
      expect(
        shouldTriggerIssues.length,
        12,
        reason: 'should_trigger_lint.dart should have exactly 12 lint issues',
      );

      // Verify: should_not_trigger_lint.dart should have 0 issues
      expect(
        shouldNotTriggerIssues.length,
        0,
        reason:
            'should_not_trigger_lint.dart should not trigger any false positives',
      );

      // Verify the total issue count is reasonable (at least 12 from prefer_void_callback)
      final summaryLine =
          output.split('\n').lastWhere((line) => line.contains('issues found'));
      // Extract the number from the summary line
      final issueCount = int.tryParse(
        summaryLine.replaceAll(RegExp(r'[^\d]'), ''),
      );
      expect(
        issueCount,
        greaterThanOrEqualTo(12),
        reason: 'Total issues should include at least 12 from prefer_void_callback',
      );
    });
  });
}
