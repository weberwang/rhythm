import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// The display name of the app.
  ///
  /// In en, this message translates to:
  /// **'Rhythm'**
  String get appName;

  /// Bottom navigation label for the today tab.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// Bottom navigation label for the calendar tab.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get tabCalendar;

  /// Bottom navigation label for the bedtime tab.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get tabBedtime;

  /// Bottom navigation label for the insights tab.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get tabInsights;

  /// Bottom navigation label for the profile tab.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get tabProfile;

  /// Placeholder page title for goal setup.
  ///
  /// In en, this message translates to:
  /// **'Goal setup'**
  String get goalSetupTitle;

  /// Placeholder description for the goal setup page.
  ///
  /// In en, this message translates to:
  /// **'Goal setup will be implemented in Task 3. This page currently only receives the onboarding flow.'**
  String get goalSetupDescription;

  /// Calendar module placeholder title.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTitle;

  /// Calendar module placeholder description.
  ///
  /// In en, this message translates to:
  /// **'Use a heatmap to understand your recent routine rhythm.'**
  String get calendarDescription;

  /// No description provided for @calendarHeroEyebrow.
  ///
  /// In en, this message translates to:
  /// **'May still has rhythm'**
  String get calendarHeroEyebrow;

  /// No description provided for @calendarHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Color is not bad news. It is the distance between you and your target bedtime.'**
  String get calendarHeroTitle;

  /// No description provided for @calendarHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You stayed on track for 16 days this month, and drifted on 9 more.'**
  String get calendarHeroSubtitle;

  /// No description provided for @calendarFilterMetGoal.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get calendarFilterMetGoal;

  /// No description provided for @calendarFilterLate.
  ///
  /// In en, this message translates to:
  /// **'Late drift'**
  String get calendarFilterLate;

  /// No description provided for @calendarFilterDataSource.
  ///
  /// In en, this message translates to:
  /// **'Late count'**
  String get calendarFilterDataSource;

  /// No description provided for @calendarFilterAllDays.
  ///
  /// In en, this message translates to:
  /// **'All days'**
  String get calendarFilterAllDays;

  /// No description provided for @calendarFilterOpen.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get calendarFilterOpen;

  /// No description provided for @calendarFilterSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter calendar feedback'**
  String get calendarFilterSheetTitle;

  /// No description provided for @calendarFilterRecordedOnly.
  ///
  /// In en, this message translates to:
  /// **'Only show recorded days'**
  String get calendarFilterRecordedOnly;

  /// No description provided for @calendarFilterLateOnly.
  ///
  /// In en, this message translates to:
  /// **'Only show late days'**
  String get calendarFilterLateOnly;

  /// No description provided for @calendarFilterLateCountSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} late days'**
  String calendarFilterLateCountSummary(int count);

  /// No description provided for @calendarFilterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get calendarFilterReset;

  /// No description provided for @calendarFilterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get calendarFilterApply;

  /// No description provided for @calendarMetricOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On-track rate'**
  String get calendarMetricOnTrack;

  /// No description provided for @calendarMetricLatestLate.
  ///
  /// In en, this message translates to:
  /// **'Latest late night'**
  String get calendarMetricLatestLate;

  /// No description provided for @calendarDetailSleepTime.
  ///
  /// In en, this message translates to:
  /// **'Actual sleep time'**
  String get calendarDetailSleepTime;

  /// No description provided for @calendarDetailWakeTime.
  ///
  /// In en, this message translates to:
  /// **'Actual wake time'**
  String get calendarDetailWakeTime;

  /// No description provided for @calendarDetailOffset.
  ///
  /// In en, this message translates to:
  /// **'Offset'**
  String get calendarDetailOffset;

  /// No description provided for @calendarDetailSource.
  ///
  /// In en, this message translates to:
  /// **'Source and confidence'**
  String get calendarDetailSource;

  /// No description provided for @calendarDetailNoRecord.
  ///
  /// In en, this message translates to:
  /// **'There is no explainable sleep record for this day yet.'**
  String get calendarDetailNoRecord;

  /// No description provided for @calendarDetailTagsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reason tags'**
  String get calendarDetailTagsTitle;

  /// No description provided for @calendarDetailAddTag.
  ///
  /// In en, this message translates to:
  /// **'Add tag'**
  String get calendarDetailAddTag;

  /// No description provided for @calendarDetailEditRecord.
  ///
  /// In en, this message translates to:
  /// **'Edit last night'**
  String get calendarDetailEditRecord;

  /// No description provided for @calendarDetailOffsetValue.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String calendarDetailOffsetValue(int minutes);

  /// No description provided for @sleepDelayTagPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a late-night reason'**
  String get sleepDelayTagPickerTitle;

  /// No description provided for @sleepDelayTagPickerSave.
  ///
  /// In en, this message translates to:
  /// **'Save tags'**
  String get sleepDelayTagPickerSave;

  /// No description provided for @sleepDelayTagPickerCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom tag'**
  String get sleepDelayTagPickerCustom;

  /// No description provided for @customDelayTagTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a custom reason'**
  String get customDelayTagTitle;

  /// No description provided for @customDelayTagHint.
  ///
  /// In en, this message translates to:
  /// **'Describe why you stayed up late'**
  String get customDelayTagHint;

  /// No description provided for @customDelayTagSave.
  ///
  /// In en, this message translates to:
  /// **'Save custom tag'**
  String get customDelayTagSave;

  /// No description provided for @customDelayTagErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter a reason tag'**
  String get customDelayTagErrorEmpty;

  /// No description provided for @customDelayTagErrorTooLong.
  ///
  /// In en, this message translates to:
  /// **'Reason tags must be 12 characters or fewer'**
  String get customDelayTagErrorTooLong;

  /// No description provided for @customDelayTagErrorDuplicate.
  ///
  /// In en, this message translates to:
  /// **'This reason already exists in the default tags'**
  String get customDelayTagErrorDuplicate;

  /// Bedtime module placeholder title.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get bedtimeTitle;

  /// Bedtime module placeholder description.
  ///
  /// In en, this message translates to:
  /// **'Enter bedtime mode and give tonight a gentler ending.'**
  String get bedtimeDescription;

  /// Insights module placeholder title.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// Insights module placeholder description.
  ///
  /// In en, this message translates to:
  /// **'Review your week and find clues for a steadier routine.'**
  String get insightsDescription;

  /// No description provided for @insightsViewWeeklyReportButton.
  ///
  /// In en, this message translates to:
  /// **'View full weekly report'**
  String get insightsViewWeeklyReportButton;

  /// No description provided for @insightsViewHistoryButton.
  ///
  /// In en, this message translates to:
  /// **'View report history'**
  String get insightsViewHistoryButton;

  /// No description provided for @insightsWeeklyHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your on-track rate was {rate}% over the last 7 days, with a stability score of {score}. The latest night was on {weekday}.'**
  String insightsWeeklyHeadline(int rate, int score, String weekday);

  /// No description provided for @insightsWeeklyDescription.
  ///
  /// In en, this message translates to:
  /// **'You have already narrowed the swings. Next, handle the most common trigger first: {reason}.'**
  String insightsWeeklyDescription(String reason);

  /// No description provided for @insightsOnTrackRateLabel.
  ///
  /// In en, this message translates to:
  /// **'On-track rate'**
  String get insightsOnTrackRateLabel;

  /// No description provided for @insightsStabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Stability'**
  String get insightsStabilityLabel;

  /// No description provided for @insightsLatestLateTitle.
  ///
  /// In en, this message translates to:
  /// **'Latest late night'**
  String get insightsLatestLateTitle;

  /// No description provided for @insightsNextWeekAdviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Next week suggestions'**
  String get insightsNextWeekAdviceTitle;

  /// No description provided for @insightsReasonDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Main late-night reasons'**
  String get insightsReasonDistributionTitle;

  /// No description provided for @insightsNoReasonTags.
  ///
  /// In en, this message translates to:
  /// **'No reason tags yet'**
  String get insightsNoReasonTags;

  /// No description provided for @insightsNoWeeklyReport.
  ///
  /// In en, this message translates to:
  /// **'No weekly report yet'**
  String get insightsNoWeeklyReport;

  /// No description provided for @insightsNoHistory.
  ///
  /// In en, this message translates to:
  /// **'No insight history yet'**
  String get insightsNoHistory;

  /// No description provided for @insightsWeeklyReportPageTitle.
  ///
  /// In en, this message translates to:
  /// **'This week report'**
  String get insightsWeeklyReportPageTitle;

  /// No description provided for @insightsHistoryPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Insight history'**
  String get insightsHistoryPageTitle;

  /// No description provided for @insightsHistoryHeadline.
  ///
  /// In en, this message translates to:
  /// **'Look back at long-term changes'**
  String get insightsHistoryHeadline;

  /// No description provided for @insightsHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'The last 30 days can be viewed directly. Older history hands off to membership here.'**
  String get insightsHistoryDescription;

  /// No description provided for @insightsHistoryPaywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Need a longer timeline?'**
  String get insightsHistoryPaywallTitle;

  /// No description provided for @insightsHistoryPaywallDescription.
  ///
  /// In en, this message translates to:
  /// **'Membership unlocks older history, monthly reports, and a fuller recovery trail.'**
  String get insightsHistoryPaywallDescription;

  /// No description provided for @insightsHistoryUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock all insight history'**
  String get insightsHistoryUnlockButton;

  /// No description provided for @membershipCenterPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Membership center'**
  String get membershipCenterPageTitle;

  /// No description provided for @membershipCenterHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect the long-term improvement layer'**
  String get membershipCenterHeroTitle;

  /// No description provided for @membershipCenterHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Membership does not replace the core loop. It makes causes and recovery paths easier to understand.'**
  String get membershipCenterHeroDescription;

  /// No description provided for @membershipStatusFree.
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get membershipStatusFree;

  /// No description provided for @membershipStatusTrial.
  ///
  /// In en, this message translates to:
  /// **'Trial active'**
  String get membershipStatusTrial;

  /// No description provided for @membershipStatusMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly membership active'**
  String get membershipStatusMonthly;

  /// No description provided for @membershipStatusAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual membership active'**
  String get membershipStatusAnnual;

  /// No description provided for @membershipStatusLifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime membership active'**
  String get membershipStatusLifetime;

  /// No description provided for @membershipStatusDescription.
  ///
  /// In en, this message translates to:
  /// **'After upgrading, you can view recovery plan details, long-term history, stability explanations, and richer widgets.'**
  String get membershipStatusDescription;

  /// No description provided for @membershipPlanMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get membershipPlanMonthly;

  /// No description provided for @membershipPlanAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get membershipPlanAnnual;

  /// No description provided for @membershipPlanLifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get membershipPlanLifetime;

  /// No description provided for @membershipPlanTrial.
  ///
  /// In en, this message translates to:
  /// **'Trial'**
  String get membershipPlanTrial;

  /// No description provided for @membershipPlanFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get membershipPlanFree;

  /// No description provided for @membershipPlanTryBadge.
  ///
  /// In en, this message translates to:
  /// **'Try first'**
  String get membershipPlanTryBadge;

  /// No description provided for @membershipPlanRecommendedBadge.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get membershipPlanRecommendedBadge;

  /// No description provided for @membershipBenefitRecoveryDetail.
  ///
  /// In en, this message translates to:
  /// **'Full recovery plan details'**
  String get membershipBenefitRecoveryDetail;

  /// No description provided for @membershipBenefitStabilityExplainer.
  ///
  /// In en, this message translates to:
  /// **'Stability score explanations'**
  String get membershipBenefitStabilityExplainer;

  /// No description provided for @membershipBenefitHistoryMonthly.
  ///
  /// In en, this message translates to:
  /// **'History older than 30 days and monthly reports'**
  String get membershipBenefitHistoryMonthly;

  /// No description provided for @membershipBenefitRestoreSync.
  ///
  /// In en, this message translates to:
  /// **'Purchase restore and device sync'**
  String get membershipBenefitRestoreSync;

  /// No description provided for @membershipBenefitsSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Membership benefits'**
  String get membershipBenefitsSheetTitle;

  /// No description provided for @membershipBenefitsSheetDescription.
  ///
  /// In en, this message translates to:
  /// **'Opened from Insights or Profile to explain the boundary between the free and membership plans.'**
  String get membershipBenefitsSheetDescription;

  /// No description provided for @membershipBenefitRecoveryShort.
  ///
  /// In en, this message translates to:
  /// **'Recovery plan'**
  String get membershipBenefitRecoveryShort;

  /// No description provided for @membershipBenefitHistoryShort.
  ///
  /// In en, this message translates to:
  /// **'Long-term history'**
  String get membershipBenefitHistoryShort;

  /// No description provided for @membershipBenefitMonthlyShort.
  ///
  /// In en, this message translates to:
  /// **'Monthly reports'**
  String get membershipBenefitMonthlyShort;

  /// No description provided for @membershipPrimaryActionAnnual.
  ///
  /// In en, this message translates to:
  /// **'Start annual membership'**
  String get membershipPrimaryActionAnnual;

  /// No description provided for @membershipPrimaryActionMonthly.
  ///
  /// In en, this message translates to:
  /// **'Start monthly membership'**
  String get membershipPrimaryActionMonthly;

  /// No description provided for @membershipPrimaryActionManage.
  ///
  /// In en, this message translates to:
  /// **'Manage current membership'**
  String get membershipPrimaryActionManage;

  /// No description provided for @membershipViewBenefitsButton.
  ///
  /// In en, this message translates to:
  /// **'View benefits'**
  String get membershipViewBenefitsButton;

  /// No description provided for @membershipRestoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get membershipRestoreButton;

  /// No description provided for @paywallHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'Unlock the improvement layer too'**
  String get paywallHeroBadge;

  /// No description provided for @paywallHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'The free plan gives you results. Membership connects recovery plans, stability explanations, and long-term history.'**
  String get paywallHeroTitle;

  /// No description provided for @paywallHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'It never hard-blocks first-run. It appears only when you truly want deeper help.'**
  String get paywallHeroDescription;

  /// No description provided for @paywallHintTitle.
  ///
  /// In en, this message translates to:
  /// **'Membership capability'**
  String get paywallHintTitle;

  /// No description provided for @paywallHintDescription.
  ///
  /// In en, this message translates to:
  /// **'Recovery plan details are a membership capability, but the free loop can still continue.'**
  String get paywallHintDescription;

  /// No description provided for @paywallBenefitRecoveryDetail.
  ///
  /// In en, this message translates to:
  /// **'Recovery plan details'**
  String get paywallBenefitRecoveryDetail;

  /// No description provided for @paywallBenefitStabilityExplainer.
  ///
  /// In en, this message translates to:
  /// **'Detailed stability explanation'**
  String get paywallBenefitStabilityExplainer;

  /// No description provided for @paywallBenefitHistoryMonthly.
  ///
  /// In en, this message translates to:
  /// **'History older than 30 days and monthly reports'**
  String get paywallBenefitHistoryMonthly;

  /// No description provided for @paywallBenefitWidgetSync.
  ///
  /// In en, this message translates to:
  /// **'Richer widgets and cross-device sync'**
  String get paywallBenefitWidgetSync;

  /// No description provided for @paywallPrimaryActionAnnual.
  ///
  /// In en, this message translates to:
  /// **'Start annual membership'**
  String get paywallPrimaryActionAnnual;

  /// No description provided for @paywallPrimaryActionMonthly.
  ///
  /// In en, this message translates to:
  /// **'Start monthly membership'**
  String get paywallPrimaryActionMonthly;

  /// No description provided for @paywallPrimaryActionLifetime.
  ///
  /// In en, this message translates to:
  /// **'Start lifetime membership'**
  String get paywallPrimaryActionLifetime;

  /// No description provided for @paywallPrimaryActionTrial.
  ///
  /// In en, this message translates to:
  /// **'Start trial'**
  String get paywallPrimaryActionTrial;

  /// No description provided for @paywallContinueFreeButton.
  ///
  /// In en, this message translates to:
  /// **'Keep using free plan'**
  String get paywallContinueFreeButton;

  /// No description provided for @insightsHistoryLocked.
  ///
  /// In en, this message translates to:
  /// **'Outside the free range'**
  String get insightsHistoryLocked;

  /// No description provided for @insightsHistorySummary.
  ///
  /// In en, this message translates to:
  /// **'On-track rate {rate}% · Stability {score}'**
  String insightsHistorySummary(int rate, int score);

  /// No description provided for @insightsLatestLateSummary.
  ///
  /// In en, this message translates to:
  /// **'You fell asleep at {time} on {weekday}, which was {minutes} minutes later than your target.'**
  String insightsLatestLateSummary(String weekday, String time, int minutes);

  /// No description provided for @insightsLatestLateSummaryWithReasons.
  ///
  /// In en, this message translates to:
  /// **'{base} The main reasons were {reasons}.'**
  String insightsLatestLateSummaryWithReasons(String base, String reasons);

  /// No description provided for @insightsStabilitySummaryInsufficient.
  ///
  /// In en, this message translates to:
  /// **'Not enough samples yet'**
  String get insightsStabilitySummaryInsufficient;

  /// No description provided for @insightsStabilitySummarySteady.
  ///
  /// In en, this message translates to:
  /// **'This week stayed very steady'**
  String get insightsStabilitySummarySteady;

  /// No description provided for @insightsStabilitySummaryRecovering.
  ///
  /// In en, this message translates to:
  /// **'This week was not worse. It was settling back down.'**
  String get insightsStabilitySummaryRecovering;

  /// No description provided for @insightsStabilitySummaryNeedsRecovery.
  ///
  /// In en, this message translates to:
  /// **'This week had obvious swings'**
  String get insightsStabilitySummaryNeedsRecovery;

  /// No description provided for @insightsStabilityDescriptionInsufficient.
  ///
  /// In en, this message translates to:
  /// **'At least 3 valid days are needed before a formal stability score can be shown.'**
  String get insightsStabilityDescriptionInsufficient;

  /// No description provided for @insightsStabilityDescriptionSteady.
  ///
  /// In en, this message translates to:
  /// **'Your bedtime offsets and swings were both small, so you can keep the current rhythm.'**
  String get insightsStabilityDescriptionSteady;

  /// No description provided for @insightsStabilityDescriptionRecovering.
  ///
  /// In en, this message translates to:
  /// **'There is still some drift, but the range is narrowing. Handle the frequent triggers first.'**
  String get insightsStabilityDescriptionRecovering;

  /// No description provided for @insightsStabilityDescriptionNeedsRecovery.
  ///
  /// In en, this message translates to:
  /// **'The current drift is large enough that a 1 to 3 day recovery plan should come first.'**
  String get insightsStabilityDescriptionNeedsRecovery;

  /// No description provided for @insightsStabilityExplainerTitle.
  ///
  /// In en, this message translates to:
  /// **'How stability is scored'**
  String get insightsStabilityExplainerTitle;

  /// No description provided for @insightsStabilityScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Current score: {score}'**
  String insightsStabilityScoreLabel(int score);

  /// No description provided for @insightsStabilitySampleHint.
  ///
  /// In en, this message translates to:
  /// **'A formal stability score appears only after at least 3 valid days.'**
  String get insightsStabilitySampleHint;

  /// No description provided for @insightsRecoveryEffectTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery effect'**
  String get insightsRecoveryEffectTitle;

  /// No description provided for @insightsRecoveryNoPlan.
  ///
  /// In en, this message translates to:
  /// **'No recovery plan was triggered this week.'**
  String get insightsRecoveryNoPlan;

  /// No description provided for @insightsRecoveryPlanSummary.
  ///
  /// In en, this message translates to:
  /// **'After the latest obvious late night, use {days} days to get bedtime back inside the threshold.'**
  String insightsRecoveryPlanSummary(int days);

  /// No description provided for @insightsRecoveryPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'{days}-day recovery rhythm'**
  String insightsRecoveryPlanTitle(int days);

  /// No description provided for @insightsRecoveryPlanDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery plan details'**
  String get insightsRecoveryPlanDetailTitle;

  /// No description provided for @insightsRecoveryStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Day {day} · {title}'**
  String insightsRecoveryStepLabel(int day, String title);

  /// No description provided for @insightsRecoveryStepCloseWorkEarlierTitle.
  ///
  /// In en, this message translates to:
  /// **'Pull tonight back first'**
  String get insightsRecoveryStepCloseWorkEarlierTitle;

  /// No description provided for @insightsRecoveryStepCloseWorkEarlierDetail.
  ///
  /// In en, this message translates to:
  /// **'Finish the last work or entertainment item 45 minutes before your target bedtime.'**
  String get insightsRecoveryStepCloseWorkEarlierDetail;

  /// No description provided for @insightsRecoveryStepReduceNightNoiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Reduce the delay buffer'**
  String get insightsRecoveryStepReduceNightNoiseTitle;

  /// No description provided for @insightsRecoveryStepReduceNightNoiseDetail.
  ///
  /// In en, this message translates to:
  /// **'Keep only one bedtime action tonight so the routine does not slip past the threshold again.'**
  String get insightsRecoveryStepReduceNightNoiseDetail;

  /// No description provided for @insightsRecoveryStepReviewLateTriggersTitle.
  ///
  /// In en, this message translates to:
  /// **'Check whether you are back inside the threshold'**
  String get insightsRecoveryStepReviewLateTriggersTitle;

  /// No description provided for @insightsRecoveryStepReviewLateTriggersDetail.
  ///
  /// In en, this message translates to:
  /// **'If tonight still runs late, review the late-night triggers and keep the most common one visible.'**
  String get insightsRecoveryStepReviewLateTriggersDetail;

  /// No description provided for @insightsRecommendationFinishWorkEarlier.
  ///
  /// In en, this message translates to:
  /// **'Finish the last work task before 10:45 PM'**
  String get insightsRecommendationFinishWorkEarlier;

  /// No description provided for @insightsRecommendationEnableSoftReminder.
  ///
  /// In en, this message translates to:
  /// **'Turn on the soft reminder first on higher-risk midweek days'**
  String get insightsRecommendationEnableSoftReminder;

  /// No description provided for @insightsRecommendationOpenRecoveryPlan.
  ///
  /// In en, this message translates to:
  /// **'If you run late for 2 days in a row, open the recovery plan immediately'**
  String get insightsRecommendationOpenRecoveryPlan;

  /// No description provided for @insightsWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get insightsWeekdayMon;

  /// No description provided for @insightsWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get insightsWeekdayTue;

  /// No description provided for @insightsWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get insightsWeekdayWed;

  /// No description provided for @insightsWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get insightsWeekdayThu;

  /// No description provided for @insightsWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get insightsWeekdayFri;

  /// No description provided for @insightsWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get insightsWeekdaySat;

  /// No description provided for @insightsWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get insightsWeekdaySun;

  /// Profile module placeholder title.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get profileTitle;

  /// Profile module placeholder description.
  ///
  /// In en, this message translates to:
  /// **'Manage goals, reminders, account, and privacy settings.'**
  String get profileDescription;

  /// Title for the today page.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayPageTitle;

  /// Primary card title on the today page.
  ///
  /// In en, this message translates to:
  /// **'Take it lighter tonight'**
  String get todayCardTitle;

  /// Primary card description on the today page.
  ///
  /// In en, this message translates to:
  /// **'After you set a target schedule, this area will show last night’s result and tonight’s action.'**
  String get todayCardDescription;

  /// Button label that opens the stage 3 sleep records hub from the today placeholder page.
  ///
  /// In en, this message translates to:
  /// **'Open sleep record management'**
  String get todayOpenSleepRecordsButton;

  /// No description provided for @todayGoalMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a sleep goal first'**
  String get todayGoalMissingTitle;

  /// No description provided for @todayGoalMissingPrimaryAction.
  ///
  /// In en, this message translates to:
  /// **'Set your schedule goal'**
  String get todayGoalMissingPrimaryAction;

  /// No description provided for @todayPermissionFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep data is temporarily unavailable'**
  String get todayPermissionFailedTitle;

  /// No description provided for @todayPermissionFailedPrimaryAction.
  ///
  /// In en, this message translates to:
  /// **'Review permission help'**
  String get todayPermissionFailedPrimaryAction;

  /// No description provided for @todayEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'There is no record from last night yet'**
  String get todayEmptyTitle;

  /// No description provided for @todayEmptyPrimaryAction.
  ///
  /// In en, this message translates to:
  /// **'Manually log last night'**
  String get todayEmptyPrimaryAction;

  /// No description provided for @todayStatusSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Last night'**
  String get todayStatusSectionTitle;

  /// No description provided for @todayActionSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Tonight action'**
  String get todayActionSectionTitle;

  /// No description provided for @todayTrendSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get todayTrendSectionTitle;

  /// No description provided for @todayRecoverySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery suggestion'**
  String get todayRecoverySectionTitle;

  /// No description provided for @todayQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick log'**
  String get todayQuickActionsTitle;

  /// No description provided for @todayQuickActionManualButton.
  ///
  /// In en, this message translates to:
  /// **'Manually log'**
  String get todayQuickActionManualButton;

  /// No description provided for @todayQuickActionEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit last night'**
  String get todayQuickActionEditButton;

  /// No description provided for @todayQuickActionOpenHubButton.
  ///
  /// In en, this message translates to:
  /// **'Open record hub'**
  String get todayQuickActionOpenHubButton;

  /// No description provided for @todayRecoveryDescription.
  ///
  /// In en, this message translates to:
  /// **'Pull the latest task forward tonight so tomorrow has a little more room to settle back.'**
  String get todayRecoveryDescription;

  /// No description provided for @todayTrendEmptyState.
  ///
  /// In en, this message translates to:
  /// **'Build a few more days to reveal the trend'**
  String get todayTrendEmptyState;

  /// No description provided for @todayStatusUserConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed by you'**
  String get todayStatusUserConfirmed;

  /// No description provided for @todayStatusGoalMet.
  ///
  /// In en, this message translates to:
  /// **'Last night stayed near target'**
  String get todayStatusGoalMet;

  /// No description provided for @todayStatusLateBy.
  ///
  /// In en, this message translates to:
  /// **'Late by {minutes} minutes'**
  String todayStatusLateBy(int minutes);

  /// No description provided for @todayStatusWithinThreshold.
  ///
  /// In en, this message translates to:
  /// **'Still inside the threshold'**
  String get todayStatusWithinThreshold;

  /// No description provided for @todayStatusEarlyBy.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes earlier than target'**
  String todayStatusEarlyBy(int minutes);

  /// No description provided for @todayStatusLateDetail.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes later than target'**
  String todayStatusLateDetail(int minutes);

  /// No description provided for @todayActionEnterBedtimeMode.
  ///
  /// In en, this message translates to:
  /// **'Enter bedtime mode'**
  String get todayActionEnterBedtimeMode;

  /// No description provided for @todayActionManualRecord.
  ///
  /// In en, this message translates to:
  /// **'Manually log last night'**
  String get todayActionManualRecord;

  /// No description provided for @todayActionPermissionHelp.
  ///
  /// In en, this message translates to:
  /// **'Review permission help'**
  String get todayActionPermissionHelp;

  /// No description provided for @todayActionGoalSetup.
  ///
  /// In en, this message translates to:
  /// **'Set your schedule goal'**
  String get todayActionGoalSetup;

  /// No description provided for @todayActionRecoveryPlan.
  ///
  /// In en, this message translates to:
  /// **'View recovery suggestions'**
  String get todayActionRecoveryPlan;

  /// No description provided for @todayActionTargetBedtime.
  ///
  /// In en, this message translates to:
  /// **'Tonight target {time}'**
  String todayActionTargetBedtime(String time);

  /// Title for the stage 3 sleep records hub page.
  ///
  /// In en, this message translates to:
  /// **'Sleep record management'**
  String get sleepRecordsHubTitle;

  /// Primary sync card title on the stage 3 sleep records hub page.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days of sleep records'**
  String get sleepRecordsHubSyncTitle;

  /// Primary sync card description on the stage 3 sleep records hub page.
  ///
  /// In en, this message translates to:
  /// **'Automatic records speed things up. Manual entry is the fallback path.'**
  String get sleepRecordsHubSyncDescription;

  /// Primary button label for manually adding a sleep record.
  ///
  /// In en, this message translates to:
  /// **'Manual entry'**
  String get sleepRecordsHubManualButton;

  /// No description provided for @sleepRecordsHubRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry sync'**
  String get sleepRecordsHubRetryButton;

  /// No description provided for @sleepRecordsHubInstallButton.
  ///
  /// In en, this message translates to:
  /// **'Install Health Connect'**
  String get sleepRecordsHubInstallButton;

  /// No description provided for @sleepRecordsHubAuthorizeButton.
  ///
  /// In en, this message translates to:
  /// **'Reauthorize'**
  String get sleepRecordsHubAuthorizeButton;

  /// No description provided for @sleepRecordsHubManualModeButton.
  ///
  /// In en, this message translates to:
  /// **'Use manual mode'**
  String get sleepRecordsHubManualModeButton;

  /// No description provided for @sleepRecordsHubStatusIdle.
  ///
  /// In en, this message translates to:
  /// **'Waiting to sync'**
  String get sleepRecordsHubStatusIdle;

  /// No description provided for @sleepRecordsHubStatusIdleDescription.
  ///
  /// In en, this message translates to:
  /// **'No sleep records have been pulled for the last 30 days yet. You can sync first or switch to manual entry.'**
  String get sleepRecordsHubStatusIdleDescription;

  /// No description provided for @sleepRecordsHubStatusSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing'**
  String get sleepRecordsHubStatusSyncing;

  /// No description provided for @sleepRecordsHubStatusSyncingDescription.
  ///
  /// In en, this message translates to:
  /// **'Reading the last 30 days of sleep records. Please wait.'**
  String get sleepRecordsHubStatusSyncingDescription;

  /// No description provided for @sleepRecordsHubStatusConnected.
  ///
  /// In en, this message translates to:
  /// **'Health data connected'**
  String get sleepRecordsHubStatusConnected;

  /// No description provided for @sleepRecordsHubStatusConnectedDescription.
  ///
  /// In en, this message translates to:
  /// **'Saved {count} sleep records from the last 30 days.'**
  String sleepRecordsHubStatusConnectedDescription(int count);

  /// No description provided for @sleepRecordsHubStatusInstallRequired.
  ///
  /// In en, this message translates to:
  /// **'Health Connect is required'**
  String get sleepRecordsHubStatusInstallRequired;

  /// No description provided for @sleepRecordsHubStatusInstallRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Health Connect is not installed on this device yet. Install it to enable automatic sleep sync.'**
  String get sleepRecordsHubStatusInstallRequiredDescription;

  /// No description provided for @sleepRecordsHubStatusPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Sleep access is required'**
  String get sleepRecordsHubStatusPermissionRequired;

  /// No description provided for @sleepRecordsHubStatusPermissionRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Sleep read permission has not been granted. Reauthorize to continue automatic sync.'**
  String get sleepRecordsHubStatusPermissionRequiredDescription;

  /// No description provided for @sleepRecordsHubStatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sleep sync is unavailable on this device'**
  String get sleepRecordsHubStatusUnavailable;

  /// No description provided for @sleepRecordsHubStatusUnavailableDescription.
  ///
  /// In en, this message translates to:
  /// **'You can still log last night manually and add automatic records later.'**
  String get sleepRecordsHubStatusUnavailableDescription;

  /// No description provided for @sleepRecordsHubStatusManualFallback.
  ///
  /// In en, this message translates to:
  /// **'Manual entry is active'**
  String get sleepRecordsHubStatusManualFallback;

  /// No description provided for @sleepRecordsHubStatusManualFallbackDescription.
  ///
  /// In en, this message translates to:
  /// **'No usable sleep record was found. You can still confirm last night manually.'**
  String get sleepRecordsHubStatusManualFallbackDescription;

  /// No description provided for @sleepRecordsHubStatusError.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get sleepRecordsHubStatusError;

  /// No description provided for @sleepRecordsHubStatusErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'This automatic sync did not complete. You can retry later or switch to manual entry now.'**
  String get sleepRecordsHubStatusErrorDescription;

  /// No description provided for @sleepRecordsHubLastSyncedTitle.
  ///
  /// In en, this message translates to:
  /// **'Last synced'**
  String get sleepRecordsHubLastSyncedTitle;

  /// No description provided for @sleepRecordsHubFailureReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Failure reason'**
  String get sleepRecordsHubFailureReasonTitle;

  /// No description provided for @sleepRecordsHubFailureReasonSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Health data could not be read. Please try again later.'**
  String get sleepRecordsHubFailureReasonSyncFailed;

  /// No description provided for @sleepRecordsHubFailureReasonPlatformUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Health data is not available on this device right now. Switch to manual entry first.'**
  String get sleepRecordsHubFailureReasonPlatformUnavailable;

  /// No description provided for @sleepRecordsHubFailureReasonGeneric.
  ///
  /// In en, this message translates to:
  /// **'This sync did not complete. Please try again later.'**
  String get sleepRecordsHubFailureReasonGeneric;

  /// No description provided for @sleepRecordsHubSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Source and confidence'**
  String get sleepRecordsHubSourceTitle;

  /// No description provided for @sleepRecordsHubSourceBulletOriginal.
  ///
  /// In en, this message translates to:
  /// **'• Automatically synced records keep their original source'**
  String get sleepRecordsHubSourceBulletOriginal;

  /// No description provided for @sleepRecordsHubSourceBulletManual.
  ///
  /// In en, this message translates to:
  /// **'• Manual corrections do not overwrite raw records; they create a confirmed result'**
  String get sleepRecordsHubSourceBulletManual;

  /// No description provided for @sleepRecordsHubSourceBulletFallback.
  ///
  /// In en, this message translates to:
  /// **'• Today, Calendar, and reports still work without permission'**
  String get sleepRecordsHubSourceBulletFallback;

  /// Empty state text shown when the stage 3 sleep records hub has no confirmed records yet.
  ///
  /// In en, this message translates to:
  /// **'No confirmed sleep records yet'**
  String get sleepRecordsHubEmptyState;

  /// Error text shown when the stage 3 sleep records hub cannot load records.
  ///
  /// In en, this message translates to:
  /// **'Failed to load sleep records'**
  String get sleepRecordsHubLoadFailed;

  /// List title used for manually added sleep records.
  ///
  /// In en, this message translates to:
  /// **'Manual sleep record'**
  String get sleepRecordsHubManualRecordTitle;

  /// List title used for Android Health Connect synced records.
  ///
  /// In en, this message translates to:
  /// **'Health Connect record'**
  String get sleepRecordsHubHealthConnectRecordTitle;

  /// List title used for iOS HealthKit synced records.
  ///
  /// In en, this message translates to:
  /// **'HealthKit record'**
  String get sleepRecordsHubHealthKitRecordTitle;

  /// List title used for imported sleep records.
  ///
  /// In en, this message translates to:
  /// **'Imported record'**
  String get sleepRecordsHubImportedRecordTitle;

  /// Title for the manual sleep record page.
  ///
  /// In en, this message translates to:
  /// **'Manual entry'**
  String get manualSleepRecordPageTitle;

  /// No description provided for @manualSleepRecordPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm last night’s sleep result manually'**
  String get manualSleepRecordPageSubtitle;

  /// No description provided for @manualSleepRecordPageDescription.
  ///
  /// In en, this message translates to:
  /// **'When automatic records are missing or inaccurate, you can manually log or correct sleep and wake times.'**
  String get manualSleepRecordPageDescription;

  /// No description provided for @manualSleepRecordDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Record date'**
  String get manualSleepRecordDateLabel;

  /// Label for the sleep time field on the manual sleep record page.
  ///
  /// In en, this message translates to:
  /// **'Sleep time'**
  String get manualSleepRecordSleepTimeLabel;

  /// Label for the wake time field on the manual sleep record page.
  ///
  /// In en, this message translates to:
  /// **'Wake time'**
  String get manualSleepRecordWakeTimeLabel;

  /// No description provided for @manualSleepRecordDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get manualSleepRecordDurationLabel;

  /// No description provided for @manualSleepRecordSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get manualSleepRecordSourceLabel;

  /// No description provided for @manualSleepRecordSourceValue.
  ///
  /// In en, this message translates to:
  /// **'Manual correction'**
  String get manualSleepRecordSourceValue;

  /// Primary button label for saving a manual sleep record.
  ///
  /// In en, this message translates to:
  /// **'Save manual result'**
  String get manualSleepRecordSaveButton;

  /// No description provided for @manualSleepRecordDiscardButton.
  ///
  /// In en, this message translates to:
  /// **'Discard changes'**
  String get manualSleepRecordDiscardButton;

  /// No description provided for @manualSleepRecordHelperTitle.
  ///
  /// In en, this message translates to:
  /// **'Correction notes'**
  String get manualSleepRecordHelperTitle;

  /// No description provided for @manualSleepRecordHelperDescription.
  ///
  /// In en, this message translates to:
  /// **'The raw system record stays intact. What you save becomes the confirmed result shown first in Today and Calendar.'**
  String get manualSleepRecordHelperDescription;

  /// No description provided for @manualSleepRecordValidationSameTime.
  ///
  /// In en, this message translates to:
  /// **'Sleep time and wake time cannot be the same.'**
  String get manualSleepRecordValidationSameTime;

  /// No description provided for @manualSleepRecordEditTimeButton.
  ///
  /// In en, this message translates to:
  /// **'Edit time'**
  String get manualSleepRecordEditTimeButton;

  /// No description provided for @onboardingStepOneEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Step 1 / 3'**
  String get onboardingStepOneEyebrow;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Rhythm'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Starting tonight, build a steadier routine in a gentler way by finishing these 3 quick setup steps.'**
  String get onboardingWelcomeDescription;

  /// No description provided for @onboardingWelcomeChecklistTitle.
  ///
  /// In en, this message translates to:
  /// **'You’ll complete'**
  String get onboardingWelcomeChecklistTitle;

  /// No description provided for @onboardingWelcomeBulletAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how to enter'**
  String get onboardingWelcomeBulletAuthTitle;

  /// No description provided for @onboardingWelcomeBulletAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Anonymous mode is available now, and Apple / Google entry points stay ready for later integration.'**
  String get onboardingWelcomeBulletAuthDescription;

  /// No description provided for @onboardingWelcomeBulletHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Understand health data value'**
  String get onboardingWelcomeBulletHealthTitle;

  /// No description provided for @onboardingWelcomeBulletHealthDescription.
  ///
  /// In en, this message translates to:
  /// **'We explain the value first and keep real system permission requests out of this task.'**
  String get onboardingWelcomeBulletHealthDescription;

  /// No description provided for @onboardingWelcomeBulletGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your target schedule'**
  String get onboardingWelcomeBulletGoalTitle;

  /// No description provided for @onboardingWelcomeBulletGoalDescription.
  ///
  /// In en, this message translates to:
  /// **'This implementation now carries the flow into real goal and reminder setup instead of stopping at a placeholder.'**
  String get onboardingWelcomeBulletGoalDescription;

  /// No description provided for @onboardingWelcomePrimaryButton.
  ///
  /// In en, this message translates to:
  /// **'Start setup'**
  String get onboardingWelcomePrimaryButton;

  /// No description provided for @onboardingStepTwoEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Step 2 / 3'**
  String get onboardingStepTwoEyebrow;

  /// No description provided for @onboardingAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Get the rhythm moving first; sign in only when sync is needed.'**
  String get onboardingAuthTitle;

  /// No description provided for @onboardingAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Anonymous entry lowers first-run friction. Sign in is for device transfer and membership sync.'**
  String get onboardingAuthDescription;

  /// No description provided for @onboardingAuthAppleLabel.
  ///
  /// In en, this message translates to:
  /// **'Local first'**
  String get onboardingAuthAppleLabel;

  /// No description provided for @onboardingAuthAppleDescription.
  ///
  /// In en, this message translates to:
  /// **'Data stays on this device'**
  String get onboardingAuthAppleDescription;

  /// No description provided for @onboardingAuthGoogleLabel.
  ///
  /// In en, this message translates to:
  /// **'Bind later'**
  String get onboardingAuthGoogleLabel;

  /// No description provided for @onboardingAuthGoogleDescription.
  ///
  /// In en, this message translates to:
  /// **'You can still connect an account later'**
  String get onboardingAuthGoogleDescription;

  /// No description provided for @onboardingAuthAnonymousButton.
  ///
  /// In en, this message translates to:
  /// **'Continue anonymously'**
  String get onboardingAuthAnonymousButton;

  /// No description provided for @onboardingAuthLaterButton.
  ///
  /// In en, this message translates to:
  /// **'Use Apple'**
  String get onboardingAuthLaterButton;

  /// No description provided for @onboardingAuthGoogleButton.
  ///
  /// In en, this message translates to:
  /// **'Use Google'**
  String get onboardingAuthGoogleButton;

  /// No description provided for @onboardingStepThreeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Step 3 / 3'**
  String get onboardingStepThreeEyebrow;

  /// No description provided for @onboardingHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Read sleep data'**
  String get onboardingHealthTitle;

  /// No description provided for @onboardingHealthDescription.
  ///
  /// In en, this message translates to:
  /// **'We only read sleep records and do not use them for medical judgment or ads.'**
  String get onboardingHealthDescription;

  /// No description provided for @onboardingHealthAppleSummary.
  ///
  /// In en, this message translates to:
  /// **'Auto-sync sleep records'**
  String get onboardingHealthAppleSummary;

  /// No description provided for @onboardingHealthGoogleSummary.
  ///
  /// In en, this message translates to:
  /// **'The last 30 days will be written into the local rhythm timeline'**
  String get onboardingHealthGoogleSummary;

  /// No description provided for @onboardingHealthAnonymousSummary.
  ///
  /// In en, this message translates to:
  /// **'Authorization failure can fall back'**
  String get onboardingHealthAnonymousSummary;

  /// No description provided for @onboardingHealthDefaultSummary.
  ///
  /// In en, this message translates to:
  /// **'Without permission, you can still manually log and generate weekly reports'**
  String get onboardingHealthDefaultSummary;

  /// No description provided for @onboardingHealthBenefitTitle.
  ///
  /// In en, this message translates to:
  /// **'Why enable it'**
  String get onboardingHealthBenefitTitle;

  /// No description provided for @onboardingHealthBenefitDescription.
  ///
  /// In en, this message translates to:
  /// **'Later health data access reduces manual logging and improves trend review continuity.'**
  String get onboardingHealthBenefitDescription;

  /// No description provided for @onboardingHealthCurrentStageTitle.
  ///
  /// In en, this message translates to:
  /// **'Stage notes'**
  String get onboardingHealthCurrentStageTitle;

  /// No description provided for @onboardingHealthCurrentStageDescription.
  ///
  /// In en, this message translates to:
  /// **'This task only completes the explanation flow and does not trigger a real system permission request.'**
  String get onboardingHealthCurrentStageDescription;

  /// No description provided for @onboardingHealthSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Use manual mode first'**
  String get onboardingHealthSkipButton;

  /// No description provided for @onboardingHealthAuthorizeButton.
  ///
  /// In en, this message translates to:
  /// **'Authorize sleep data'**
  String get onboardingHealthAuthorizeButton;

  /// No description provided for @goalSetupEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Set a doable target'**
  String get goalSetupEyebrow;

  /// No description provided for @goalSetupPageTitle.
  ///
  /// In en, this message translates to:
  /// **'The target is a reference line, not a perfect daily red line.'**
  String get goalSetupPageTitle;

  /// No description provided for @goalSetupPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Start with a basic target, then adjust later anytime.'**
  String get goalSetupPageDescription;

  /// No description provided for @goalSetupContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Save goal and continue'**
  String get goalSetupContinueButton;

  /// No description provided for @goalSetupWorkdayTitle.
  ///
  /// In en, this message translates to:
  /// **'Workday rule'**
  String get goalSetupWorkdayTitle;

  /// No description provided for @goalSetupWorkdayWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays first'**
  String get goalSetupWorkdayWeekdays;

  /// No description provided for @goalSetupWorkdayFlexible.
  ///
  /// In en, this message translates to:
  /// **'Adjust later'**
  String get goalSetupWorkdayFlexible;

  /// No description provided for @goalScheduleBedtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target bedtime'**
  String get goalScheduleBedtimeLabel;

  /// No description provided for @goalScheduleBedtimeDescription.
  ///
  /// In en, this message translates to:
  /// **'This is the sleep time Rhythm will use as the baseline for recovery suggestions.'**
  String get goalScheduleBedtimeDescription;

  /// No description provided for @goalScheduleWakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target wake time'**
  String get goalScheduleWakeLabel;

  /// No description provided for @goalScheduleWakeDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep a clear gap from your bedtime so the target window remains meaningful.'**
  String get goalScheduleWakeDescription;

  /// No description provided for @goalScheduleLateThresholdLabel.
  ///
  /// In en, this message translates to:
  /// **'Late threshold'**
  String get goalScheduleLateThresholdLabel;

  /// No description provided for @goalScheduleLateThresholdDescription.
  ///
  /// In en, this message translates to:
  /// **'Used later to decide when a night counts as staying up late.'**
  String get goalScheduleLateThresholdDescription;

  /// No description provided for @goalScheduleDayStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Day start'**
  String get goalScheduleDayStartLabel;

  /// No description provided for @goalScheduleDayStartDescription.
  ///
  /// In en, this message translates to:
  /// **'Used later to group logs that cross midnight into the same day boundary.'**
  String get goalScheduleDayStartDescription;

  /// No description provided for @goalScheduleWakeSameAsBedtimeError.
  ///
  /// In en, this message translates to:
  /// **'Wake time cannot be the same as target bedtime.'**
  String get goalScheduleWakeSameAsBedtimeError;

  /// Formats minute values used in onboarding form summaries.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String goalScheduleMinutesValue(int minutes);

  /// No description provided for @reminderSetupEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Set reminders just right'**
  String get reminderSetupEyebrow;

  /// No description provided for @reminderSetupPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Default to soft reminders and avoid nonstop interruption.'**
  String get reminderSetupPageTitle;

  /// No description provided for @reminderSetupPageDescription.
  ///
  /// In en, this message translates to:
  /// **'You can start light and decide later whether you need stronger on-time reminders.'**
  String get reminderSetupPageDescription;

  /// No description provided for @reminderSetupCompleteButton.
  ///
  /// In en, this message translates to:
  /// **'Finish setup and open Today'**
  String get reminderSetupCompleteButton;

  /// No description provided for @reminderSoftReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Soft reminder'**
  String get reminderSoftReminderTitle;

  /// No description provided for @reminderSoftReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'A low-pressure nudge before you drift too far from tonight’s plan.'**
  String get reminderSoftReminderDescription;

  /// No description provided for @reminderTargetReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'On-time reminder'**
  String get reminderTargetReminderTitle;

  /// No description provided for @reminderTargetReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'A stronger reminder when it is time to start winding down.'**
  String get reminderTargetReminderDescription;

  /// No description provided for @reminderWeeklyReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly recap'**
  String get reminderWeeklyReportTitle;

  /// No description provided for @reminderWeeklyReportDescription.
  ///
  /// In en, this message translates to:
  /// **'A weekly summary that helps you review whether the routine is becoming steadier.'**
  String get reminderWeeklyReportDescription;

  /// No description provided for @reminderLeadTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder lead time'**
  String get reminderLeadTimeTitle;

  /// No description provided for @reminderLeadHintTitle.
  ///
  /// In en, this message translates to:
  /// **'Lead time suggestion'**
  String get reminderLeadHintTitle;

  /// No description provided for @reminderLeadHintEarly.
  ///
  /// In en, this message translates to:
  /// **'15 min'**
  String get reminderLeadHintEarly;

  /// No description provided for @reminderLeadHintRecommended.
  ///
  /// In en, this message translates to:
  /// **'30 min'**
  String get reminderLeadHintRecommended;

  /// No description provided for @reminderLeadHintMinimal.
  ///
  /// In en, this message translates to:
  /// **'45 min'**
  String get reminderLeadHintMinimal;

  /// Formats reminder lead time values in the onboarding reminder summary.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes before target bedtime'**
  String reminderLeadTimeValue(int minutes);

  /// No description provided for @bedtimePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Bedtime mode'**
  String get bedtimePageTitle;

  /// No description provided for @bedtimeCountdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Tonight target'**
  String get bedtimeCountdownTitle;

  /// No description provided for @bedtimeCurrentTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get bedtimeCurrentTimeLabel;

  /// No description provided for @bedtimeTargetTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get bedtimeTargetTimeLabel;

  /// No description provided for @bedtimeTargetDiffAhead.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes until your target bedtime'**
  String bedtimeTargetDiffAhead(int minutes);

  /// No description provided for @bedtimeTargetDiffLate.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes past your target bedtime'**
  String bedtimeTargetDiffLate(int minutes);

  /// No description provided for @bedtimeStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'How is tonight feeling?'**
  String get bedtimeStatusTitle;

  /// No description provided for @bedtimeStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready to sleep'**
  String get bedtimeStatusReady;

  /// No description provided for @bedtimeStatusMoreTime.
  ///
  /// In en, this message translates to:
  /// **'I want a bit more time'**
  String get bedtimeStatusMoreTime;

  /// No description provided for @bedtimeStatusLikelyLate.
  ///
  /// In en, this message translates to:
  /// **'I will probably sleep late tonight'**
  String get bedtimeStatusLikelyLate;

  /// No description provided for @bedtimeActionTitle.
  ///
  /// In en, this message translates to:
  /// **'A lighter next step'**
  String get bedtimeActionTitle;

  /// No description provided for @bedtimeActionDimLights.
  ///
  /// In en, this message translates to:
  /// **'Dim the lights a bit first'**
  String get bedtimeActionDimLights;

  /// No description provided for @bedtimeActionPutPhoneAway.
  ///
  /// In en, this message translates to:
  /// **'Put the phone away for now'**
  String get bedtimeActionPutPhoneAway;

  /// No description provided for @bedtimeActionTenMinuteWrapUp.
  ///
  /// In en, this message translates to:
  /// **'Give yourself 10 minutes to wrap up'**
  String get bedtimeActionTenMinuteWrapUp;

  /// No description provided for @bedtimeActionCloseTonight.
  ///
  /// In en, this message translates to:
  /// **'Close tonight as soon as you can'**
  String get bedtimeActionCloseTonight;

  /// No description provided for @bedtimeActionPlanRecoveryTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Plan a lighter recovery step for tomorrow morning'**
  String get bedtimeActionPlanRecoveryTomorrow;

  /// No description provided for @bedtimeGoalMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Set tonight’s target first'**
  String get bedtimeGoalMissingTitle;

  /// No description provided for @bedtimeGoalMissingDescription.
  ///
  /// In en, this message translates to:
  /// **'Bedtime mode needs your target schedule before it can calculate tonight’s countdown.'**
  String get bedtimeGoalMissingDescription;

  /// No description provided for @bedtimeGoalMissingButton.
  ///
  /// In en, this message translates to:
  /// **'Set your schedule goal'**
  String get bedtimeGoalMissingButton;

  /// No description provided for @commonCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancelButton;

  /// No description provided for @commonConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirmButton;

  /// No description provided for @accountSyncPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep it local first, sync later'**
  String get accountSyncPageTitle;

  /// No description provided for @accountSyncPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign-in is for restoring across devices, keeping membership in sync, and recovering your session later.'**
  String get accountSyncPageDescription;

  /// No description provided for @accountSyncCurrentIdentityTitle.
  ///
  /// In en, this message translates to:
  /// **'Current identity'**
  String get accountSyncCurrentIdentityTitle;

  /// No description provided for @accountSyncSyncStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync status'**
  String get accountSyncSyncStatusTitle;

  /// No description provided for @accountSyncConflictPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Conflict policy'**
  String get accountSyncConflictPolicyTitle;

  /// No description provided for @accountSyncConflictPolicyDescription.
  ///
  /// In en, this message translates to:
  /// **'Manual changes made by you take priority, while source and update time are still preserved.'**
  String get accountSyncConflictPolicyDescription;

  /// No description provided for @accountSyncIdentityAnonymousTitle.
  ///
  /// In en, this message translates to:
  /// **'Anonymous user'**
  String get accountSyncIdentityAnonymousTitle;

  /// No description provided for @accountSyncIdentityAnonymousDescription.
  ///
  /// In en, this message translates to:
  /// **'Local-first mode is active. You can bind an account any time.'**
  String get accountSyncIdentityAnonymousDescription;

  /// No description provided for @accountSyncIdentitySignInRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Local-first mode is active. Sign in when you are ready to restore multi-device sync.'**
  String get accountSyncIdentitySignInRequiredDescription;

  /// No description provided for @accountSyncIdentityLinkedFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Account linked'**
  String get accountSyncIdentityLinkedFallbackTitle;

  /// No description provided for @accountSyncIdentityLinkedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account is linked and the cloud session can be restored later.'**
  String get accountSyncIdentityLinkedDescription;

  /// No description provided for @accountSyncIdentityConnectedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account is linked and the cloud session is active.'**
  String get accountSyncIdentityConnectedDescription;

  /// No description provided for @accountSyncBindAppleButton.
  ///
  /// In en, this message translates to:
  /// **'Link Apple account'**
  String get accountSyncBindAppleButton;

  /// No description provided for @accountSyncViewAccountButton.
  ///
  /// In en, this message translates to:
  /// **'View account status'**
  String get accountSyncViewAccountButton;

  /// No description provided for @accountSyncCloudIdentityPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync identity is not ready yet'**
  String get accountSyncCloudIdentityPendingTitle;

  /// No description provided for @accountSyncCloudIdentityReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync identity is ready'**
  String get accountSyncCloudIdentityReadyTitle;

  /// No description provided for @accountSyncCloudIdentityPendingButton.
  ///
  /// In en, this message translates to:
  /// **'Create cloud sync identity'**
  String get accountSyncCloudIdentityPendingButton;

  /// No description provided for @accountSyncCloudIdentityReadyButton.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync identity is ready'**
  String get accountSyncCloudIdentityReadyButton;

  /// No description provided for @accountSyncLocalOnlyDescription.
  ///
  /// In en, this message translates to:
  /// **'This build is staying in local-first mode right now, so no cloud sync has been triggered.'**
  String get accountSyncLocalOnlyDescription;

  /// No description provided for @accountSyncSignInRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync starts only after sign-in. Your current device data will stay here until then.'**
  String get accountSyncSignInRequiredDescription;

  /// No description provided for @accountSyncFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'The latest cloud sync failed. You can retry later and keep using local data for now.'**
  String get accountSyncFailedDescription;

  /// No description provided for @accountSyncSyncedDescription.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync is enabled'**
  String get accountSyncSyncedDescription;

  /// No description provided for @accountSyncRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry sync'**
  String get accountSyncRetryButton;

  /// No description provided for @accountSyncLastSyncedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last synced: '**
  String get accountSyncLastSyncedLabel;

  /// No description provided for @accountSyncUnavailableError.
  ///
  /// In en, this message translates to:
  /// **'Account and sync status is temporarily unavailable'**
  String get accountSyncUnavailableError;

  /// No description provided for @profileHeroAnonymousTitle.
  ///
  /// In en, this message translates to:
  /// **'Anonymous user'**
  String get profileHeroAnonymousTitle;

  /// No description provided for @profileHeroAnonymousSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Local first ? You can bind an account later'**
  String get profileHeroAnonymousSubtitle;

  /// No description provided for @profileHeroBadgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get profileHeroBadgeLabel;

  /// No description provided for @profileMembershipEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Membership center'**
  String get profileMembershipEntryTitle;

  /// No description provided for @profileMembershipEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock recovery plan details, long-term history, and monthly reports'**
  String get profileMembershipEntrySubtitle;

  /// No description provided for @profileGoalScheduleEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal schedule settings'**
  String get profileGoalScheduleEntryTitle;

  /// No description provided for @profileGoalScheduleEntryEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have not saved a goal schedule yet'**
  String get profileGoalScheduleEntryEmpty;

  /// No description provided for @profileGoalScheduleEntryLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading your goal schedule'**
  String get profileGoalScheduleEntryLoading;

  /// No description provided for @profileGoalScheduleEntryError.
  ///
  /// In en, this message translates to:
  /// **'Goal schedule is temporarily unavailable'**
  String get profileGoalScheduleEntryError;

  /// No description provided for @profileNotificationEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder settings'**
  String get profileNotificationEntryTitle;

  /// No description provided for @profileNotificationEntryEnabled.
  ///
  /// In en, this message translates to:
  /// **'Soft reminders are enabled'**
  String get profileNotificationEntryEnabled;

  /// No description provided for @profileNotificationEntryDisabled.
  ///
  /// In en, this message translates to:
  /// **'Reminder strategy still needs adjustment'**
  String get profileNotificationEntryDisabled;

  /// No description provided for @profileDataAccessEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Data access and permissions'**
  String get profileDataAccessEntryTitle;

  /// No description provided for @profileDataAccessEntryLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading access status'**
  String get profileDataAccessEntryLoading;

  /// No description provided for @profileDataAccessEntryError.
  ///
  /// In en, this message translates to:
  /// **'Access status is temporarily unavailable'**
  String get profileDataAccessEntryError;

  /// No description provided for @profileTimezoneModeEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Timezone and special modes'**
  String get profileTimezoneModeEntryTitle;

  /// No description provided for @profileTimezoneModeEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{timezone} ? Special mode notes'**
  String profileTimezoneModeEntrySubtitle(String timezone);

  /// No description provided for @profilePrivacyEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data'**
  String get profilePrivacyEntryTitle;

  /// No description provided for @profilePrivacyEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export, delete, and agreements'**
  String get profilePrivacyEntrySubtitle;

  /// No description provided for @profilePreferencesCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profilePreferencesCardTitle;

  /// No description provided for @profilePreferencesLocaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profilePreferencesLocaleTitle;

  /// No description provided for @profilePreferencesThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profilePreferencesThemeTitle;

  /// No description provided for @profilePreferencesFollowSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get profilePreferencesFollowSystem;

  /// No description provided for @profilePreferencesSystemShort.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get profilePreferencesSystemShort;

  /// No description provided for @profilePreferencesSimplifiedChinese.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get profilePreferencesSimplifiedChinese;

  /// No description provided for @profilePreferencesSimplifiedChineseNative.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get profilePreferencesSimplifiedChineseNative;

  /// No description provided for @profilePreferencesEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profilePreferencesEnglish;

  /// No description provided for @profilePreferencesLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profilePreferencesLight;

  /// No description provided for @profilePreferencesDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profilePreferencesDark;

  /// No description provided for @profilePreferencesSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Preferences could not be saved. Please try again later.'**
  String get profilePreferencesSaveFailed;

  /// No description provided for @profileDesktopPresenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Desktop presence'**
  String get profileDesktopPresenceTitle;

  /// No description provided for @profileDesktopPresenceDescription.
  ///
  /// In en, this message translates to:
  /// **'If you place the widget on your home screen, tonight\'s goal and last night\'s status stay visible in your everyday view.'**
  String get profileDesktopPresenceDescription;

  /// No description provided for @widgetGuideEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Put tonight\'\'s target on your home screen'**
  String get widgetGuideEyebrow;

  /// No description provided for @widgetGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep bedtime one step closer instead of opening the app every time.'**
  String get widgetGuideTitle;

  /// No description provided for @widgetGuideDescription.
  ///
  /// In en, this message translates to:
  /// **'The widget only shows what matters: tonight\'s target, the remaining time, and last night\'s status.'**
  String get widgetGuideDescription;

  /// No description provided for @widgetGuidePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Rhythm widget'**
  String get widgetGuidePreviewTitle;

  /// No description provided for @widgetGuidePreviewRemaining.
  ///
  /// In en, this message translates to:
  /// **'52m to target'**
  String get widgetGuidePreviewRemaining;

  /// No description provided for @widgetGuidePreviewSummary.
  ///
  /// In en, this message translates to:
  /// **'Tonight target 23:30\nLast night was 26 minutes late'**
  String get widgetGuidePreviewSummary;

  /// No description provided for @widgetGuideStepAdd.
  ///
  /// In en, this message translates to:
  /// **'• Long-press the home screen and add a widget'**
  String get widgetGuideStepAdd;

  /// No description provided for @widgetGuideStepChoose.
  ///
  /// In en, this message translates to:
  /// **'• Search for Rhythm and choose the medium widget'**
  String get widgetGuideStepChoose;

  /// No description provided for @widgetGuideStepPlace.
  ///
  /// In en, this message translates to:
  /// **'• Put it where you usually see it at night'**
  String get widgetGuideStepPlace;

  /// No description provided for @widgetGuidePrimaryButton.
  ///
  /// In en, this message translates to:
  /// **'Got it, I\'\'ll add it later'**
  String get widgetGuidePrimaryButton;

  /// No description provided for @widgetThemePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Widget and theme'**
  String get widgetThemePageTitle;

  /// No description provided for @widgetThemeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Get the presence right first'**
  String get widgetThemeHeroTitle;

  /// No description provided for @widgetThemeHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'V0.1 keeps theme support lightweight for now. The widget ships first.'**
  String get widgetThemeHeroDescription;

  /// No description provided for @widgetThemePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Home screen preview'**
  String get widgetThemePreviewTitle;

  /// No description provided for @widgetThemePreviewTargetCaption.
  ///
  /// In en, this message translates to:
  /// **'Tonight target'**
  String get widgetThemePreviewTargetCaption;

  /// No description provided for @widgetThemePreviewLastNightMissing.
  ///
  /// In en, this message translates to:
  /// **'There is no record from last night yet'**
  String get widgetThemePreviewLastNightMissing;

  /// No description provided for @widgetThemeMinutesToTargetAhead.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes to target'**
  String widgetThemeMinutesToTargetAhead(int minutes);

  /// No description provided for @widgetThemeMinutesToTargetLate.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes past target'**
  String widgetThemeMinutesToTargetLate(int minutes);

  /// No description provided for @widgetThemeStateGoalMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'No goal schedule yet'**
  String get widgetThemeStateGoalMissingTitle;

  /// No description provided for @widgetThemeStateGoalMissingDescription.
  ///
  /// In en, this message translates to:
  /// **'Set a goal schedule first so the widget knows which bedtime reference to keep visible tonight.'**
  String get widgetThemeStateGoalMissingDescription;

  /// No description provided for @widgetThemeStateGoalMissingAction.
  ///
  /// In en, this message translates to:
  /// **'Set your schedule goal'**
  String get widgetThemeStateGoalMissingAction;

  /// No description provided for @widgetThemeStateNoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'There is no record from last night yet'**
  String get widgetThemeStateNoDataTitle;

  /// No description provided for @widgetThemeStateNoDataDescription.
  ///
  /// In en, this message translates to:
  /// **'The widget can still keep tonight\'s target visible, then fill in last night\'s status after you sync or add it.'**
  String get widgetThemeStateNoDataDescription;

  /// No description provided for @widgetThemeStateNoDataAction.
  ///
  /// In en, this message translates to:
  /// **'Manually log last night'**
  String get widgetThemeStateNoDataAction;

  /// No description provided for @widgetThemeStatePermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep data permission is still needed'**
  String get widgetThemeStatePermissionTitle;

  /// No description provided for @widgetThemeStatePermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'The widget only shows essential information and never expands raw sleep details.'**
  String get widgetThemeStatePermissionDescription;

  /// No description provided for @widgetThemeStatePermissionAction.
  ///
  /// In en, this message translates to:
  /// **'Review data access'**
  String get widgetThemeStatePermissionAction;

  /// No description provided for @widgetThemeStateReadyDescription.
  ///
  /// In en, this message translates to:
  /// **'The current home screen snapshot is ready to show tonight\'s target and last night\'s status.'**
  String get widgetThemeStateReadyDescription;

  /// No description provided for @widgetThemeReserveTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme reserve'**
  String get widgetThemeReserveTitle;

  /// No description provided for @widgetThemeOptionDefault.
  ///
  /// In en, this message translates to:
  /// **'Default morning haze'**
  String get widgetThemeOptionDefault;

  /// No description provided for @widgetThemeOptionNight.
  ///
  /// In en, this message translates to:
  /// **'Midnight stillness'**
  String get widgetThemeOptionNight;

  /// No description provided for @widgetThemeOptionFuture.
  ///
  /// In en, this message translates to:
  /// **'More later'**
  String get widgetThemeOptionFuture;

  /// No description provided for @widgetThemeRefreshButton.
  ///
  /// In en, this message translates to:
  /// **'Refresh widget snapshot'**
  String get widgetThemeRefreshButton;

  /// No description provided for @widgetThemeRefreshingButton.
  ///
  /// In en, this message translates to:
  /// **'Refreshing widget snapshot'**
  String get widgetThemeRefreshingButton;

  /// No description provided for @widgetThemeRefreshSuccess.
  ///
  /// In en, this message translates to:
  /// **'Widget snapshot refreshed'**
  String get widgetThemeRefreshSuccess;

  /// No description provided for @widgetThemeRefreshFailure.
  ///
  /// In en, this message translates to:
  /// **'Refresh failed. Please try again later.'**
  String get widgetThemeRefreshFailure;

  /// No description provided for @widgetThemeOpenTodayButton.
  ///
  /// In en, this message translates to:
  /// **'Open Today'**
  String get widgetThemeOpenTodayButton;

  /// No description provided for @widgetThemeOpenBedtimeButton.
  ///
  /// In en, this message translates to:
  /// **'Enter Bedtime'**
  String get widgetThemeOpenBedtimeButton;

  /// No description provided for @widgetSnapshotLastNightLate.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes later last night'**
  String widgetSnapshotLastNightLate(int minutes);

  /// No description provided for @widgetSnapshotLastNightEarly.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes earlier last night'**
  String widgetSnapshotLastNightEarly(int minutes);

  /// No description provided for @widgetSnapshotLastNightOnTime.
  ///
  /// In en, this message translates to:
  /// **'Right on time last night'**
  String get widgetSnapshotLastNightOnTime;

  /// No description provided for @commonRecordSourceHealthKit.
  ///
  /// In en, this message translates to:
  /// **'HealthKit'**
  String get commonRecordSourceHealthKit;

  /// No description provided for @commonRecordSourceHealthConnect.
  ///
  /// In en, this message translates to:
  /// **'Health Connect'**
  String get commonRecordSourceHealthConnect;

  /// No description provided for @commonRecordSourceManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get commonRecordSourceManual;

  /// No description provided for @commonRecordSourceImported.
  ///
  /// In en, this message translates to:
  /// **'Imported'**
  String get commonRecordSourceImported;

  /// No description provided for @commonConfidenceHigh.
  ///
  /// In en, this message translates to:
  /// **'High confidence'**
  String get commonConfidenceHigh;

  /// No description provided for @commonConfidenceMedium.
  ///
  /// In en, this message translates to:
  /// **'Usable'**
  String get commonConfidenceMedium;

  /// No description provided for @commonConfidenceLow.
  ///
  /// In en, this message translates to:
  /// **'Low confidence'**
  String get commonConfidenceLow;

  /// No description provided for @commonConfidenceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown confidence'**
  String get commonConfidenceUnknown;

  /// No description provided for @profileHealthSummaryHealthKitConnected.
  ///
  /// In en, this message translates to:
  /// **'HealthKit connected'**
  String get profileHealthSummaryHealthKitConnected;

  /// No description provided for @profileHealthSummaryHealthConnectConnected.
  ///
  /// In en, this message translates to:
  /// **'Health Connect connected'**
  String get profileHealthSummaryHealthConnectConnected;

  /// No description provided for @profileHealthSummaryPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission needs to be granted again'**
  String get profileHealthSummaryPermissionRequired;

  /// No description provided for @profileHealthSummaryManualFallback.
  ///
  /// In en, this message translates to:
  /// **'Manual mode is active for now'**
  String get profileHealthSummaryManualFallback;

  /// No description provided for @dataAccessPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Health data access status'**
  String get dataAccessPageTitle;

  /// No description provided for @dataAccessPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatic records speed things up. Manual entry is the fallback path.'**
  String get dataAccessPageDescription;

  /// No description provided for @dataAccessReauthorizeButton.
  ///
  /// In en, this message translates to:
  /// **'Reauthorize'**
  String get dataAccessReauthorizeButton;

  /// No description provided for @dataAccessManualModeButton.
  ///
  /// In en, this message translates to:
  /// **'Use manual mode'**
  String get dataAccessManualModeButton;

  /// No description provided for @dataAccessStatusHealthKitConnected.
  ///
  /// In en, this message translates to:
  /// **'HealthKit connected'**
  String get dataAccessStatusHealthKitConnected;

  /// No description provided for @dataAccessStatusHealthConnectConnected.
  ///
  /// In en, this message translates to:
  /// **'Health Connect connected'**
  String get dataAccessStatusHealthConnectConnected;

  /// No description provided for @dataAccessStatusInstallRequired.
  ///
  /// In en, this message translates to:
  /// **'Health Connect is required'**
  String get dataAccessStatusInstallRequired;

  /// No description provided for @dataAccessStatusPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission needs to be granted again'**
  String get dataAccessStatusPermissionRequired;

  /// No description provided for @dataAccessStatusManualFallback.
  ///
  /// In en, this message translates to:
  /// **'Manual mode is active for now'**
  String get dataAccessStatusManualFallback;

  /// No description provided for @dataAccessStatusConnectedDescription.
  ///
  /// In en, this message translates to:
  /// **'{count} records were written in the last 30 days.'**
  String dataAccessStatusConnectedDescription(int count);

  /// No description provided for @dataAccessStatusInstallRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Health Connect is not installed on this device yet. Install it before automatic sleep syncing can continue.'**
  String get dataAccessStatusInstallRequiredDescription;

  /// No description provided for @dataAccessStatusPermissionRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Sleep data permission is missing right now. Reauthorize to resume automatic reading.'**
  String get dataAccessStatusPermissionRequiredDescription;

  /// No description provided for @dataAccessStatusManualFallbackDescription.
  ///
  /// In en, this message translates to:
  /// **'If this device cannot provide automatic sleep data, you can still keep logging nights manually and reviewing your trend.'**
  String get dataAccessStatusManualFallbackDescription;

  /// No description provided for @goalScheduleSettingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune your reference line'**
  String get goalScheduleSettingsPageTitle;

  /// No description provided for @goalScheduleSettingsPageDescription.
  ///
  /// In en, this message translates to:
  /// **'The closer the target is to real life, the more useful the feedback becomes.'**
  String get goalScheduleSettingsPageDescription;

  /// No description provided for @goalScheduleSettingsSummaryBedtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target bedtime'**
  String get goalScheduleSettingsSummaryBedtimeLabel;

  /// No description provided for @goalScheduleSettingsSummaryWakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target wake time'**
  String get goalScheduleSettingsSummaryWakeLabel;

  /// No description provided for @goalScheduleSettingsSummaryLateThresholdLabel.
  ///
  /// In en, this message translates to:
  /// **'Late threshold'**
  String get goalScheduleSettingsSummaryLateThresholdLabel;

  /// No description provided for @goalScheduleSettingsSummaryDayStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Day start'**
  String get goalScheduleSettingsSummaryDayStartLabel;

  /// No description provided for @goalScheduleSettingsHintDescription.
  ///
  /// In en, this message translates to:
  /// **'If you have missed the target often in the last two weeks, pull the target 10 to 15 minutes closer to reality first and adjust forward later.'**
  String get goalScheduleSettingsHintDescription;

  /// No description provided for @goalScheduleSettingsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get goalScheduleSettingsSaveButton;

  /// No description provided for @notificationSettingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep reminders gentle'**
  String get notificationSettingsPageTitle;

  /// No description provided for @notificationSettingsPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Guide first, and avoid turning reminders into high-pressure supervision.'**
  String get notificationSettingsPageDescription;

  /// No description provided for @notificationSettingsLeadTitle.
  ///
  /// In en, this message translates to:
  /// **'Lead time'**
  String get notificationSettingsLeadTitle;

  /// No description provided for @notificationSettingsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save reminder strategy'**
  String get notificationSettingsSaveButton;

  /// No description provided for @privacyDataPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Sensitive data should stay clear and controllable'**
  String get privacyDataPageTitle;

  /// No description provided for @privacyDataPageDescription.
  ///
  /// In en, this message translates to:
  /// **'We explain what will happen first, then let you decide whether to continue.'**
  String get privacyDataPageDescription;

  /// No description provided for @privacyDataPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyDataPolicyTitle;

  /// No description provided for @privacyDataPolicyDescription.
  ///
  /// In en, this message translates to:
  /// **'See how your data is stored and used'**
  String get privacyDataPolicyDescription;

  /// No description provided for @privacyDataPolicyDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'The current version stores goals, records, tags, and reminder settings locally, and does not use your data for advertising.'**
  String get privacyDataPolicyDialogMessage;

  /// No description provided for @privacyDataExportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get privacyDataExportTitle;

  /// No description provided for @privacyDataExportDescription.
  ///
  /// In en, this message translates to:
  /// **'Export goals, records, tags, and weekly summaries'**
  String get privacyDataExportDescription;

  /// No description provided for @privacyDataExportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm data export'**
  String get privacyDataExportDialogTitle;

  /// No description provided for @privacyDataExportDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'The export will include your goal schedule, sleep records, tags, and weekly summaries. Confirm to continue.'**
  String get privacyDataExportDialogMessage;

  /// No description provided for @privacyDataDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get privacyDataDeleteAccountTitle;

  /// No description provided for @privacyDataDeleteAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Remove the cloud account and sync relationship'**
  String get privacyDataDeleteAccountDescription;

  /// No description provided for @privacyDataDeleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm account deletion'**
  String get privacyDataDeleteAccountDialogTitle;

  /// No description provided for @privacyDataDeleteAccountDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Deleting the account disconnects this device from cloud sync. Local data will not be restored automatically.'**
  String get privacyDataDeleteAccountDialogMessage;

  /// No description provided for @privacyDataClearLocalTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear local data'**
  String get privacyDataClearLocalTitle;

  /// No description provided for @privacyDataClearLocalDescription.
  ///
  /// In en, this message translates to:
  /// **'Only clear data stored on this device'**
  String get privacyDataClearLocalDescription;

  /// No description provided for @privacyDataClearLocalDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm local data clear'**
  String get privacyDataClearLocalDialogTitle;

  /// No description provided for @privacyDataClearLocalDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Clearing local data removes cached goals, records, and tags from this device. Please confirm again before continuing.'**
  String get privacyDataClearLocalDialogMessage;

  /// No description provided for @privacyDataDangerCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dangerous actions always need a second confirmation'**
  String get privacyDataDangerCardTitle;

  /// No description provided for @privacyDataDangerCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Deleting an account and clearing data must go through a confirmation dialog. They never run directly from a plain list tap.'**
  String get privacyDataDangerCardDescription;

  /// No description provided for @timezoneModePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep boundaries clear before expanding support'**
  String get timezoneModePageTitle;

  /// No description provided for @timezoneModePageDescription.
  ///
  /// In en, this message translates to:
  /// **'V0.1 does not implement a full shift-work flow yet, but the page still explains the current boundaries clearly.'**
  String get timezoneModePageDescription;

  /// No description provided for @timezoneModeCurrentTimezoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Current timezone'**
  String get timezoneModeCurrentTimezoneTitle;

  /// No description provided for @timezoneModeCurrentTimezoneDescription.
  ///
  /// In en, this message translates to:
  /// **'Each record keeps the timezone from when the event happened, so older records are not reassigned to a new day when you switch timezones later.'**
  String get timezoneModeCurrentTimezoneDescription;

  /// No description provided for @timezoneModeSpecialModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Special modes'**
  String get timezoneModeSpecialModeTitle;

  /// No description provided for @timezoneModeCrossTimezoneDescription.
  ///
  /// In en, this message translates to:
  /// **'? Cross-timezone mode: when a timezone change is detected, Rhythm reminds you to confirm whether the goal needs a temporary adjustment.'**
  String get timezoneModeCrossTimezoneDescription;

  /// No description provided for @timezoneModeShiftWorkDescription.
  ///
  /// In en, this message translates to:
  /// **'? Shift-work mode: V0.1 only shows placeholder guidance for now and does not participate in the default on-track calculation.'**
  String get timezoneModeShiftWorkDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
