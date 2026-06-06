import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/shared_preferences_provider.dart';
import '../../domain/repositories/reminder_preference_repository.dart';
import '../../infrastructure/repositories/local_reminder_preference_repository.dart';

part 'reminder_preference_repository_provider.g.dart';

/// 统一暴露提醒偏好仓储，让 onboarding 与 bedtime 共享同一持久化边界。
@Riverpod(keepAlive: true)
ReminderPreferenceRepository reminderPreferenceRepository(Ref ref) {
  final preferencesFuture = ref.watch(sharedPreferencesProvider.future);
  return LocalReminderPreferenceRepository(preferencesFuture);
}
