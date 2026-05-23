// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Rhythm';

  @override
  String get tabToday => 'Today';

  @override
  String get tabCalendar => 'Calendar';

  @override
  String get tabBedtime => 'Bedtime';

  @override
  String get tabInsights => 'Insights';

  @override
  String get tabProfile => 'Me';

  @override
  String get goalSetupTitle => 'Goal setup';

  @override
  String get goalSetupDescription =>
      'Goal setup will be implemented in Task 3. This page currently only receives the onboarding flow.';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get calendarDescription =>
      'Use a heatmap to understand your recent routine rhythm.';

  @override
  String get bedtimeTitle => 'Bedtime';

  @override
  String get bedtimeDescription =>
      'Enter bedtime mode and give tonight a gentler ending.';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsDescription =>
      'Review your week and find clues for a steadier routine.';

  @override
  String get profileTitle => 'Me';

  @override
  String get profileDescription =>
      'Manage goals, reminders, account, and privacy settings.';

  @override
  String get todayPageTitle => 'Today';

  @override
  String get todayCardTitle => 'Take it lighter tonight';

  @override
  String get todayCardDescription =>
      'After you set a target schedule, this area will show last night’s result and tonight’s action.';

  @override
  String get onboardingStepOneEyebrow => 'Step 1 / 3';

  @override
  String get onboardingWelcomeTitle => 'Welcome to Rhythm';

  @override
  String get onboardingWelcomeDescription =>
      'Starting tonight, build a steadier routine in a gentler way by finishing these 3 quick setup steps.';

  @override
  String get onboardingWelcomeChecklistTitle => 'You’ll complete';

  @override
  String get onboardingWelcomeBulletAuthTitle => 'Choose how to enter';

  @override
  String get onboardingWelcomeBulletAuthDescription =>
      'Anonymous mode is available now, and Apple / Google entry points stay ready for later integration.';

  @override
  String get onboardingWelcomeBulletHealthTitle =>
      'Understand health data value';

  @override
  String get onboardingWelcomeBulletHealthDescription =>
      'We explain the value first and keep real system permission requests out of this task.';

  @override
  String get onboardingWelcomeBulletGoalTitle => 'Set your target schedule';

  @override
  String get onboardingWelcomeBulletGoalDescription =>
      'This implementation now carries the flow into real goal and reminder setup instead of stopping at a placeholder.';

  @override
  String get onboardingWelcomePrimaryButton => 'Start setup';

  @override
  String get onboardingStepTwoEyebrow => 'Step 2 / 3';

  @override
  String get onboardingAuthTitle => 'Choose how you want to enter';

  @override
  String get onboardingAuthDescription =>
      'You can start anonymously now and decide later whether to connect an Apple or Google account.';

  @override
  String get onboardingAuthAppleLabel => 'Continue with Apple';

  @override
  String get onboardingAuthAppleDescription =>
      'Keep the designed account entry visible while leaving the real SDK integration for a later task.';

  @override
  String get onboardingAuthGoogleLabel => 'Continue with Google';

  @override
  String get onboardingAuthGoogleDescription =>
      'Show the intended flow option first, then connect the real login implementation later.';

  @override
  String get onboardingAuthAnonymousButton => 'Continue anonymously';

  @override
  String get onboardingAuthLaterButton => 'Connect later';

  @override
  String get onboardingStepThreeEyebrow => 'Step 3 / 3';

  @override
  String get onboardingHealthTitle => 'Connect health data for fuller records';

  @override
  String get onboardingHealthDescription =>
      'Rhythm will eventually use your existing sleep and activity data to help you review routine changes more steadily.';

  @override
  String get onboardingHealthAppleSummary =>
      'You just chose the Apple entry. You can finish account binding later.';

  @override
  String get onboardingHealthGoogleSummary =>
      'You just chose the Google entry. You can finish account binding later.';

  @override
  String get onboardingHealthAnonymousSummary =>
      'You are entering anonymously now and can still bind an account later in settings.';

  @override
  String get onboardingHealthDefaultSummary =>
      'You can first understand what health records help with before deciding whether to authorize.';

  @override
  String get onboardingHealthBenefitTitle => 'Why it helps';

  @override
  String get onboardingHealthBenefitDescription =>
      'Once health data is connected in a later task, you can reduce manual logging and review trends with better continuity.';

  @override
  String get onboardingHealthCurrentStageTitle => 'What happens in this stage';

  @override
  String get onboardingHealthCurrentStageDescription =>
      'This task only completes the explanation flow and does not trigger a real system permission request.';

  @override
  String get onboardingHealthSkipButton => 'Use manual mode first';

  @override
  String get onboardingHealthAuthorizeButton => 'Authorize and continue';

  @override
  String get goalSetupEyebrow => 'Goal setup';

  @override
  String get goalSetupPageTitle => 'Set your target routine';

  @override
  String get goalSetupPageDescription =>
      'This MVP keeps the form lightweight and locks the first target schedule before reminder preferences are confirmed.';

  @override
  String get goalSetupContinueButton => 'Save goal and continue';

  @override
  String get goalScheduleBedtimeLabel => 'Target bedtime';

  @override
  String get goalScheduleBedtimeDescription =>
      'This is the sleep time Rhythm will use as the baseline for recovery suggestions.';

  @override
  String get goalScheduleWakeLabel => 'Target wake time';

  @override
  String get goalScheduleWakeDescription =>
      'Keep a clear gap from your bedtime so the target window remains meaningful.';

  @override
  String get goalScheduleLateThresholdLabel => 'Late threshold';

  @override
  String get goalScheduleLateThresholdDescription =>
      'Used later to decide when a night counts as staying up late.';

  @override
  String get goalScheduleDayStartLabel => 'Day start';

  @override
  String get goalScheduleDayStartDescription =>
      'Used later to group logs that cross midnight into the same day boundary.';

  @override
  String get goalScheduleWakeSameAsBedtimeError =>
      'Wake time cannot be the same as target bedtime.';

  @override
  String goalScheduleMinutesValue(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get reminderSetupEyebrow => 'Reminder setup';

  @override
  String get reminderSetupPageTitle => 'Choose your reminder strategy';

  @override
  String get reminderSetupPageDescription =>
      'Finish the first-run setup by confirming how gentle nudges should support your target schedule.';

  @override
  String get reminderSetupCompleteButton => 'Finish setup and open Today';

  @override
  String get reminderSoftReminderTitle => 'Soft reminder';

  @override
  String get reminderSoftReminderDescription =>
      'A low-pressure nudge before you drift too far from tonight’s plan.';

  @override
  String get reminderTargetReminderTitle => 'On-time reminder';

  @override
  String get reminderTargetReminderDescription =>
      'A stronger reminder when it is time to start winding down.';

  @override
  String get reminderWeeklyReportTitle => 'Weekly recap';

  @override
  String get reminderWeeklyReportDescription =>
      'A weekly summary that helps you review whether the routine is becoming steadier.';

  @override
  String get reminderLeadTimeTitle => 'Reminder lead time';

  @override
  String reminderLeadTimeValue(int minutes) {
    return '$minutes minutes before target bedtime';
  }
}
