import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'lints/flutter/flutter.dart';

PluginBase createPlugin() => _AwesomeLints();

class _AwesomeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) =>
      [...flutterLintRules];

  List<LintRule> flutterLintRules = [
    AvoidEmptySetstate(),
    AvoidLateContext(),
    AvoidMissingController(),
    AvoidMountedInSetstate(),
    AvoidSingleChildColumnOrRow(),
    AvoidStatelessWidgetInitializedFields(),
    AvoidUndisposedInstances(),
    AvoidUnnecessaryGestureDetector(),
    AvoidUnnecessaryOverridesInState(),
    AvoidUnnecessaryStatefulWidgets(),
    AvoidWrappingInPadding(),
    DisposeFields(),
    PassExistingFutureToFutureBuilder(),
    PassExistingStreamToStreamBuilder(),
    PreferActionButtonTooltip(),
    PreferAlignOverContainer(),
    PreferAsyncCallback(),
    PreferCenterOverAlign(),
    PreferComputeOverIsolateRun(),
    PreferConstrainedBoxOverContainer(),
    PreferContainer(),
    PreferDedicatedMediaQueryMethods(),
    PreferForLoopInChildren(),
    PreferPaddingOverContainer(),
    PreferSingleSetstate(),
    PreferSizedBoxSquare(),
    PreferSliverPrefix(),
    PreferSpacing(),
    PreferTextRich(),
    PreferVoidCallback(),
    PreferWidgetPrivateMembers(),
    ProperSuperCalls(),
  ];
}
