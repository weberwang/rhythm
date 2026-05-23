// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_schedule_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 管理目标作息表单草稿与提交校验，避免页面直接处理字段联动。

@ProviderFor(GoalScheduleFormController)
const goalScheduleFormControllerProvider =
    GoalScheduleFormControllerProvider._();

/// 管理目标作息表单草稿与提交校验，避免页面直接处理字段联动。
final class GoalScheduleFormControllerProvider
    extends
        $NotifierProvider<GoalScheduleFormController, GoalScheduleFormState> {
  /// 管理目标作息表单草稿与提交校验，避免页面直接处理字段联动。
  const GoalScheduleFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalScheduleFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalScheduleFormControllerHash();

  @$internal
  @override
  GoalScheduleFormController create() => GoalScheduleFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalScheduleFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalScheduleFormState>(value),
    );
  }
}

String _$goalScheduleFormControllerHash() =>
    r'b08d9de2bdc6ed2ee4b49928c4537f320e577be6';

/// 管理目标作息表单草稿与提交校验，避免页面直接处理字段联动。

abstract class _$GoalScheduleFormController
    extends $Notifier<GoalScheduleFormState> {
  GoalScheduleFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GoalScheduleFormState, GoalScheduleFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoalScheduleFormState, GoalScheduleFormState>,
              GoalScheduleFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
