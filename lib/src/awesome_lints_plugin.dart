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
import 'lints/prefer_action_button_tooltip.dart';
import 'lints/prefer_async_callback.dart';
import 'lints/prefer_compute_over_isolate_run.dart';
import 'lints/prefer_dedicated_media_query_methods.dart';
import 'lints/prefer_single_setstate.dart';
import 'lints/prefer_sized_box_square.dart';
import 'lints/prefer_sliver_prefix.dart';
import 'lints/prefer_text_rich.dart';
import 'lints/prefer_void_callback.dart';
import 'lints/prefer_widget_private_members.dart';
import 'lints/proper_super_calls.dart';

PluginBase createPlugin() => _AwesomeLints();

class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        AvoidEmptySetstate(),
        AvoidMountedInSetstate(),
        AvoidSingleChildColumnOrRow(),
        AvoidUndisposedInstances(),
        AvoidUnnecessaryGestureDetector(),
        AvoidUnnecessaryOverridesInState(),
        AvoidUnnecessaryStatefulWidgets(),
        AvoidWrappingInPadding(),
        DisposeFields(),
        PassExistingFutureToFutureBuilder(),
        PreferActionButtonTooltip(),
        PreferAsyncCallback(),
        PreferComputeOverIsolateRun(),
        PreferDedicatedMediaQueryMethods(),
        PreferSingleSetstate(),
        PreferSizedBoxSquare(),
        PreferSliverPrefix(),
        PreferTextRich(),
        PreferVoidCallback(),
        PreferWidgetPrivateMembers(),
        ProperSuperCalls(),
      ];
}
