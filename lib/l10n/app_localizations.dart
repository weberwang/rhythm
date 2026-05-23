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
  /// **'Choose how you want to enter'**
  String get onboardingAuthTitle;

  /// No description provided for @onboardingAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'You can start anonymously now and decide later whether to connect an Apple or Google account.'**
  String get onboardingAuthDescription;

  /// No description provided for @onboardingAuthAppleLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get onboardingAuthAppleLabel;

  /// No description provided for @onboardingAuthAppleDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep the designed account entry visible while leaving the real SDK integration for a later task.'**
  String get onboardingAuthAppleDescription;

  /// No description provided for @onboardingAuthGoogleLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get onboardingAuthGoogleLabel;

  /// No description provided for @onboardingAuthGoogleDescription.
  ///
  /// In en, this message translates to:
  /// **'Show the intended flow option first, then connect the real login implementation later.'**
  String get onboardingAuthGoogleDescription;

  /// No description provided for @onboardingAuthAnonymousButton.
  ///
  /// In en, this message translates to:
  /// **'Continue anonymously'**
  String get onboardingAuthAnonymousButton;

  /// No description provided for @onboardingAuthLaterButton.
  ///
  /// In en, this message translates to:
  /// **'Connect later'**
  String get onboardingAuthLaterButton;

  /// No description provided for @onboardingStepThreeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Step 3 / 3'**
  String get onboardingStepThreeEyebrow;

  /// No description provided for @onboardingHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect health data for fuller records'**
  String get onboardingHealthTitle;

  /// No description provided for @onboardingHealthDescription.
  ///
  /// In en, this message translates to:
  /// **'Rhythm will eventually use your existing sleep and activity data to help you review routine changes more steadily.'**
  String get onboardingHealthDescription;

  /// No description provided for @onboardingHealthAppleSummary.
  ///
  /// In en, this message translates to:
  /// **'You just chose the Apple entry. You can finish account binding later.'**
  String get onboardingHealthAppleSummary;

  /// No description provided for @onboardingHealthGoogleSummary.
  ///
  /// In en, this message translates to:
  /// **'You just chose the Google entry. You can finish account binding later.'**
  String get onboardingHealthGoogleSummary;

  /// No description provided for @onboardingHealthAnonymousSummary.
  ///
  /// In en, this message translates to:
  /// **'You are entering anonymously now and can still bind an account later in settings.'**
  String get onboardingHealthAnonymousSummary;

  /// No description provided for @onboardingHealthDefaultSummary.
  ///
  /// In en, this message translates to:
  /// **'You can first understand what health records help with before deciding whether to authorize.'**
  String get onboardingHealthDefaultSummary;

  /// No description provided for @onboardingHealthBenefitTitle.
  ///
  /// In en, this message translates to:
  /// **'Why it helps'**
  String get onboardingHealthBenefitTitle;

  /// No description provided for @onboardingHealthBenefitDescription.
  ///
  /// In en, this message translates to:
  /// **'Once health data is connected in a later task, you can reduce manual logging and review trends with better continuity.'**
  String get onboardingHealthBenefitDescription;

  /// No description provided for @onboardingHealthCurrentStageTitle.
  ///
  /// In en, this message translates to:
  /// **'What happens in this stage'**
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
  /// **'Authorize and continue'**
  String get onboardingHealthAuthorizeButton;

  /// No description provided for @goalSetupEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Goal setup'**
  String get goalSetupEyebrow;

  /// No description provided for @goalSetupPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your target routine'**
  String get goalSetupPageTitle;

  /// No description provided for @goalSetupPageDescription.
  ///
  /// In en, this message translates to:
  /// **'This MVP keeps the form lightweight and locks the first target schedule before reminder preferences are confirmed.'**
  String get goalSetupPageDescription;

  /// No description provided for @goalSetupContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Save goal and continue'**
  String get goalSetupContinueButton;

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
  /// **'Reminder setup'**
  String get reminderSetupEyebrow;

  /// No description provided for @reminderSetupPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your reminder strategy'**
  String get reminderSetupPageTitle;

  /// No description provided for @reminderSetupPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Finish the first-run setup by confirming how gentle nudges should support your target schedule.'**
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

  /// Formats reminder lead time values in the onboarding reminder summary.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes before target bedtime'**
  String reminderLeadTimeValue(int minutes);
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
