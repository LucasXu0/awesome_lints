import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:analyzer/error/listener.dart';

/// A lint rule wrapper for test fixtures.
///
/// The fixture project stores each lint's fixtures in:
/// `test/fixtures/test_project/lib/<category>/<lint_name>/...`
///
/// When analyzing those files, we only want to run the lint whose [LintCode.name]
/// matches `<lint_name>`. This avoids needing massive `ignore_for_file` headers.
class FixtureFilteredLintRule extends LintRule {
  FixtureFilteredLintRule(this._delegate) : super(code: _delegate.code);

  final LintRule _delegate;

  @override
  bool get enabledByDefault => _delegate.enabledByDefault;

  @override
  List<String> get filesToAnalyze => _delegate.filesToAnalyze;

  @override
  bool isEnabled(CustomLintConfigs configs) => _delegate.isEnabled(configs);

  bool _shouldRunForFile(String path) {
    final normalized = path.replaceAll('\\', '/');
    const marker = '/test/fixtures/test_project/lib/';
    final markerIndex = normalized.indexOf(marker);

    // Not part of the fixture project: run normally.
    if (markerIndex == -1) return true;

    // Expected structure: <category>/<lint_name>/<file>
    final relative = normalized.substring(markerIndex + marker.length);
    final parts = relative.split('/');
    if (parts.length < 2) return false;

    final lintNameFromPath = parts[1];
    return lintNameFromPath == code.name;
  }

  @override
  Future<void> startUp(
    CustomLintResolver resolver,
    CustomLintContext context,
  ) async {
    if (!_shouldRunForFile(resolver.path)) return;
    await _delegate.startUp(resolver, context);
  }

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    if (!_shouldRunForFile(resolver.path)) return;
    _delegate.run(resolver, reporter, context);
  }

  @override
  List<Fix> getFixes() => _delegate.getFixes();
}
