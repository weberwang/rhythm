import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/core/permissions/app_permission_models.dart';
import 'package:rhythm/core/storage/app_storage_providers.dart';
import 'package:rhythm/features/onboarding_activation/domain/onboarding_activation_models.dart';

part 'onboarding_activation_preferences_store.g.dart';

/// 负责首次激活草稿状态的本地持久化。
class OnboardingActivationPreferencesStore {
  /// 创建持久化适配器。
  const OnboardingActivationPreferencesStore();

  /// 当前步骤 key。
  static const String currentStepKey = 'onboarding.current_step';

  /// 进入方式 key。
  static const String entryModeKey = 'onboarding.entry_mode';

  /// 健康选择 key。
  static const String healthChoiceKey = 'onboarding.health_choice';

  /// 入睡小时 key。
  static const String bedtimeHourKey = 'onboarding.bedtime_hour';

  /// 起床小时 key。
  static const String wakeHourKey = 'onboarding.wake_hour';

  /// 提醒策略 key。
  static const String reminderChoiceKey = 'onboarding.reminder_choice';

  /// 提醒提前分钟 key。
  static const String reminderLeadMinutesKey = 'onboarding.reminder_lead_minutes';

  /// 健康权限状态 key。
  static const String healthPermissionStatusKey =
      'onboarding.health_permission_status';

  /// 提醒调度状态 key。
  static const String reminderScheduledKey = 'onboarding.reminder_scheduled';

  /// 读取本地草稿。
  Future<OnboardingActivationState> loadDraft(Ref ref) async {
    final preferences = await ref.watch(sharedPreferencesInstanceProvider.future);

    return OnboardingActivationState(
      currentStep: _stepFromIndex(preferences.getInt(currentStepKey)),
      entryMode: _entryModeFromName(preferences.getString(entryModeKey)),
      healthChoice: _healthChoiceFromName(
        preferences.getString(healthChoiceKey),
      ),
      bedtimeHour: preferences.getInt(bedtimeHourKey) ?? 23,
      wakeHour: preferences.getInt(wakeHourKey) ?? 7,
      reminderChoice: _reminderChoiceFromName(
        preferences.getString(reminderChoiceKey),
      ),
      reminderLeadMinutes: preferences.getInt(reminderLeadMinutesKey) ?? 30,
      healthPermissionStatus: _permissionStatusFromName(
        preferences.getString(healthPermissionStatusKey),
      ),
      reminderScheduled: preferences.getBool(reminderScheduledKey) ?? false,
    );
  }

  /// 保存本地草稿。
  Future<void> saveDraft(Ref ref, OnboardingActivationState state) async {
    final preferences = await ref.read(sharedPreferencesInstanceProvider.future);

    await preferences.setInt(currentStepKey, state.currentStep.index);

    final entryMode = state.entryMode;
    if (entryMode == null) {
      await preferences.remove(entryModeKey);
    } else {
      await preferences.setString(entryModeKey, entryMode.name);
    }

    final healthChoice = state.healthChoice;
    if (healthChoice == null) {
      await preferences.remove(healthChoiceKey);
    } else {
      await preferences.setString(healthChoiceKey, healthChoice.name);
    }

    await preferences.setInt(bedtimeHourKey, state.bedtimeHour);
    await preferences.setInt(wakeHourKey, state.wakeHour);
    await preferences.setString(reminderChoiceKey, state.reminderChoice.name);
    await preferences.setInt(
      reminderLeadMinutesKey,
      state.reminderLeadMinutes,
    );
    await preferences.setString(
      healthPermissionStatusKey,
      state.healthPermissionStatus.name,
    );
    await preferences.setBool(reminderScheduledKey, state.reminderScheduled);
  }

  OnboardingActivationStep _stepFromIndex(int? index) {
    if (index == null || index < 0 || index >= OnboardingActivationStep.values.length) {
      return OnboardingActivationStep.welcome;
    }

    return OnboardingActivationStep.values[index];
  }

  OnboardingEntryMode? _entryModeFromName(String? name) {
    return _enumFromName(OnboardingEntryMode.values, name);
  }

  OnboardingHealthChoice? _healthChoiceFromName(String? name) {
    return _enumFromName(OnboardingHealthChoice.values, name);
  }

  OnboardingReminderChoice _reminderChoiceFromName(String? name) {
    return _enumFromName(
          OnboardingReminderChoice.values,
          name,
        ) ??
        OnboardingReminderChoice.enabled;
  }

  AppPermissionStatus _permissionStatusFromName(String? name) {
    return _enumFromName(AppPermissionStatus.values, name) ??
        AppPermissionStatus.unknown;
  }

  T? _enumFromName<T extends Enum>(List<T> values, String? name) {
    if (name == null || name.isEmpty) {
      return null;
    }

    for (final value in values) {
      if (value.name == name) {
        return value;
      }
    }

    return null;
  }
}

/// 提供首次激活草稿状态存储适配器。
@Riverpod(keepAlive: true)
OnboardingActivationPreferencesStore onboardingActivationPreferencesStore(
  Ref ref,
) {
  return const OnboardingActivationPreferencesStore();
}
