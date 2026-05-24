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
