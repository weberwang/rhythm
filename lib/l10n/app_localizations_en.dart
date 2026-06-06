// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rhythm';

  @override
  String get launchLoadingTitle => 'Preparing your rhythm';

  @override
  String get launchLoadingBody =>
      'Bootstrapping the local-first baseline and route host.';

  @override
  String get launchErrorTitle => 'Startup needs attention';

  @override
  String get launchErrorBody =>
      'The initialization baseline could not be prepared. Try again.';

  @override
  String get retry => 'Retry';

  @override
  String get onboardingTitle => 'Onboarding activation';

  @override
  String get onboardingBody =>
      'Initialization keeps the onboarding route ready, but the full activation flow will be implemented in the next stage.';

  @override
  String get onboardingContinue => 'Enter app shell';

  @override
  String onboardingStepCounter(int current, int total) {
    return 'Step $current / $total';
  }

  @override
  String get onboardingWelcomeTitle => 'Welcome to Rhythm';

  @override
  String get onboardingWelcomeBody =>
      'Starting tonight, we will help you rebuild a steadier sleep rhythm through a short guided setup.';

  @override
  String get onboardingEntryTitle => 'Choose how to begin';

  @override
  String get onboardingEntryBody =>
      'Finish the local-first setup first, then decide when to connect sign-in and health permissions.';

  @override
  String get onboardingPermissionTitle => 'Understand the value first';

  @override
  String get onboardingPermissionBody =>
      'We will explain what health access can unlock before asking for any real system permission.';

  @override
  String get onboardingGoalTitle => 'Set your target schedule';

  @override
  String get onboardingGoalBody =>
      'Pick the bedtime and wake-up target you want Rhythm to guide you toward first.';

  @override
  String get onboardingReminderTitle => 'Choose your reminder posture';

  @override
  String get onboardingReminderBody =>
      'Start with the gentlest reminder strategy that still feels realistic for tonight.';

  @override
  String get onboardingWidgetGuideTitle =>
      'Put Rhythm on your home screen for tonight';

  @override
  String get onboardingWidgetGuideBody =>
      'A home-screen entry is optional, but it makes it faster to return to the key actions tonight and tomorrow morning.';

  @override
  String get onboardingWidgetGuideBaseTitle =>
      'This step only explains the value, not a forced setup';

  @override
  String get onboardingWidgetGuideBaseBody =>
      'Finish tonight first, then decide later whether your device should pin Rhythm to the home screen.';

  @override
  String get onboardingWidgetGuideSupportedTitle =>
      'This device can pin the entry directly';

  @override
  String get onboardingWidgetGuideSupportedBody =>
      'When you are ready, you can pin Rhythm to the home screen or widget panel so the next return takes less effort.';

  @override
  String get onboardingWidgetGuideManualTitle =>
      'This platform works better with manual setup later';

  @override
  String get onboardingWidgetGuideManualBody =>
      'Finish activation first. After that, add the Rhythm widget from your home-screen edit mode when you want faster access.';

  @override
  String get onboardingWidgetGuideUnavailableTitle =>
      'This device does not support home-screen widgets right now';

  @override
  String get onboardingWidgetGuideUnavailableBody =>
      'That does not block the setup tonight. Add a widget later when you return on a supported mobile device.';

  @override
  String get onboardingCompletionTitle => 'You are ready for tonight';

  @override
  String get onboardingCompletionBody =>
      'Rhythm has enough context to start the first night without forcing extra setup right now.';

  @override
  String get onboardingStartSetup => 'Start setup';

  @override
  String get onboardingContinueSetup => 'Continue';

  @override
  String get onboardingFinishSetup => 'Finish setup';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboardingBenefitReminderTitle => 'Gentle bedtime reminders';

  @override
  String get onboardingBenefitReminderBody =>
      'Build a calmer transition into night without turning reminders into pressure.';

  @override
  String get onboardingBenefitRoutineTitle => 'Wind-down routines that stick';

  @override
  String get onboardingBenefitRoutineBody =>
      'Keep the setup lightweight so your routine feels repeatable, not overwhelming.';

  @override
  String get onboardingBenefitTrackingTitle => 'Track sleep without the stress';

  @override
  String get onboardingBenefitTrackingBody =>
      'Start with clear goals first, then connect richer data when you are ready.';

  @override
  String get onboardingEntryLocalTitle => 'Start in local-first mode';

  @override
  String get onboardingEntryLocalBody =>
      'Use Rhythm right away on this device and keep the activation flow simple tonight.';

  @override
  String get onboardingEntryAppleTitle => 'Continue with Apple';

  @override
  String get onboardingEntryAppleBody =>
      'Bring your Apple identity into onboarding first, then continue with health access, goal schedule, and sync semantics.';

  @override
  String get onboardingEntryGoogleTitle => 'Continue with Google';

  @override
  String get onboardingEntryGoogleBody =>
      'Bring your Google identity into onboarding first, then continue with health access, goal schedule, and sync semantics.';

  @override
  String get onboardingEntryAuthCancelledTitle => 'This sign-in was cancelled';

  @override
  String get onboardingEntryAuthCancelledBody =>
      'Try again, or switch to the local-first path and finish the setup tonight first.';

  @override
  String get onboardingEntryAuthUnavailableTitle =>
      'This sign-in path is unavailable on this device';

  @override
  String get onboardingEntryAuthUnavailableBody =>
      'Switch to the local-first path for tonight, then connect your account later on a supported platform.';

  @override
  String get onboardingEntryAuthFailedTitle => 'Sign-in could not finish';

  @override
  String get onboardingEntryAuthFailedBody =>
      'Try once more. If the environment still is not ready, continue with the local-first path for now.';

  @override
  String get onboardingHealthValueTitle =>
      'Health access stays optional for now';

  @override
  String get onboardingHealthValueBody =>
      'This step explains what health data can unlock, but it will not request real system permission yet.';

  @override
  String get onboardingPermissionBenefitTitle =>
      'What health access can unlock';

  @override
  String get onboardingPermissionBenefitBody =>
      'It can improve sleep history, confidence labels, and future insights when you decide to connect it.';

  @override
  String get onboardingPermissionPrivacyTitle =>
      'What Rhythm does not read by default';

  @override
  String get onboardingPermissionPrivacyBody =>
      'This activation pass does not request real permission yet, and it does not block local-first setup.';

  @override
  String get onboardingPermissionFallbackTitle =>
      'You can still start manually';

  @override
  String get onboardingPermissionFallbackBody =>
      'If you skip health access later, Rhythm will keep working with your manual bedtime goal and follow-up actions.';

  @override
  String get onboardingBedtimeLabel => 'Target bedtime';

  @override
  String get onboardingWakeTimeLabel => 'Target wake-up time';

  @override
  String get onboardingGoalHint =>
      'You can refine this later in settings. The goal here is to leave onboarding with one realistic starting rhythm.';

  @override
  String get onboardingReminderGentleTitle => 'Gentle bedtime nudge';

  @override
  String get onboardingReminderGentleBody =>
      'Start with a softer reminder posture that encourages action without adding pressure.';

  @override
  String get onboardingReminderNoneTitle => 'No active reminder yet';

  @override
  String get onboardingReminderNoneBody =>
      'Finish activation first and decide on reminder timing later in settings.';

  @override
  String get onboardingCompletionSummaryTitle =>
      'Your first-night setup is ready';

  @override
  String get onboardingCompletionSummaryBody =>
      'We will carry this starting rhythm into the app shell, and you can refine the rest after onboarding.';

  @override
  String get onboardingCompletionScheduleLabel => 'Target schedule';

  @override
  String onboardingCompletionScheduleValue(Object bedtime, Object wakeTime) {
    return '$bedtime to $wakeTime';
  }

  @override
  String get onboardingCompletionEntryLabel => 'Entry mode';

  @override
  String get onboardingCompletionReminderLabel => 'Reminder strategy';

  @override
  String get onboardingCompletionHealthLabel => 'Health access';

  @override
  String get onboardingPermissionStatusGranted => 'Granted';

  @override
  String get onboardingPermissionStatusDeferred => 'Decide later';

  @override
  String get onboardingPermissionStatusUnavailable =>
      'Unsupported on this device';

  @override
  String get tabToday => 'Today';

  @override
  String get tabBedtime => 'Bedtime';

  @override
  String get tabCalendar => 'Calendar';

  @override
  String get tabInsights => 'Insights';

  @override
  String get tabProfile => 'Profile';

  @override
  String get placeholderStatus => 'Initialization placeholder';

  @override
  String get todayTitle => 'Today';

  @override
  String get todayBody =>
      'The Today dashboard will consume sleep-data-core contracts in the implementation stage.';

  @override
  String todayGreetingNamed(Object name) {
    return 'Good morning, $name';
  }

  @override
  String get todayGreetingGeneric =>
      'Good morning, start with the rhythm for tonight';

  @override
  String get todayGreetingBody =>
      'Look at last night first, then decide what to do tonight.';

  @override
  String get todaySectionLastNight => 'Last night';

  @override
  String get todayLastNightNoDataTitle =>
      'Last night is still waiting for the first sample';

  @override
  String get todayLastNightNoDataBody =>
      'Onboarding is complete. Once tonight is recorded, this card will explain the result, source confidence, and your next step first.';

  @override
  String get todayLastNightSyncTitle =>
      'The local result is safe, and sync can wait';

  @override
  String get todayLastNightSyncBody =>
      'Sync did not finish cleanly, but your latest updates are still safe on this device. Keep tonight on track first.';

  @override
  String get todayLastNightManualTitle =>
      'This result now follows a manual adjustment';

  @override
  String get todayLastNightManualBody =>
      'Rhythm will respect your latest manual correction and use it as the baseline for the explanation tonight.';

  @override
  String get todayLastNightOnTargetTitle =>
      'Last night stayed close to the target';

  @override
  String get todayLastNightOnTargetBody =>
      'The rhythm was basically on track. Keep tonight steady and avoid over-correcting a night that already landed well.';

  @override
  String get todayLastNightSlightDelayTitle =>
      'Last night drifted a little later than planned';

  @override
  String get todayLastNightSlightDelayBody =>
      'The delay is still manageable. Tighten tonight\'s wind-down and keep the next wake-up anchored.';

  @override
  String get todayLastNightMajorDelayTitle =>
      'Last night drifted far beyond the target';

  @override
  String get todayLastNightMajorDelayBody =>
      'Treat tonight as a recovery night: lower stimulation earlier and keep the next morning from sliding later again.';

  @override
  String get todaySectionTonightGoal => 'Goal for tonight';

  @override
  String get todayTonightGoalHeadline => 'Bedtime target';

  @override
  String get todayTonightGoalReminderLabel => 'Wind-down reminder';

  @override
  String todayTonightGoalBody(Object windDown, Object wakeTime) {
    return 'Start winding down at $windDown, and keep the wake-up target at $wakeTime.';
  }

  @override
  String get todaySectionRecovery => 'Recovery suggestion';

  @override
  String get todayRecoveryBuildBaselineTitle =>
      'Start by completing the first night';

  @override
  String get todayRecoveryBuildBaselineBody =>
      'Finish the routine tonight first, then come back tomorrow morning for the first result and a clearer recovery suggestion.';

  @override
  String get todayRecoverySyncTitle =>
      'Stay on the local rhythm first, repair sync later';

  @override
  String get todayRecoverySyncBody =>
      'The important part right now is preserving the rhythm tonight, not interrupting the local record flow for a sync repair.';

  @override
  String get todayRecoveryDelayTitle =>
      'Use tonight to pull the rhythm back earlier';

  @override
  String get todayRecoveryDelayBody =>
      'Keep the next wind-down short and decisive, and avoid compensating by sleeping much later tomorrow morning.';

  @override
  String get todayRecoveryMomentumTitle =>
      'Protect the corrected rhythm tonight';

  @override
  String get todayRecoveryMomentumBody =>
      'Since the result was adjusted manually, keep tonight aligned with that corrected baseline instead of adding more corrective tasks.';

  @override
  String get todaySectionQuickRecord => 'Quick record';

  @override
  String get todayQuickRecordTitle => 'Log the check-in for tonight';

  @override
  String get todayQuickRecordRecommendedBody =>
      'If tonight drifts from the goal, add a quick mood, energy, or note so the explanation tomorrow has context.';

  @override
  String get todayQuickRecordOptionalBody =>
      'If anything feels worth noting tonight, add a short check-in so the first-week trend can build with context.';

  @override
  String get todayQuickRecordSheetTitle => 'Add last night\'s record';

  @override
  String get todayQuickRecordSheetBody =>
      'Capture the minimum facts first so the result card and the first-week trend stop falling back to placeholders.';

  @override
  String get todayQuickRecordDateLabel => 'Sleep date';

  @override
  String get todayQuickRecordBedtimeLabel => 'Fell asleep at';

  @override
  String get todayQuickRecordWakeTimeLabel => 'Woke up at';

  @override
  String get todayQuickRecordNoteLabel => 'Note (optional)';

  @override
  String get todayQuickRecordSaveAction => 'Save record';

  @override
  String get todayQuickRecordSaved => 'Last night\'s record was saved.';

  @override
  String get todaySectionTrend => '7-day trend';

  @override
  String get todayTrendScoreLabel => 'Sleep score';

  @override
  String get todayTrendBuildingTitle =>
      'The 7-day trend starts building tonight';

  @override
  String get todayTrendBuildingBody =>
      'During the first week, this section focuses on context and explainability instead of competing with the primary home-page judgment.';

  @override
  String get todayTrendReadyBody =>
      'The chart is now using your recent samples, so you can quickly judge whether the rhythm is pulling back toward the target.';

  @override
  String get todayFooterHint =>
      'Today currently consumes the shipped goal schedule, shared status, and account snapshot baseline. Real sleep-record wiring will follow in a later module pass.';

  @override
  String get todayErrorTitle =>
      'The today snapshot could not be restored just now';

  @override
  String get todayErrorBody =>
      'The shell is still usable. Rhythm will try to rebuild the home-page snapshot the next time you return here.';

  @override
  String get bedtimeTitle => 'Bedtime';

  @override
  String get bedtimeBody =>
      'The bedtime focus flow is scaffolded and waiting for module implementation.';

  @override
  String get bedtimeEntryFromToday => 'From today';

  @override
  String get bedtimeEntryFromNotification => 'From notification';

  @override
  String get bedtimeEntryFromWidget => 'From widget';

  @override
  String bedtimeBeforeTargetHeadline(Object minutes) {
    return '$minutes minutes until the target';
  }

  @override
  String bedtimeAfterTargetHeadline(Object minutes) {
    return '$minutes minutes past the target';
  }

  @override
  String get bedtimeCompletedHeadline => 'Tonight\'s wind-down is done';

  @override
  String bedtimeBeforeTargetBody(Object bedtime) {
    return 'Pull the focus back to one decision tonight. The target bedtime is $bedtime.';
  }

  @override
  String bedtimeDelayBody(Object wakeTime) {
    return 'Tonight is about limiting the drift first. Keep tomorrow\'s wake-up target at $wakeTime.';
  }

  @override
  String bedtimeCompletedBody(Object wakeTime) {
    return 'Keep the wake-up target at $wakeTime tomorrow morning. No extra tasks need to pile on now.';
  }

  @override
  String get bedtimeTargetBedtimeLabel => 'Target bedtime';

  @override
  String get bedtimeTargetWakeLabel => 'Target wake-up';

  @override
  String get bedtimeChoiceSectionTitle => 'What is the best call for tonight?';

  @override
  String get bedtimeChoiceReadyTitle => 'Ready to sleep';

  @override
  String get bedtimeChoiceReadyBody =>
      'Do not open new tasks. Move straight into the smallest wind-down action.';

  @override
  String get bedtimeChoiceWindDownTitle => 'Need a little wind-down';

  @override
  String get bedtimeChoiceWindDownBody =>
      'Give yourself a short buffer, but do not reopen another stimulating task.';

  @override
  String get bedtimeChoiceDelayTitle => 'Tonight will likely drift late';

  @override
  String get bedtimeChoiceDelayBody =>
      'Acknowledge the drift, then reduce the damage for tomorrow morning and the next recovery step.';

  @override
  String get bedtimeActionSectionTitle => 'Tonight\'s action';

  @override
  String get bedtimeActionStartWindDownTitle => 'Start a 10-minute wind-down';

  @override
  String get bedtimeActionStartWindDownBody =>
      'The most important thing now is to turn off stimulation and give yourself one short closing window.';

  @override
  String get bedtimeActionPutPhoneAwayTitle =>
      'Put the phone away for 10 minutes';

  @override
  String get bedtimeActionPutPhoneAwayBody =>
      'Push the screen and unfinished tasks back for 10 minutes so the body can actually start relaxing.';

  @override
  String get bedtimeActionProtectWakeTitle =>
      'Protect tomorrow\'s wake-up time first';

  @override
  String get bedtimeActionProtectWakeBody =>
      'Limit the damage tonight instead of trying to fix everything. Protecting the wake-up time matters more than dragging the night longer.';

  @override
  String get bedtimeActionCompletedTitle => 'Tonight\'s action is done';

  @override
  String get bedtimeActionCompletedBody =>
      'When you come back tomorrow morning, Rhythm will use last night\'s result to continue the explanation.';

  @override
  String bedtimeReminderEnabledBody(Object bedtime) {
    return 'Reminders are on, and tonight will keep nudging you around the $bedtime target.';
  }

  @override
  String get bedtimePrimaryActionLabel => 'Do this step';

  @override
  String get bedtimePrimaryActionCompleted => 'Tonight is already done';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get calendarBody =>
      'Calendar heatmap and day detail experiences will be connected after the data contracts land.';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsBody =>
      'Weekly reports and premium insight widgets are reserved but not implemented yet.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileBody =>
      'Account, membership, sync, reminder, and privacy settings will be implemented after initialization.';

  @override
  String get profileAccountAnonymousTitle =>
      'You are currently in local-first mode';

  @override
  String get profileAccountAnonymousBody =>
      'Tonight updates stay on this device first. You can connect an account and enable sync later.';

  @override
  String profileAccountConnectedTitle(Object provider) {
    return '$provider account connected';
  }

  @override
  String get profileAccountConnectedBody =>
      'Your account snapshot is already stored on this device, and sync, membership, and privacy settings can build on it next.';

  @override
  String get profileAccountLoadFallbackBody =>
      'Account state could not be restored just now, so settings will stay in the local-first path for now.';

  @override
  String get accountProviderAppleLabel => 'Apple';

  @override
  String get accountProviderGoogleLabel => 'Google';

  @override
  String get globalFeedbackDismiss => 'Dismiss';

  @override
  String get globalFeedbackSyncFailedTitle => 'Sync paused locally';

  @override
  String get globalFeedbackSyncFailedBody =>
      'Your recent updates are still stored on this device. Review sync settings when you are ready.';

  @override
  String get globalFeedbackTimezoneShiftTitle => 'Timezone confirmation needed';

  @override
  String get globalFeedbackTimezoneShiftBody =>
      'Rhythm will pause sleep interpretation until you confirm the current timezone context.';
}
