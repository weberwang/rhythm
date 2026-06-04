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

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Rhythm'**
  String get appTitle;

  /// No description provided for @launchLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Preparing your rhythm'**
  String get launchLoadingTitle;

  /// No description provided for @launchLoadingBody.
  ///
  /// In en, this message translates to:
  /// **'Bootstrapping the local-first baseline and route host.'**
  String get launchLoadingBody;

  /// No description provided for @launchErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Startup needs attention'**
  String get launchErrorTitle;

  /// No description provided for @launchErrorBody.
  ///
  /// In en, this message translates to:
  /// **'The initialization baseline could not be prepared. Try again.'**
  String get launchErrorBody;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Onboarding activation'**
  String get onboardingTitle;

  /// No description provided for @onboardingBody.
  ///
  /// In en, this message translates to:
  /// **'Initialization keeps the onboarding route ready, but the full activation flow will be implemented in the next stage.'**
  String get onboardingBody;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter app shell'**
  String get onboardingContinue;

  /// No description provided for @onboardingStepCounter.
  ///
  /// In en, this message translates to:
  /// **'Step {current} / {total}'**
  String onboardingStepCounter(int current, int total);

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Rhythm'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Starting tonight, we will help you rebuild a steadier sleep rhythm through a short guided setup.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how to begin'**
  String get onboardingEntryTitle;

  /// No description provided for @onboardingEntryBody.
  ///
  /// In en, this message translates to:
  /// **'Finish the local-first setup first, then decide when to connect sign-in and health permissions.'**
  String get onboardingEntryBody;

  /// No description provided for @onboardingPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Understand the value first'**
  String get onboardingPermissionTitle;

  /// No description provided for @onboardingPermissionBody.
  ///
  /// In en, this message translates to:
  /// **'We will explain what health access can unlock before asking for any real system permission.'**
  String get onboardingPermissionBody;

  /// No description provided for @onboardingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your target schedule'**
  String get onboardingGoalTitle;

  /// No description provided for @onboardingGoalBody.
  ///
  /// In en, this message translates to:
  /// **'Pick the bedtime and wake-up target you want Rhythm to guide you toward first.'**
  String get onboardingGoalBody;

  /// No description provided for @onboardingReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your reminder posture'**
  String get onboardingReminderTitle;

  /// No description provided for @onboardingReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Start with the gentlest reminder strategy that still feels realistic for tonight.'**
  String get onboardingReminderBody;

  /// No description provided for @onboardingCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'You are ready for tonight'**
  String get onboardingCompletionTitle;

  /// No description provided for @onboardingCompletionBody.
  ///
  /// In en, this message translates to:
  /// **'Rhythm has enough context to start the first night without forcing extra setup right now.'**
  String get onboardingCompletionBody;

  /// No description provided for @onboardingStartSetup.
  ///
  /// In en, this message translates to:
  /// **'Start setup'**
  String get onboardingStartSetup;

  /// No description provided for @onboardingContinueSetup.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinueSetup;

  /// No description provided for @onboardingFinishSetup.
  ///
  /// In en, this message translates to:
  /// **'Finish setup'**
  String get onboardingFinishSetup;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingBenefitReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Gentle bedtime reminders'**
  String get onboardingBenefitReminderTitle;

  /// No description provided for @onboardingBenefitReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Build a calmer transition into night without turning reminders into pressure.'**
  String get onboardingBenefitReminderBody;

  /// No description provided for @onboardingBenefitRoutineTitle.
  ///
  /// In en, this message translates to:
  /// **'Wind-down routines that stick'**
  String get onboardingBenefitRoutineTitle;

  /// No description provided for @onboardingBenefitRoutineBody.
  ///
  /// In en, this message translates to:
  /// **'Keep the setup lightweight so your routine feels repeatable, not overwhelming.'**
  String get onboardingBenefitRoutineBody;

  /// No description provided for @onboardingBenefitTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Track sleep without the stress'**
  String get onboardingBenefitTrackingTitle;

  /// No description provided for @onboardingBenefitTrackingBody.
  ///
  /// In en, this message translates to:
  /// **'Start with clear goals first, then connect richer data when you are ready.'**
  String get onboardingBenefitTrackingBody;

  /// No description provided for @onboardingEntryLocalTitle.
  ///
  /// In en, this message translates to:
  /// **'Start in local-first mode'**
  String get onboardingEntryLocalTitle;

  /// No description provided for @onboardingEntryLocalBody.
  ///
  /// In en, this message translates to:
  /// **'Use Rhythm right away on this device and keep the activation flow simple tonight.'**
  String get onboardingEntryLocalBody;

  /// No description provided for @onboardingEntrySyncLaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up now, sync later'**
  String get onboardingEntrySyncLaterTitle;

  /// No description provided for @onboardingEntrySyncLaterBody.
  ///
  /// In en, this message translates to:
  /// **'Finish the same setup first, then come back for Apple / Google sign-in when needed.'**
  String get onboardingEntrySyncLaterBody;

  /// No description provided for @onboardingHealthValueTitle.
  ///
  /// In en, this message translates to:
  /// **'Health access stays optional for now'**
  String get onboardingHealthValueTitle;

  /// No description provided for @onboardingHealthValueBody.
  ///
  /// In en, this message translates to:
  /// **'This step explains what health data can unlock, but it will not request real system permission yet.'**
  String get onboardingHealthValueBody;

  /// No description provided for @onboardingPermissionBenefitTitle.
  ///
  /// In en, this message translates to:
  /// **'What health access can unlock'**
  String get onboardingPermissionBenefitTitle;

  /// No description provided for @onboardingPermissionBenefitBody.
  ///
  /// In en, this message translates to:
  /// **'It can improve sleep history, confidence labels, and future insights when you decide to connect it.'**
  String get onboardingPermissionBenefitBody;

  /// No description provided for @onboardingPermissionPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'What Rhythm does not read by default'**
  String get onboardingPermissionPrivacyTitle;

  /// No description provided for @onboardingPermissionPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'This activation pass does not request real permission yet, and it does not block local-first setup.'**
  String get onboardingPermissionPrivacyBody;

  /// No description provided for @onboardingPermissionFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'You can still start manually'**
  String get onboardingPermissionFallbackTitle;

  /// No description provided for @onboardingPermissionFallbackBody.
  ///
  /// In en, this message translates to:
  /// **'If you skip health access later, Rhythm will keep working with your manual bedtime goal and follow-up actions.'**
  String get onboardingPermissionFallbackBody;

  /// No description provided for @onboardingBedtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target bedtime'**
  String get onboardingBedtimeLabel;

  /// No description provided for @onboardingWakeTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target wake-up time'**
  String get onboardingWakeTimeLabel;

  /// No description provided for @onboardingGoalHint.
  ///
  /// In en, this message translates to:
  /// **'You can refine this later in settings. The goal here is to leave onboarding with one realistic starting rhythm.'**
  String get onboardingGoalHint;

  /// No description provided for @onboardingReminderGentleTitle.
  ///
  /// In en, this message translates to:
  /// **'Gentle bedtime nudge'**
  String get onboardingReminderGentleTitle;

  /// No description provided for @onboardingReminderGentleBody.
  ///
  /// In en, this message translates to:
  /// **'Start with a softer reminder posture that encourages action without adding pressure.'**
  String get onboardingReminderGentleBody;

  /// No description provided for @onboardingReminderNoneTitle.
  ///
  /// In en, this message translates to:
  /// **'No active reminder yet'**
  String get onboardingReminderNoneTitle;

  /// No description provided for @onboardingReminderNoneBody.
  ///
  /// In en, this message translates to:
  /// **'Finish activation first and decide on reminder timing later in settings.'**
  String get onboardingReminderNoneBody;

  /// No description provided for @onboardingCompletionSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your first-night setup is ready'**
  String get onboardingCompletionSummaryTitle;

  /// No description provided for @onboardingCompletionSummaryBody.
  ///
  /// In en, this message translates to:
  /// **'We will carry this starting rhythm into the app shell, and you can refine the rest after onboarding.'**
  String get onboardingCompletionSummaryBody;

  /// No description provided for @onboardingCompletionScheduleLabel.
  ///
  /// In en, this message translates to:
  /// **'Target schedule'**
  String get onboardingCompletionScheduleLabel;

  /// No description provided for @onboardingCompletionScheduleValue.
  ///
  /// In en, this message translates to:
  /// **'{bedtime} to {wakeTime}'**
  String onboardingCompletionScheduleValue(Object bedtime, Object wakeTime);

  /// No description provided for @onboardingCompletionEntryLabel.
  ///
  /// In en, this message translates to:
  /// **'Entry mode'**
  String get onboardingCompletionEntryLabel;

  /// No description provided for @onboardingCompletionReminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder strategy'**
  String get onboardingCompletionReminderLabel;

  /// No description provided for @tabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// No description provided for @tabBedtime.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get tabBedtime;

  /// No description provided for @tabCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get tabCalendar;

  /// No description provided for @tabInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get tabInsights;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @placeholderStatus.
  ///
  /// In en, this message translates to:
  /// **'Initialization placeholder'**
  String get placeholderStatus;

  /// No description provided for @todayTitle.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayTitle;

  /// No description provided for @todayBody.
  ///
  /// In en, this message translates to:
  /// **'The Today dashboard will consume sleep-data-core contracts in the implementation stage.'**
  String get todayBody;

  /// No description provided for @bedtimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get bedtimeTitle;

  /// No description provided for @bedtimeBody.
  ///
  /// In en, this message translates to:
  /// **'The bedtime focus flow is scaffolded and waiting for module implementation.'**
  String get bedtimeBody;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTitle;

  /// No description provided for @calendarBody.
  ///
  /// In en, this message translates to:
  /// **'Calendar heatmap and day detail experiences will be connected after the data contracts land.'**
  String get calendarBody;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @insightsBody.
  ///
  /// In en, this message translates to:
  /// **'Weekly reports and premium insight widgets are reserved but not implemented yet.'**
  String get insightsBody;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileBody.
  ///
  /// In en, this message translates to:
  /// **'Account, membership, sync, reminder, and privacy settings will be implemented after initialization.'**
  String get profileBody;

  /// No description provided for @globalFeedbackDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get globalFeedbackDismiss;

  /// No description provided for @globalFeedbackSyncFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync paused locally'**
  String get globalFeedbackSyncFailedTitle;

  /// No description provided for @globalFeedbackSyncFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Your recent updates are still stored on this device. Review sync settings when you are ready.'**
  String get globalFeedbackSyncFailedBody;

  /// No description provided for @globalFeedbackTimezoneShiftTitle.
  ///
  /// In en, this message translates to:
  /// **'Timezone confirmation needed'**
  String get globalFeedbackTimezoneShiftTitle;

  /// No description provided for @globalFeedbackTimezoneShiftBody.
  ///
  /// In en, this message translates to:
  /// **'Rhythm will pause sleep interpretation until you confirm the current timezone context.'**
  String get globalFeedbackTimezoneShiftBody;
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
