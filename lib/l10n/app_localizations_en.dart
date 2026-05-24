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
  String get calendarHeroEyebrow => 'May still has rhythm';

  @override
  String get calendarHeroTitle =>
      'Color is not bad news. It is the distance between you and your target bedtime.';

  @override
  String get calendarHeroSubtitle =>
      'You stayed on track for 16 days this month, and drifted on 9 more.';

  @override
  String get calendarFilterMetGoal => 'On track';

  @override
  String get calendarFilterLate => 'Late drift';

  @override
  String get calendarFilterDataSource => 'Late count';

  @override
  String get calendarFilterAllDays => 'All days';

  @override
  String get calendarFilterOpen => 'Filter';

  @override
  String get calendarFilterSheetTitle => 'Filter calendar feedback';

  @override
  String get calendarFilterRecordedOnly => 'Only show recorded days';

  @override
  String get calendarFilterLateOnly => 'Only show late days';

  @override
  String calendarFilterLateCountSummary(int count) {
    return '$count late days';
  }

  @override
  String get calendarFilterReset => 'Reset filters';

  @override
  String get calendarFilterApply => 'Apply filters';

  @override
  String get calendarMetricOnTrack => 'On-track rate';

  @override
  String get calendarMetricLatestLate => 'Latest late night';

  @override
  String get calendarDetailSleepTime => 'Actual sleep time';

  @override
  String get calendarDetailWakeTime => 'Actual wake time';

  @override
  String get calendarDetailOffset => 'Offset';

  @override
  String get calendarDetailSource => 'Source and confidence';

  @override
  String get calendarDetailNoRecord =>
      'There is no explainable sleep record for this day yet.';

  @override
  String get calendarDetailTagsTitle => 'Reason tags';

  @override
  String get calendarDetailAddTag => 'Add tag';

  @override
  String get calendarDetailEditRecord => 'Edit last night';

  @override
  String get sleepDelayTagPickerTitle => 'Add a late-night reason';

  @override
  String get sleepDelayTagPickerSave => 'Save tags';

  @override
  String get sleepDelayTagPickerCustom => 'Custom tag';

  @override
  String get customDelayTagTitle => 'Add a custom reason';

  @override
  String get customDelayTagHint => 'Describe why you stayed up late';

  @override
  String get customDelayTagSave => 'Save custom tag';

  @override
  String get customDelayTagErrorEmpty => 'Enter a reason tag';

  @override
  String get customDelayTagErrorTooLong =>
      'Reason tags must be 12 characters or fewer';

  @override
  String get customDelayTagErrorDuplicate =>
      'This reason already exists in the default tags';

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
  String get insightsViewWeeklyReportButton => 'View full weekly report';

  @override
  String get insightsViewHistoryButton => 'View report history';

  @override
  String insightsWeeklyHeadline(int rate, int score, String weekday) {
    return 'Your on-track rate was $rate% over the last 7 days, with a stability score of $score. The latest night was on $weekday.';
  }

  @override
  String insightsWeeklyDescription(String reason) {
    return 'You have already narrowed the swings. Next, handle the most common trigger first: $reason.';
  }

  @override
  String get insightsOnTrackRateLabel => 'On-track rate';

  @override
  String get insightsStabilityLabel => 'Stability';

  @override
  String get insightsLatestLateTitle => 'Latest late night';

  @override
  String get insightsNextWeekAdviceTitle => 'Next week suggestions';

  @override
  String get insightsNoReasonTags => 'No reason tags yet';

  @override
  String get insightsNoWeeklyReport => 'No weekly report yet';

  @override
  String get insightsNoHistory => 'No insight history yet';

  @override
  String get insightsWeeklyReportPageTitle => 'This week report';

  @override
  String get insightsHistoryPageTitle => 'Insight history';

  @override
  String get insightsHistoryHeadline => 'Look back at long-term changes';

  @override
  String get insightsHistoryDescription =>
      'The last 30 days can be viewed directly. Older history hands off to membership here.';

  @override
  String get insightsHistoryPaywallTitle => 'Need a longer timeline?';

  @override
  String get insightsHistoryPaywallDescription =>
      'Membership unlocks older history, monthly reports, and a fuller recovery trail.';

  @override
  String get insightsHistoryUnlockButton => 'Unlock all insight history';

  @override
  String get insightsHistoryLocked => 'Outside the free range';

  @override
  String insightsHistorySummary(int rate, int score) {
    return 'On-track rate $rate% · Stability $score';
  }

  @override
  String insightsLatestLateSummary(String weekday, String time, int minutes) {
    return 'You fell asleep at $time on $weekday, which was $minutes minutes later than your target.';
  }

  @override
  String insightsLatestLateSummaryWithReasons(String base, String reasons) {
    return '$base The main reasons were $reasons.';
  }

  @override
  String get insightsStabilitySummaryInsufficient => 'Not enough samples yet';

  @override
  String get insightsStabilitySummarySteady => 'This week stayed very steady';

  @override
  String get insightsStabilitySummaryRecovering =>
      'This week was not worse. It was settling back down.';

  @override
  String get insightsStabilitySummaryNeedsRecovery =>
      'This week had obvious swings';

  @override
  String get insightsStabilityDescriptionInsufficient =>
      'At least 3 valid days are needed before a formal stability score can be shown.';

  @override
  String get insightsStabilityDescriptionSteady =>
      'Your bedtime offsets and swings were both small, so you can keep the current rhythm.';

  @override
  String get insightsStabilityDescriptionRecovering =>
      'There is still some drift, but the range is narrowing. Handle the frequent triggers first.';

  @override
  String get insightsStabilityDescriptionNeedsRecovery =>
      'The current drift is large enough that a 1 to 3 day recovery plan should come first.';

  @override
  String get insightsStabilityExplainerTitle => 'How stability is scored';

  @override
  String insightsStabilityScoreLabel(int score) {
    return 'Current score: $score';
  }

  @override
  String get insightsStabilitySampleHint =>
      'A formal stability score appears only after at least 3 valid days.';

  @override
  String get insightsRecoveryEffectTitle => 'Recovery effect';

  @override
  String get insightsRecoveryNoPlan =>
      'No recovery plan was triggered this week.';

  @override
  String insightsRecoveryPlanSummary(int days) {
    return 'After the latest obvious late night, use $days days to get bedtime back inside the threshold.';
  }

  @override
  String insightsRecoveryPlanTitle(int days) {
    return '$days-day recovery rhythm';
  }

  @override
  String get insightsRecoveryPlanDetailTitle => 'Recovery plan details';

  @override
  String insightsRecoveryStepLabel(int day, String title) {
    return 'Day $day · $title';
  }

  @override
  String get insightsRecoveryStepCloseWorkEarlierTitle =>
      'Pull tonight back first';

  @override
  String get insightsRecoveryStepCloseWorkEarlierDetail =>
      'Finish the last work or entertainment item 45 minutes before your target bedtime.';

  @override
  String get insightsRecoveryStepReduceNightNoiseTitle =>
      'Reduce the delay buffer';

  @override
  String get insightsRecoveryStepReduceNightNoiseDetail =>
      'Keep only one bedtime action tonight so the routine does not slip past the threshold again.';

  @override
  String get insightsRecoveryStepReviewLateTriggersTitle =>
      'Check whether you are back inside the threshold';

  @override
  String get insightsRecoveryStepReviewLateTriggersDetail =>
      'If tonight still runs late, review the late-night triggers and keep the most common one visible.';

  @override
  String get insightsRecommendationFinishWorkEarlier =>
      'Finish the last work task before 10:45 PM';

  @override
  String get insightsRecommendationEnableSoftReminder =>
      'Turn on the soft reminder first on higher-risk midweek days';

  @override
  String get insightsRecommendationOpenRecoveryPlan =>
      'If you run late for 2 days in a row, open the recovery plan immediately';

  @override
  String get insightsWeekdayMon => 'Mon';

  @override
  String get insightsWeekdayTue => 'Tue';

  @override
  String get insightsWeekdayWed => 'Wed';

  @override
  String get insightsWeekdayThu => 'Thu';

  @override
  String get insightsWeekdayFri => 'Fri';

  @override
  String get insightsWeekdaySat => 'Sat';

  @override
  String get insightsWeekdaySun => 'Sun';

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
  String get todayOpenSleepRecordsButton => 'Open sleep record management';

  @override
  String get todayGoalMissingTitle => 'Set a sleep goal first';

  @override
  String get todayGoalMissingPrimaryAction => 'Set your schedule goal';

  @override
  String get todayPermissionFailedTitle =>
      'Sleep data is temporarily unavailable';

  @override
  String get todayPermissionFailedPrimaryAction => 'Review permission help';

  @override
  String get todayEmptyTitle => 'There is no record from last night yet';

  @override
  String get todayEmptyPrimaryAction => 'Manually log last night';

  @override
  String get todayStatusSectionTitle => 'Last night';

  @override
  String get todayActionSectionTitle => 'Tonight action';

  @override
  String get todayTrendSectionTitle => 'Last 7 days';

  @override
  String get todayRecoverySectionTitle => 'Recovery suggestion';

  @override
  String get sleepRecordsHubTitle => 'Sleep record management';

  @override
  String get sleepRecordsHubSyncTitle => 'Last 30 days of sleep records';

  @override
  String get sleepRecordsHubSyncDescription =>
      'Automatic records speed things up. Manual entry is the fallback path.';

  @override
  String get sleepRecordsHubManualButton => 'Manual entry';

  @override
  String get sleepRecordsHubRetryButton => 'Retry sync';

  @override
  String get sleepRecordsHubInstallButton => 'Install Health Connect';

  @override
  String get sleepRecordsHubAuthorizeButton => 'Reauthorize';

  @override
  String get sleepRecordsHubManualModeButton => 'Use manual mode';

  @override
  String get sleepRecordsHubStatusIdle => 'Waiting to sync';

  @override
  String get sleepRecordsHubStatusIdleDescription =>
      'No sleep records have been pulled for the last 30 days yet. You can sync first or switch to manual entry.';

  @override
  String get sleepRecordsHubStatusSyncing => 'Syncing';

  @override
  String get sleepRecordsHubStatusSyncingDescription =>
      'Reading the last 30 days of sleep records. Please wait.';

  @override
  String get sleepRecordsHubStatusConnected => 'Health data connected';

  @override
  String sleepRecordsHubStatusConnectedDescription(int count) {
    return 'Saved $count sleep records from the last 30 days.';
  }

  @override
  String get sleepRecordsHubStatusInstallRequired =>
      'Health Connect is required';

  @override
  String get sleepRecordsHubStatusInstallRequiredDescription =>
      'Health Connect is not installed on this device yet. Install it to enable automatic sleep sync.';

  @override
  String get sleepRecordsHubStatusPermissionRequired =>
      'Sleep access is required';

  @override
  String get sleepRecordsHubStatusPermissionRequiredDescription =>
      'Sleep read permission has not been granted. Reauthorize to continue automatic sync.';

  @override
  String get sleepRecordsHubStatusUnavailable =>
      'Sleep sync is unavailable on this device';

  @override
  String get sleepRecordsHubStatusUnavailableDescription =>
      'You can still log last night manually and add automatic records later.';

  @override
  String get sleepRecordsHubStatusManualFallback => 'Manual entry is active';

  @override
  String get sleepRecordsHubStatusManualFallbackDescription =>
      'No usable sleep record was found. You can still confirm last night manually.';

  @override
  String get sleepRecordsHubStatusError => 'Sync failed';

  @override
  String get sleepRecordsHubStatusErrorDescription =>
      'This automatic sync did not complete. You can retry later or switch to manual entry now.';

  @override
  String get sleepRecordsHubLastSyncedTitle => 'Last synced';

  @override
  String get sleepRecordsHubFailureReasonTitle => 'Failure reason';

  @override
  String get sleepRecordsHubFailureReasonSyncFailed =>
      'Health data could not be read. Please try again later.';

  @override
  String get sleepRecordsHubFailureReasonPlatformUnavailable =>
      'Health data is not available on this device right now. Switch to manual entry first.';

  @override
  String get sleepRecordsHubFailureReasonGeneric =>
      'This sync did not complete. Please try again later.';

  @override
  String get sleepRecordsHubSourceTitle => 'Source and confidence';

  @override
  String get sleepRecordsHubSourceBulletOriginal =>
      '• Automatically synced records keep their original source';

  @override
  String get sleepRecordsHubSourceBulletManual =>
      '• Manual corrections do not overwrite raw records; they create a confirmed result';

  @override
  String get sleepRecordsHubSourceBulletFallback =>
      '• Today, Calendar, and reports still work without permission';

  @override
  String get sleepRecordsHubEmptyState => 'No confirmed sleep records yet';

  @override
  String get sleepRecordsHubLoadFailed => 'Failed to load sleep records';

  @override
  String get sleepRecordsHubManualRecordTitle => 'Manual sleep record';

  @override
  String get sleepRecordsHubHealthConnectRecordTitle => 'Health Connect record';

  @override
  String get sleepRecordsHubHealthKitRecordTitle => 'HealthKit record';

  @override
  String get sleepRecordsHubImportedRecordTitle => 'Imported record';

  @override
  String get manualSleepRecordPageTitle => 'Manual entry';

  @override
  String get manualSleepRecordPageSubtitle =>
      'Confirm last night’s sleep result manually';

  @override
  String get manualSleepRecordPageDescription =>
      'When automatic records are missing or inaccurate, you can manually log or correct sleep and wake times.';

  @override
  String get manualSleepRecordDateLabel => 'Record date';

  @override
  String get manualSleepRecordSleepTimeLabel => 'Sleep time';

  @override
  String get manualSleepRecordWakeTimeLabel => 'Wake time';

  @override
  String get manualSleepRecordDurationLabel => 'Duration';

  @override
  String get manualSleepRecordSourceLabel => 'Source';

  @override
  String get manualSleepRecordSourceValue => 'Manual correction';

  @override
  String get manualSleepRecordSaveButton => 'Save manual result';

  @override
  String get manualSleepRecordDiscardButton => 'Discard changes';

  @override
  String get manualSleepRecordHelperTitle => 'Correction notes';

  @override
  String get manualSleepRecordHelperDescription =>
      'The raw system record stays intact. What you save becomes the confirmed result shown first in Today and Calendar.';

  @override
  String get manualSleepRecordValidationSameTime =>
      'Sleep time and wake time cannot be the same.';

  @override
  String get manualSleepRecordEditTimeButton => 'Edit time';

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
  String get onboardingAuthTitle =>
      'Get the rhythm moving first; sign in only when sync is needed.';

  @override
  String get onboardingAuthDescription =>
      'Anonymous entry lowers first-run friction. Sign in is for device transfer and membership sync.';

  @override
  String get onboardingAuthAppleLabel => 'Local first';

  @override
  String get onboardingAuthAppleDescription => 'Data stays on this device';

  @override
  String get onboardingAuthGoogleLabel => 'Bind later';

  @override
  String get onboardingAuthGoogleDescription =>
      'You can still connect an account later';

  @override
  String get onboardingAuthAnonymousButton => 'Continue anonymously';

  @override
  String get onboardingAuthLaterButton => 'Use Apple';

  @override
  String get onboardingAuthGoogleButton => 'Use Google';

  @override
  String get onboardingStepThreeEyebrow => 'Step 3 / 3';

  @override
  String get onboardingHealthTitle => 'Read sleep data';

  @override
  String get onboardingHealthDescription =>
      'We only read sleep records and do not use them for medical judgment or ads.';

  @override
  String get onboardingHealthAppleSummary => 'Auto-sync sleep records';

  @override
  String get onboardingHealthGoogleSummary =>
      'The last 30 days will be written into the local rhythm timeline';

  @override
  String get onboardingHealthAnonymousSummary =>
      'Authorization failure can fall back';

  @override
  String get onboardingHealthDefaultSummary =>
      'Without permission, you can still manually log and generate weekly reports';

  @override
  String get onboardingHealthBenefitTitle => 'Why enable it';

  @override
  String get onboardingHealthBenefitDescription =>
      'Later health data access reduces manual logging and improves trend review continuity.';

  @override
  String get onboardingHealthCurrentStageTitle => 'Stage notes';

  @override
  String get onboardingHealthCurrentStageDescription =>
      'This task only completes the explanation flow and does not trigger a real system permission request.';

  @override
  String get onboardingHealthSkipButton => 'Use manual mode first';

  @override
  String get onboardingHealthAuthorizeButton => 'Authorize sleep data';

  @override
  String get goalSetupEyebrow => 'Set a doable target';

  @override
  String get goalSetupPageTitle =>
      'The target is a reference line, not a perfect daily red line.';

  @override
  String get goalSetupPageDescription =>
      'Start with a basic target, then adjust later anytime.';

  @override
  String get goalSetupContinueButton => 'Save goal and continue';

  @override
  String get goalSetupWorkdayTitle => 'Workday rule';

  @override
  String get goalSetupWorkdayWeekdays => 'Weekdays first';

  @override
  String get goalSetupWorkdayFlexible => 'Adjust later';

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
  String get reminderSetupEyebrow => 'Set reminders just right';

  @override
  String get reminderSetupPageTitle =>
      'Default to soft reminders and avoid nonstop interruption.';

  @override
  String get reminderSetupPageDescription =>
      'You can start light and decide later whether you need stronger on-time reminders.';

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
  String get reminderLeadHintTitle => 'Lead time suggestion';

  @override
  String get reminderLeadHintEarly => '15 min';

  @override
  String get reminderLeadHintRecommended => '30 min';

  @override
  String get reminderLeadHintMinimal => '45 min';

  @override
  String reminderLeadTimeValue(int minutes) {
    return '$minutes minutes before target bedtime';
  }

  @override
  String get bedtimePageTitle => 'Bedtime mode';

  @override
  String get bedtimeCountdownTitle => 'Tonight target';

  @override
  String bedtimeTargetDiffAhead(int minutes) {
    return '$minutes minutes until your target bedtime';
  }

  @override
  String bedtimeTargetDiffLate(int minutes) {
    return '$minutes minutes past your target bedtime';
  }

  @override
  String get bedtimeStatusTitle => 'How is tonight feeling?';

  @override
  String get bedtimeStatusReady => 'Ready to sleep';

  @override
  String get bedtimeStatusMoreTime => 'I want a bit more time';

  @override
  String get bedtimeStatusLikelyLate => 'I will probably sleep late tonight';

  @override
  String get bedtimeActionTitle => 'A lighter next step';

  @override
  String get bedtimeActionDimLights => 'Dim the lights a bit first';

  @override
  String get bedtimeActionPutPhoneAway => 'Put the phone away for now';

  @override
  String get bedtimeActionTenMinuteWrapUp =>
      'Give yourself 10 minutes to wrap up';

  @override
  String get bedtimeActionCloseTonight => 'Close tonight as soon as you can';

  @override
  String get bedtimeActionPlanRecoveryTomorrow =>
      'Plan a lighter recovery step for tomorrow morning';

  @override
  String get bedtimeGoalMissingTitle => 'Set tonight’s target first';

  @override
  String get bedtimeGoalMissingDescription =>
      'Bedtime mode needs your target schedule before it can calculate tonight’s countdown.';

  @override
  String get bedtimeGoalMissingButton => 'Set your schedule goal';
}
