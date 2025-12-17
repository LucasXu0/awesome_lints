import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'lints/avoid_mounted_in_setstate.dart';
import 'lints/avoid_single_child_column_or_row.dart';
import 'lints/avoid_unnecessary_overrides_in_state.dart';
import 'lints/pass_existing_future_to_future_builder.dart';
import 'lints/prefer_void_callback.dart';

PluginBase createPlugin() => _AwesomeLints();

class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        AvoidSingleChildColumnOrRow(),
        AvoidUnnecessaryOverridesInState(),
        PassExistingFutureToFutureBuilder(),
        PreferVoidCallback(),
        AvoidMountedInSetstate(),
      ];
}
