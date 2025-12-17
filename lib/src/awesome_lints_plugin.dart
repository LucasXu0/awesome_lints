import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'lints/avoid_empty_setstate.dart';
import 'lints/avoid_mounted_in_setstate.dart';
import 'lints/avoid_single_child_column_or_row.dart';
import 'lints/avoid_undisposed_instances.dart';
import 'lints/avoid_unnecessary_gesture_detector.dart';
import 'lints/avoid_unnecessary_overrides_in_state.dart';
import 'lints/avoid_unnecessary_stateful_widgets.dart';
import 'lints/avoid_wrapping_in_padding.dart';
import 'lints/dispose_fields.dart';
import 'lints/pass_existing_future_to_future_builder.dart';
import 'lints/prefer_sized_box_square.dart';
import 'lints/prefer_void_callback.dart';
import 'lints/proper_super_calls.dart';

PluginBase createPlugin() => _AwesomeLints();

class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        AvoidEmptySetstate(),
        AvoidSingleChildColumnOrRow(),
        AvoidUnnecessaryOverridesInState(),
        DisposeFields(),
        PassExistingFutureToFutureBuilder(),
        PreferSizedBoxSquare(),
        PreferVoidCallback(),
        AvoidMountedInSetstate(),
        ProperSuperCalls(),
        AvoidUndisposedInstances(),
        AvoidUnnecessaryGestureDetector(),
        AvoidUnnecessaryStatefulWidgets(),
        AvoidWrappingInPadding(),
      ];
}
