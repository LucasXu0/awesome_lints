import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'lints/avoid_single_child_column_or_row.dart';

PluginBase createPlugin() => _AwesomeLints();

class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        AvoidSingleChildColumnOrRow(),
      ];
}
