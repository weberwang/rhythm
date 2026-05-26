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
  String calendarHeroSubtitle(int onTrackDays, int driftDays) {
    return 'You stayed on track for $onTrackDays days this month, and drifted on $driftDays more.';
  }

  @override
  String get calendarHeroSubtitleEmpty =>
      'There is no usable rhythm sample this month yet. Log a few days first, then come back to review the trend.';

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
  String get calendarFilterOpenSemantics => 'Open filters';

  @override
  String get calendarFilterOpenActiveSemantics =>
      'Open filters, filters are active';

  @override
  String get calendarFilterSheetTitle => 'Filter calendar feedback';

  @override
  String get calendarFilterRecordedOnly => 'Only show recorded days';

  @override
  String get calendarFilterLateOnly => 'Only show late days';

  @override
  String get calendarFilterSummaryRecorded => 'Recorded only';

  @override
  String get calendarFilterSummaryLateOnly => 'Late only';

  @override
  String calendarFilterSummaryAppliedCount(int count) {
    return '$count filters on';
  }

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
  String calendarDetailOffsetValue(int minutes) {
    return '$minutes minutes';
  }

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
  String get insightsReasonDistributionTitle => 'Main late-night reasons';

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
  String get membershipCenterPageTitle => 'Membership center';

  @override
  String get membershipCenterHeroTitle =>
      'Connect the long-term improvement layer';

  @override
  String get membershipCenterHeroDescription =>
      'Membership does not replace the core loop. It makes causes and recovery paths easier to understand.';

  @override
  String get membershipStatusFree => 'Free plan';

  @override
  String get membershipStatusTrial => 'Trial active';

  @override
  String get membershipStatusMonthly => 'Monthly membership active';

  @override
  String get membershipStatusAnnual => 'Annual membership active';

  @override
  String get membershipStatusLifetime => 'Lifetime membership active';

  @override
  String get membershipStatusDescription =>
      'After upgrading, you can view recovery plan details, long-term history, stability explanations, and richer widgets.';

  @override
  String get membershipPlanMonthly => 'Monthly';

  @override
  String get membershipPlanAnnual => 'Annual';

  @override
  String get membershipPlanLifetime => 'Lifetime';

  @override
  String get membershipPlanTrial => 'Trial';

  @override
  String get membershipPlanFree => 'Free';

  @override
  String get membershipPlanTryBadge => 'Try first';

  @override
  String get membershipPlanRecommendedBadge => 'Recommended';

  @override
  String get membershipBenefitRecoveryDetail => 'Full recovery plan details';

  @override
  String get membershipBenefitStabilityExplainer =>
      'Stability score explanations';

  @override
  String get membershipBenefitHistoryMonthly =>
      'History older than 30 days and monthly reports';

  @override
  String get membershipBenefitRestoreSync => 'Purchase restore and device sync';

  @override
  String get membershipBenefitsSheetTitle => 'Membership benefits';

  @override
  String get membershipBenefitsSheetDescription =>
      'Opened from Insights or Profile to explain the boundary between the free and membership plans.';

  @override
  String get membershipBenefitRecoveryShort => 'Recovery plan';

  @override
  String get membershipBenefitHistoryShort => 'Long-term history';

  @override
  String get membershipBenefitMonthlyShort => 'Monthly reports';

  @override
  String get membershipPrimaryActionAnnual => 'Start annual membership';

  @override
  String get membershipPrimaryActionMonthly => 'Start monthly membership';

  @override
  String get membershipPrimaryActionLifetime => 'Start lifetime membership';

  @override
  String get membershipPrimaryActionManage => 'Manage current membership';

  @override
  String get membershipViewBenefitsButton => 'View benefits';

  @override
  String get membershipRestoreButton => 'Restore purchases';

  @override
  String get paywallHeroBadge => 'Unlock the improvement layer too';

  @override
  String get paywallHeroTitle =>
      'The free plan gives you results. Membership connects recovery plans, stability explanations, and long-term history.';

  @override
  String get paywallHeroDescription =>
      'It never hard-blocks first-run. It appears only when you truly want deeper help.';

  @override
  String get paywallHintTitle => 'Membership capability';

  @override
  String get paywallHintDescription =>
      'Recovery plan details are a membership capability, but the free loop can still continue.';

  @override
  String get paywallBenefitRecoveryDetail => 'Recovery plan details';

  @override
  String get paywallBenefitStabilityExplainer =>
      'Detailed stability explanation';

  @override
  String get paywallBenefitHistoryMonthly =>
      'History older than 30 days and monthly reports';

  @override
  String get paywallBenefitWidgetSync => 'Richer widgets and cross-device sync';

  @override
  String get paywallPrimaryActionAnnual => 'Start annual membership';

  @override
  String get paywallPrimaryActionMonthly => 'Start monthly membership';

  @override
  String get paywallPrimaryActionLifetime => 'Start lifetime membership';

  @override
  String get paywallPrimaryActionTrial => 'Start trial';

  @override
  String get paywallContinueFreeButton => 'Keep using free plan';

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
  String get todayQuickActionsTitle => 'Quick log';

  @override
  String get todayQuickActionManualButton => 'Manually log';

  @override
  String get todayQuickActionEditButton => 'Edit last night';

  @override
  String get todayQuickActionOpenHubButton => 'Open record hub';

  @override
  String get todayRecoveryDescription =>
      'Pull the latest task forward tonight so tomorrow has a little more room to settle back.';

  @override
  String get todayTrendEmptyState =>
      'Build a few more days to reveal the trend';

  @override
  String get todayStatusUserConfirmed => 'Confirmed by you';

  @override
  String get todayStatusGoalMet => 'Last night stayed near target';

  @override
  String todayStatusLateBy(int minutes) {
    return 'Late by $minutes minutes';
  }

  @override
  String get todayStatusWithinThreshold => 'Still inside the threshold';

  @override
  String todayStatusEarlyBy(int minutes) {
    return '$minutes minutes earlier than target';
  }

  @override
  String todayStatusLateDetail(int minutes) {
    return '$minutes minutes later than target';
  }

  @override
  String get todayActionEnterBedtimeMode => 'Enter bedtime mode';

  @override
  String get todayActionManualRecord => 'Manually log last night';

  @override
  String get todayActionPermissionHelp => 'Review permission help';

  @override
  String get todayActionGoalSetup => 'Set your schedule goal';

  @override
  String get todayActionRecoveryPlan => 'View recovery suggestions';

  @override
  String todayActionTargetBedtime(String time) {
    return 'Tonight target $time';
  }

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
  String get bedtimeCurrentTimeLabel => 'Now';

  @override
  String get bedtimeTargetTimeLabel => 'Target';

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

  @override
  String get commonCancelButton => 'Cancel';

  @override
  String get commonConfirmButton => 'Confirm';

  @override
  String get accountSyncPageTitle => 'Keep it local first, sync later';

  @override
  String get accountSyncPageDescription =>
      'Sign-in is for restoring across devices, keeping membership in sync, and recovering your session later.';

  @override
  String get accountSyncCurrentIdentityTitle => 'Current identity';

  @override
  String get accountSyncSyncStatusTitle => 'Sync status';

  @override
  String get accountSyncConflictPolicyTitle => 'Conflict policy';

  @override
  String get accountSyncConflictPolicyDescription =>
      'Manual changes made by you take priority, while source and update time are still preserved.';

  @override
  String get accountSyncIdentityAnonymousTitle => 'Anonymous user';

  @override
  String get accountSyncIdentityAnonymousDescription =>
      'Local-first mode is active. You can bind an account any time.';

  @override
  String get accountSyncIdentitySignInRequiredDescription =>
      'Local-first mode is active. Sign in when you are ready to restore multi-device sync.';

  @override
  String get accountSyncIdentityLinkedFallbackTitle => 'Account linked';

  @override
  String get accountSyncIdentityLinkedDescription =>
      'Your account is linked and the cloud session can be restored later.';

  @override
  String get accountSyncIdentityConnectedDescription =>
      'Your account is linked and the cloud session is active.';

  @override
  String get accountSyncBindAppleButton => 'Link Apple account';

  @override
  String get accountSyncViewAccountButton => 'View account status';

  @override
  String get accountSyncCloudIdentityPendingTitle =>
      'Cloud sync identity is not ready yet';

  @override
  String get accountSyncCloudIdentityReadyTitle =>
      'Cloud sync identity is ready';

  @override
  String get accountSyncCloudIdentityPendingButton =>
      'Create cloud sync identity';

  @override
  String get accountSyncCloudIdentityReadyButton =>
      'Cloud sync identity is ready';

  @override
  String get accountSyncLocalOnlyDescription =>
      'This build is staying in local-first mode right now, so no cloud sync has been triggered.';

  @override
  String get accountSyncSignInRequiredDescription =>
      'Cloud sync starts only after sign-in. Your current device data will stay here until then.';

  @override
  String get accountSyncFailedDescription =>
      'The latest cloud sync failed. You can retry later and keep using local data for now.';

  @override
  String get accountSyncSyncedDescription => 'Cloud sync is enabled';

  @override
  String get accountSyncRetryButton => 'Retry sync';

  @override
  String get accountSyncLastSyncedLabel => 'Last synced: ';

  @override
  String get accountSyncUnavailableError =>
      'Account and sync status is temporarily unavailable';

  @override
  String get profileHeroAnonymousTitle => 'Anonymous user';

  @override
  String get profileHeroAnonymousSubtitle =>
      'Local first ? You can bind an account later';

  @override
  String get profileHeroBadgeLabel => 'Free plan';

  @override
  String get profileMembershipEntryTitle => 'Membership center';

  @override
  String get profileMembershipEntrySubtitle =>
      'Unlock recovery plan details, long-term history, and monthly reports';

  @override
  String get profileGoalScheduleEntryTitle => 'Goal schedule settings';

  @override
  String get profileGoalScheduleEntryEmpty =>
      'You have not saved a goal schedule yet';

  @override
  String get profileGoalScheduleEntryLoading => 'Loading your goal schedule';

  @override
  String get profileGoalScheduleEntryError =>
      'Goal schedule is temporarily unavailable';

  @override
  String get profileNotificationEntryTitle => 'Reminder settings';

  @override
  String get profileNotificationEntryEnabled => 'Soft reminders are enabled';

  @override
  String get profileNotificationEntryDisabled =>
      'Reminder strategy still needs adjustment';

  @override
  String get profileDataAccessEntryTitle => 'Data access and permissions';

  @override
  String get profileDataAccessEntryLoading => 'Loading access status';

  @override
  String get profileDataAccessEntryError =>
      'Access status is temporarily unavailable';

  @override
  String get profileTimezoneModeEntryTitle => 'Timezone and special modes';

  @override
  String profileTimezoneModeEntrySubtitle(String timezone) {
    return '$timezone · Record timing and special cases';
  }

  @override
  String get profilePrivacyEntryTitle => 'Privacy and data';

  @override
  String get profilePrivacyEntrySubtitle => 'Export, delete, and agreements';

  @override
  String get profilePreferencesCardTitle => 'Preferences';

  @override
  String get profilePreferencesLocaleTitle => 'Language';

  @override
  String get profilePreferencesThemeTitle => 'Theme';

  @override
  String get profilePreferencesFollowSystem => 'Follow system';

  @override
  String get profilePreferencesSystemShort => 'System';

  @override
  String get profilePreferencesSimplifiedChinese => 'Simplified Chinese';

  @override
  String get profilePreferencesSimplifiedChineseNative => '简体中文';

  @override
  String get profilePreferencesEnglish => 'English';

  @override
  String get profilePreferencesLight => 'Light';

  @override
  String get profilePreferencesDark => 'Dark';

  @override
  String get profilePreferencesSaveFailed =>
      'Preferences could not be saved. Please try again later.';

  @override
  String get profileDesktopPresenceTitle => 'Desktop presence';

  @override
  String get profileDesktopPresenceDescription =>
      'If you place the widget on your home screen, tonights goal and last nights status stay visible in your everyday view.';

  @override
  String get widgetGuideEyebrow => 'Put tonight\'s target on your home screen';

  @override
  String get widgetGuideTitle =>
      'Keep bedtime one step closer instead of opening the app every time.';

  @override
  String get widgetGuideDescription =>
      'The widget only shows what matters: tonights target, the remaining time, and last nights status.';

  @override
  String get widgetGuidePreviewTitle => 'Rhythm widget';

  @override
  String get widgetGuidePreviewRemaining => '52m to target';

  @override
  String get widgetGuidePreviewSummary =>
      'Tonight target 23:30\nLast night was 26 minutes late';

  @override
  String get widgetGuideStepAdd =>
      '• Long-press the home screen and add a widget';

  @override
  String get widgetGuideStepChoose =>
      '• Search for Rhythm and choose the medium widget';

  @override
  String get widgetGuideStepPlace =>
      '• Put it where you usually see it at night';

  @override
  String get widgetGuidePrimaryButton => 'Got it, I\'ll add it later';

  @override
  String get widgetThemePageTitle => 'Widget and theme';

  @override
  String get widgetThemePreviewTitle => 'Home screen preview';

  @override
  String get widgetThemePreviewTargetCaption => 'Tonight target';

  @override
  String get widgetThemePreviewLastNightMissing =>
      'There is no record from last night yet';

  @override
  String widgetThemeMinutesToTargetAhead(int minutes) {
    return '$minutes minutes to target';
  }

  @override
  String widgetThemeMinutesToTargetLate(int minutes) {
    return '$minutes minutes past target';
  }

  @override
  String get widgetThemeStateGoalMissingTitle => 'No goal schedule yet';

  @override
  String get widgetThemeStateGoalMissingDescription =>
      'Set a goal schedule first so the widget knows which bedtime reference to keep visible tonight.';

  @override
  String get widgetThemeStateGoalMissingAction => 'Set your schedule goal';

  @override
  String get widgetThemeStateNoDataTitle =>
      'There is no record from last night yet';

  @override
  String get widgetThemeStateNoDataDescription =>
      'The widget can still keep tonights target visible, then fill in last nights status after you sync or add it.';

  @override
  String get widgetThemeStateNoDataAction => 'Manually log last night';

  @override
  String get widgetThemeStatePermissionTitle =>
      'Sleep data permission is still needed';

  @override
  String get widgetThemeStatePermissionDescription =>
      'The widget only shows essential information and never expands raw sleep details.';

  @override
  String get widgetThemeStatePermissionAction => 'Review data access';

  @override
  String get widgetThemeStateReadyDescription =>
      'The current home screen snapshot can already show tonights target and last nights status.';

  @override
  String get widgetThemeRefreshButton => 'Refresh widget snapshot';

  @override
  String get widgetThemeRefreshingButton => 'Refreshing widget snapshot';

  @override
  String get widgetThemeRefreshSuccess => 'Widget snapshot refreshed';

  @override
  String get widgetThemeRefreshFailure =>
      'Refresh failed. Please try again later.';

  @override
  String get widgetThemeRefreshUnavailable =>
      'Rhythm widget has not been added on this device yet.';

  @override
  String get widgetThemeOpenTodayButton => 'Open Today';

  @override
  String get widgetThemeOpenBedtimeButton => 'Enter Bedtime';

  @override
  String widgetSnapshotLastNightLate(int minutes) {
    return '$minutes minutes later last night';
  }

  @override
  String widgetSnapshotLastNightEarly(int minutes) {
    return '$minutes minutes earlier last night';
  }

  @override
  String get widgetSnapshotLastNightOnTime => 'Right on time last night';

  @override
  String get commonRecordSourceHealthKit => 'HealthKit';

  @override
  String get commonRecordSourceHealthConnect => 'Health Connect';

  @override
  String get commonRecordSourceManual => 'Manual';

  @override
  String get commonRecordSourceImported => 'Imported';

  @override
  String get commonConfidenceHigh => 'High confidence';

  @override
  String get commonConfidenceMedium => 'Usable';

  @override
  String get commonConfidenceLow => 'Low confidence';

  @override
  String get commonConfidenceUnknown => 'Unknown confidence';

  @override
  String get profileHealthSummaryHealthKitConnected => 'HealthKit connected';

  @override
  String get profileHealthSummaryHealthConnectConnected =>
      'Health Connect connected';

  @override
  String get profileHealthSummaryPermissionRequired =>
      'Permission needs to be granted again';

  @override
  String get profileHealthSummaryManualFallback =>
      'Manual mode is active for now';

  @override
  String get dataAccessPageTitle => 'Health data access status';

  @override
  String get dataAccessPageDescription =>
      'Automatic records speed things up. Manual entry is the fallback path.';

  @override
  String get dataAccessReauthorizeButton => 'Reauthorize';

  @override
  String get dataAccessManualModeButton => 'Use manual mode';

  @override
  String get dataAccessStatusHealthKitConnected => 'HealthKit connected';

  @override
  String get dataAccessStatusHealthConnectConnected =>
      'Health Connect connected';

  @override
  String get dataAccessStatusInstallRequired => 'Health Connect is required';

  @override
  String get dataAccessStatusPermissionRequired =>
      'Permission needs to be granted again';

  @override
  String get dataAccessStatusManualFallback => 'Manual mode is active for now';

  @override
  String dataAccessStatusConnectedDescription(int count) {
    return '$count records were written in the last 30 days.';
  }

  @override
  String get dataAccessStatusInstallRequiredDescription =>
      'Health Connect is not installed on this device yet. Install it before automatic sleep syncing can continue.';

  @override
  String get dataAccessStatusPermissionRequiredDescription =>
      'Sleep data permission is missing right now. Reauthorize to resume automatic reading.';

  @override
  String get dataAccessStatusManualFallbackDescription =>
      'If this device cannot provide automatic sleep data, you can still keep logging nights manually and reviewing your trend.';

  @override
  String get goalScheduleSettingsPageTitle => 'Fine-tune your reference line';

  @override
  String get goalScheduleSettingsPageDescription =>
      'The closer the target is to real life, the more useful the feedback becomes.';

  @override
  String get goalScheduleSettingsSummaryBedtimeLabel => 'Target bedtime';

  @override
  String get goalScheduleSettingsSummaryWakeLabel => 'Target wake time';

  @override
  String get goalScheduleSettingsSummaryLateThresholdLabel => 'Late threshold';

  @override
  String get goalScheduleSettingsSummaryDayStartLabel => 'Day start';

  @override
  String get goalScheduleSettingsHintDescription =>
      'If you have missed the target often in the last two weeks, pull the target 10 to 15 minutes closer to reality first and adjust forward later.';

  @override
  String get goalScheduleSettingsSaveButton => 'Save changes';

  @override
  String get notificationSettingsPageTitle => 'Keep reminders gentle';

  @override
  String get notificationSettingsPageDescription =>
      'Guide first, and avoid turning reminders into high-pressure supervision.';

  @override
  String get notificationSettingsLeadTitle => 'Lead time';

  @override
  String get notificationSettingsSaveButton => 'Save reminder strategy';

  @override
  String get privacyDataPageTitle =>
      'Sensitive data should stay clear and controllable';

  @override
  String get privacyDataPageDescription =>
      'We explain what will happen first, then let you decide whether to continue.';

  @override
  String get privacyDataPolicyTitle => 'Privacy policy';

  @override
  String get privacyDataPolicyDescription =>
      'See how your data is stored and used';

  @override
  String get privacyDataPolicyDialogMessage =>
      'The current version stores goals, records, tags, and reminder settings locally, and does not use your data for advertising.';

  @override
  String get privacyDataExportTitle => 'Export data';

  @override
  String get privacyDataExportDescription =>
      'Export goals, records, tags, and weekly summaries';

  @override
  String get privacyDataExportDialogTitle => 'Confirm data export';

  @override
  String get privacyDataExportDialogMessage =>
      'The export will include your goal schedule, sleep records, tags, and weekly summaries. Confirm to continue.';

  @override
  String get privacyDataDeleteAccountTitle => 'Delete account';

  @override
  String get privacyDataDeleteAccountDescription =>
      'Remove the cloud account and sync relationship';

  @override
  String get privacyDataDeleteAccountDialogTitle => 'Confirm account deletion';

  @override
  String get privacyDataDeleteAccountDialogMessage =>
      'Deleting the account disconnects this device from cloud sync. Local data will not be restored automatically.';

  @override
  String get privacyDataClearLocalTitle => 'Clear local data';

  @override
  String get privacyDataClearLocalDescription =>
      'Only clear data stored on this device';

  @override
  String get privacyDataClearLocalDialogTitle => 'Confirm local data clear';

  @override
  String get privacyDataClearLocalDialogMessage =>
      'Clearing local data removes cached goals, records, and tags from this device. Please confirm again before continuing.';

  @override
  String get privacyDataDangerCardTitle =>
      'Dangerous actions always need a second confirmation';

  @override
  String get privacyDataDangerCardDescription =>
      'Deleting an account and clearing data must go through a confirmation dialog. They never run directly from a plain list tap.';

  @override
  String get timezoneModePageTitle => 'Timezones and record timing';

  @override
  String get timezoneModePageDescription =>
      'This page explains how timezone changes affect record timing and how special schedules are handled.';

  @override
  String get timezoneModeCurrentTimezoneTitle => 'Current timezone';

  @override
  String get timezoneModeCurrentTimezoneDescription =>
      'Each record keeps the timezone from when the event happened, so older records are not reassigned to a new day when you switch timezones later.';

  @override
  String get timezoneModeSpecialModeTitle => 'Special cases';

  @override
  String get timezoneModeCrossTimezoneDescription =>
      '• When a timezone change is detected, Rhythm reminds you to confirm whether the goal needs a temporary adjustment.';

  @override
  String get timezoneModeShiftWorkDescription =>
      '• Shift-based schedules are not included in the default on-track calculation yet, so it is best to review goals and records separately.';
}
