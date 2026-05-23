// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 管理首次引导中的提醒策略草稿，保持展示层只处理用户意图。

@ProviderFor(ReminderSettingsController)
const reminderSettingsControllerProvider =
    ReminderSettingsControllerProvider._();

/// 管理首次引导中的提醒策略草稿，保持展示层只处理用户意图。
final class ReminderSettingsControllerProvider
    extends
        $NotifierProvider<ReminderSettingsController, ReminderSettingsState> {
  /// 管理首次引导中的提醒策略草稿，保持展示层只处理用户意图。
  const ReminderSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSettingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSettingsControllerHash();

  @$internal
  @override
  ReminderSettingsController create() => ReminderSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderSettingsState>(value),
    );
  }
}

String _$reminderSettingsControllerHash() =>
    r'444149898be15ff6c406bfef021d7979ebd7b7a4';

/// 管理首次引导中的提醒策略草稿，保持展示层只处理用户意图。

abstract class _$ReminderSettingsController
    extends $Notifier<ReminderSettingsState> {
  ReminderSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReminderSettingsState, ReminderSettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReminderSettingsState, ReminderSettingsState>,
              ReminderSettingsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
