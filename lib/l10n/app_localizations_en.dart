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
  String get onboardingEntrySyncLaterTitle => 'Set up now, sync later';

  @override
  String get onboardingEntrySyncLaterBody =>
      'Finish the same setup first, then come back for Apple / Google sign-in when needed.';

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
  String get bedtimeTitle => 'Bedtime';

  @override
  String get bedtimeBody =>
      'The bedtime focus flow is scaffolded and waiting for module implementation.';

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
