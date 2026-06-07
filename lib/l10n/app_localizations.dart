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

  /// No description provided for @onboardingWidgetGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Put Rhythm on your home screen for tonight'**
  String get onboardingWidgetGuideTitle;

  /// No description provided for @onboardingWidgetGuideBody.
  ///
  /// In en, this message translates to:
  /// **'A home-screen entry is optional, but it makes it faster to return to the key actions tonight and tomorrow morning.'**
  String get onboardingWidgetGuideBody;

  /// No description provided for @onboardingWidgetGuideBaseTitle.
  ///
  /// In en, this message translates to:
  /// **'This step only explains the value, not a forced setup'**
  String get onboardingWidgetGuideBaseTitle;

  /// No description provided for @onboardingWidgetGuideBaseBody.
  ///
  /// In en, this message translates to:
  /// **'Finish tonight first, then decide later whether your device should pin Rhythm to the home screen.'**
  String get onboardingWidgetGuideBaseBody;

  /// No description provided for @onboardingWidgetGuideSupportedTitle.
  ///
  /// In en, this message translates to:
  /// **'This device can pin the entry directly'**
  String get onboardingWidgetGuideSupportedTitle;

  /// No description provided for @onboardingWidgetGuideSupportedBody.
  ///
  /// In en, this message translates to:
  /// **'When you are ready, you can pin Rhythm to the home screen or widget panel so the next return takes less effort.'**
  String get onboardingWidgetGuideSupportedBody;

  /// No description provided for @onboardingWidgetGuideManualTitle.
  ///
  /// In en, this message translates to:
  /// **'This platform works better with manual setup later'**
  String get onboardingWidgetGuideManualTitle;

  /// No description provided for @onboardingWidgetGuideManualBody.
  ///
  /// In en, this message translates to:
  /// **'Finish activation first. After that, add the Rhythm widget from your home-screen edit mode when you want faster access.'**
  String get onboardingWidgetGuideManualBody;

  /// No description provided for @onboardingWidgetGuideUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'This device does not support home-screen widgets right now'**
  String get onboardingWidgetGuideUnavailableTitle;

  /// No description provided for @onboardingWidgetGuideUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'That does not block the setup tonight. Add a widget later when you return on a supported mobile device.'**
  String get onboardingWidgetGuideUnavailableBody;

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

  /// No description provided for @onboardingEntryAppleTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get onboardingEntryAppleTitle;

  /// No description provided for @onboardingEntryAppleBody.
  ///
  /// In en, this message translates to:
  /// **'Bring your Apple identity into onboarding first, then continue with health access, goal schedule, and sync semantics.'**
  String get onboardingEntryAppleBody;

  /// No description provided for @onboardingEntryGoogleTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get onboardingEntryGoogleTitle;

  /// No description provided for @onboardingEntryGoogleBody.
  ///
  /// In en, this message translates to:
  /// **'Bring your Google identity into onboarding first, then continue with health access, goal schedule, and sync semantics.'**
  String get onboardingEntryGoogleBody;

  /// No description provided for @onboardingEntryAuthCancelledTitle.
  ///
  /// In en, this message translates to:
  /// **'This sign-in was cancelled'**
  String get onboardingEntryAuthCancelledTitle;

  /// No description provided for @onboardingEntryAuthCancelledBody.
  ///
  /// In en, this message translates to:
  /// **'Try again, or switch to the local-first path and finish the setup tonight first.'**
  String get onboardingEntryAuthCancelledBody;

  /// No description provided for @onboardingEntryAuthUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'This sign-in path is unavailable on this device'**
  String get onboardingEntryAuthUnavailableTitle;

  /// No description provided for @onboardingEntryAuthUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'Switch to the local-first path for tonight, then connect your account later on a supported platform.'**
  String get onboardingEntryAuthUnavailableBody;

  /// No description provided for @onboardingEntryAuthFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in could not finish'**
  String get onboardingEntryAuthFailedTitle;

  /// No description provided for @onboardingEntryAuthFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Try once more. If the environment still is not ready, continue with the local-first path for now.'**
  String get onboardingEntryAuthFailedBody;

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

  /// No description provided for @onboardingCompletionHealthLabel.
  ///
  /// In en, this message translates to:
  /// **'Health access'**
  String get onboardingCompletionHealthLabel;

  /// No description provided for @onboardingPermissionStatusGranted.
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get onboardingPermissionStatusGranted;

  /// No description provided for @onboardingPermissionStatusDeferred.
  ///
  /// In en, this message translates to:
  /// **'Decide later'**
  String get onboardingPermissionStatusDeferred;

  /// No description provided for @onboardingPermissionStatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unsupported on this device'**
  String get onboardingPermissionStatusUnavailable;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip onboarding'**
  String get onboardingSkip;

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

  /// No description provided for @todayGreetingNamed.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String todayGreetingNamed(Object name);

  /// No description provided for @todayGreetingGeneric.
  ///
  /// In en, this message translates to:
  /// **'Good morning, start with the rhythm for tonight'**
  String get todayGreetingGeneric;

  /// No description provided for @todayGreetingBody.
  ///
  /// In en, this message translates to:
  /// **'Look at last night first, then decide what to do tonight.'**
  String get todayGreetingBody;

  /// No description provided for @todaySectionLastNight.
  ///
  /// In en, this message translates to:
  /// **'Last night'**
  String get todaySectionLastNight;

  /// No description provided for @todayLastNightNoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Last night is still waiting for the first sample'**
  String get todayLastNightNoDataTitle;

  /// No description provided for @todayLastNightNoDataBody.
  ///
  /// In en, this message translates to:
  /// **'Onboarding is complete. Once tonight is recorded, this card will explain the result, source confidence, and your next step first.'**
  String get todayLastNightNoDataBody;

  /// No description provided for @todayLastNightSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'The local result is safe, and sync can wait'**
  String get todayLastNightSyncTitle;

  /// No description provided for @todayLastNightSyncBody.
  ///
  /// In en, this message translates to:
  /// **'Sync did not finish cleanly, but your latest updates are still safe on this device. Keep tonight on track first.'**
  String get todayLastNightSyncBody;

  /// No description provided for @todayLastNightManualTitle.
  ///
  /// In en, this message translates to:
  /// **'This result now follows a manual adjustment'**
  String get todayLastNightManualTitle;

  /// No description provided for @todayLastNightManualBody.
  ///
  /// In en, this message translates to:
  /// **'Rhythm will respect your latest manual correction and use it as the baseline for the explanation tonight.'**
  String get todayLastNightManualBody;

  /// No description provided for @todayLastNightOnTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Last night stayed close to the target'**
  String get todayLastNightOnTargetTitle;

  /// No description provided for @todayLastNightOnTargetBody.
  ///
  /// In en, this message translates to:
  /// **'The rhythm was basically on track. Keep tonight steady and avoid over-correcting a night that already landed well.'**
  String get todayLastNightOnTargetBody;

  /// No description provided for @todayLastNightSlightDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Last night drifted a little later than planned'**
  String get todayLastNightSlightDelayTitle;

  /// No description provided for @todayLastNightSlightDelayBody.
  ///
  /// In en, this message translates to:
  /// **'The delay is still manageable. Tighten tonight\'\'s wind-down and keep the next wake-up anchored.'**
  String get todayLastNightSlightDelayBody;

  /// No description provided for @todayLastNightMajorDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Last night drifted far beyond the target'**
  String get todayLastNightMajorDelayTitle;

  /// No description provided for @todayLastNightMajorDelayBody.
  ///
  /// In en, this message translates to:
  /// **'Treat tonight as a recovery night: lower stimulation earlier and keep the next morning from sliding later again.'**
  String get todayLastNightMajorDelayBody;

  /// No description provided for @todaySectionTonightGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal for tonight'**
  String get todaySectionTonightGoal;

  /// No description provided for @todayTonightGoalHeadline.
  ///
  /// In en, this message translates to:
  /// **'Bedtime target'**
  String get todayTonightGoalHeadline;

  /// No description provided for @todayTonightGoalReminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Wind-down reminder'**
  String get todayTonightGoalReminderLabel;

  /// No description provided for @todayTonightGoalBody.
  ///
  /// In en, this message translates to:
  /// **'Start winding down at {windDown}, and keep the wake-up target at {wakeTime}.'**
  String todayTonightGoalBody(Object windDown, Object wakeTime);

  /// No description provided for @todaySectionRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery suggestion'**
  String get todaySectionRecovery;

  /// No description provided for @todayRecoveryBuildBaselineTitle.
  ///
  /// In en, this message translates to:
  /// **'Start by completing the first night'**
  String get todayRecoveryBuildBaselineTitle;

  /// No description provided for @todayRecoveryBuildBaselineBody.
  ///
  /// In en, this message translates to:
  /// **'Finish the routine tonight first, then come back tomorrow morning for the first result and a clearer recovery suggestion.'**
  String get todayRecoveryBuildBaselineBody;

  /// No description provided for @todayRecoverySyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay on the local rhythm first, repair sync later'**
  String get todayRecoverySyncTitle;

  /// No description provided for @todayRecoverySyncBody.
  ///
  /// In en, this message translates to:
  /// **'The important part right now is preserving the rhythm tonight, not interrupting the local record flow for a sync repair.'**
  String get todayRecoverySyncBody;

  /// No description provided for @todayRecoveryDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Use tonight to pull the rhythm back earlier'**
  String get todayRecoveryDelayTitle;

  /// No description provided for @todayRecoveryDelayBody.
  ///
  /// In en, this message translates to:
  /// **'Keep the next wind-down short and decisive, and avoid compensating by sleeping much later tomorrow morning.'**
  String get todayRecoveryDelayBody;

  /// No description provided for @todayRecoveryMomentumTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect the corrected rhythm tonight'**
  String get todayRecoveryMomentumTitle;

  /// No description provided for @todayRecoveryMomentumBody.
  ///
  /// In en, this message translates to:
  /// **'Since the result was adjusted manually, keep tonight aligned with that corrected baseline instead of adding more corrective tasks.'**
  String get todayRecoveryMomentumBody;

  /// No description provided for @todaySectionQuickRecord.
  ///
  /// In en, this message translates to:
  /// **'Quick record'**
  String get todaySectionQuickRecord;

  /// No description provided for @todayQuickRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Log the check-in for tonight'**
  String get todayQuickRecordTitle;

  /// No description provided for @todayQuickRecordRecommendedBody.
  ///
  /// In en, this message translates to:
  /// **'If tonight drifts from the goal, add a quick mood, energy, or note so the explanation tomorrow has context.'**
  String get todayQuickRecordRecommendedBody;

  /// No description provided for @todayQuickRecordOptionalBody.
  ///
  /// In en, this message translates to:
  /// **'If anything feels worth noting tonight, add a short check-in so the first-week trend can build with context.'**
  String get todayQuickRecordOptionalBody;

  /// No description provided for @todayQuickRecordSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add last night\'\'s record'**
  String get todayQuickRecordSheetTitle;

  /// No description provided for @todayQuickRecordSheetBody.
  ///
  /// In en, this message translates to:
  /// **'Capture the minimum facts first so the result card and the first-week trend stop falling back to placeholders.'**
  String get todayQuickRecordSheetBody;

  /// No description provided for @todayQuickRecordDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Sleep date'**
  String get todayQuickRecordDateLabel;

  /// No description provided for @todayQuickRecordBedtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Fell asleep at'**
  String get todayQuickRecordBedtimeLabel;

  /// No description provided for @todayQuickRecordWakeTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Woke up at'**
  String get todayQuickRecordWakeTimeLabel;

  /// No description provided for @todayQuickRecordNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get todayQuickRecordNoteLabel;

  /// No description provided for @todayQuickRecordSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Save record'**
  String get todayQuickRecordSaveAction;

  /// No description provided for @todayQuickRecordSaved.
  ///
  /// In en, this message translates to:
  /// **'Last night\'\'s record was saved.'**
  String get todayQuickRecordSaved;

  /// No description provided for @todaySectionTrend.
  ///
  /// In en, this message translates to:
  /// **'7-day trend'**
  String get todaySectionTrend;

  /// No description provided for @todayTrendScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Sleep score'**
  String get todayTrendScoreLabel;

  /// No description provided for @todayTrendBuildingTitle.
  ///
  /// In en, this message translates to:
  /// **'The 7-day trend starts building tonight'**
  String get todayTrendBuildingTitle;

  /// No description provided for @todayTrendBuildingBody.
  ///
  /// In en, this message translates to:
  /// **'During the first week, this section focuses on context and explainability instead of competing with the primary home-page judgment.'**
  String get todayTrendBuildingBody;

  /// No description provided for @todayTrendReadyBody.
  ///
  /// In en, this message translates to:
  /// **'The chart is now using your recent samples, so you can quickly judge whether the rhythm is pulling back toward the target.'**
  String get todayTrendReadyBody;

  /// No description provided for @todayFooterHint.
  ///
  /// In en, this message translates to:
  /// **'Today currently consumes the shipped goal schedule, shared status, and account snapshot baseline. Real sleep-record wiring will follow in a later module pass.'**
  String get todayFooterHint;

  /// No description provided for @todayErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'The today snapshot could not be restored just now'**
  String get todayErrorTitle;

  /// No description provided for @todayErrorBody.
  ///
  /// In en, this message translates to:
  /// **'The shell is still usable. Rhythm will try to rebuild the home-page snapshot the next time you return here.'**
  String get todayErrorBody;

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

  /// No description provided for @bedtimeEntryFromToday.
  ///
  /// In en, this message translates to:
  /// **'From today'**
  String get bedtimeEntryFromToday;

  /// No description provided for @bedtimeEntryFromNotification.
  ///
  /// In en, this message translates to:
  /// **'From notification'**
  String get bedtimeEntryFromNotification;

  /// No description provided for @bedtimeEntryFromWidget.
  ///
  /// In en, this message translates to:
  /// **'From widget'**
  String get bedtimeEntryFromWidget;

  /// No description provided for @bedtimeBeforeTargetHeadline.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes until the target'**
  String bedtimeBeforeTargetHeadline(Object minutes);

  /// No description provided for @bedtimeAfterTargetHeadline.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes past the target'**
  String bedtimeAfterTargetHeadline(Object minutes);

  /// No description provided for @bedtimeCompletedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Tonight\'\'s wind-down is done'**
  String get bedtimeCompletedHeadline;

  /// No description provided for @bedtimeBeforeTargetBody.
  ///
  /// In en, this message translates to:
  /// **'Pull the focus back to one decision tonight. The target bedtime is {bedtime}.'**
  String bedtimeBeforeTargetBody(Object bedtime);

  /// No description provided for @bedtimeDelayBody.
  ///
  /// In en, this message translates to:
  /// **'Tonight is about limiting the drift first. Keep tomorrow\'\'s wake-up target at {wakeTime}.'**
  String bedtimeDelayBody(Object wakeTime);

  /// No description provided for @bedtimeCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'Keep the wake-up target at {wakeTime} tomorrow morning. No extra tasks need to pile on now.'**
  String bedtimeCompletedBody(Object wakeTime);

  /// No description provided for @bedtimeTargetBedtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target bedtime'**
  String get bedtimeTargetBedtimeLabel;

  /// No description provided for @bedtimeTargetWakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Target wake-up'**
  String get bedtimeTargetWakeLabel;

  /// No description provided for @bedtimeChoiceSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'What is the best call for tonight?'**
  String get bedtimeChoiceSectionTitle;

  /// No description provided for @bedtimeChoiceReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to sleep'**
  String get bedtimeChoiceReadyTitle;

  /// No description provided for @bedtimeChoiceReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Do not open new tasks. Move straight into the smallest wind-down action.'**
  String get bedtimeChoiceReadyBody;

  /// No description provided for @bedtimeChoiceWindDownTitle.
  ///
  /// In en, this message translates to:
  /// **'Need a little wind-down'**
  String get bedtimeChoiceWindDownTitle;

  /// No description provided for @bedtimeChoiceWindDownBody.
  ///
  /// In en, this message translates to:
  /// **'Give yourself a short buffer, but do not reopen another stimulating task.'**
  String get bedtimeChoiceWindDownBody;

  /// No description provided for @bedtimeChoiceDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Tonight will likely drift late'**
  String get bedtimeChoiceDelayTitle;

  /// No description provided for @bedtimeChoiceDelayBody.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge the drift, then reduce the damage for tomorrow morning and the next recovery step.'**
  String get bedtimeChoiceDelayBody;

  /// No description provided for @bedtimeActionSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Tonight\'\'s action'**
  String get bedtimeActionSectionTitle;

  /// No description provided for @bedtimeActionStartWindDownTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a 10-minute wind-down'**
  String get bedtimeActionStartWindDownTitle;

  /// No description provided for @bedtimeActionStartWindDownBody.
  ///
  /// In en, this message translates to:
  /// **'The most important thing now is to turn off stimulation and give yourself one short closing window.'**
  String get bedtimeActionStartWindDownBody;

  /// No description provided for @bedtimeActionPutPhoneAwayTitle.
  ///
  /// In en, this message translates to:
  /// **'Put the phone away for 10 minutes'**
  String get bedtimeActionPutPhoneAwayTitle;

  /// No description provided for @bedtimeActionPutPhoneAwayBody.
  ///
  /// In en, this message translates to:
  /// **'Push the screen and unfinished tasks back for 10 minutes so the body can actually start relaxing.'**
  String get bedtimeActionPutPhoneAwayBody;

  /// No description provided for @bedtimeActionProtectWakeTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect tomorrow\'\'s wake-up time first'**
  String get bedtimeActionProtectWakeTitle;

  /// No description provided for @bedtimeActionProtectWakeBody.
  ///
  /// In en, this message translates to:
  /// **'Limit the damage tonight instead of trying to fix everything. Protecting the wake-up time matters more than dragging the night longer.'**
  String get bedtimeActionProtectWakeBody;

  /// No description provided for @bedtimeActionCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Tonight\'\'s action is done'**
  String get bedtimeActionCompletedTitle;

  /// No description provided for @bedtimeActionCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'When you come back tomorrow morning, Rhythm will use last night\'\'s result to continue the explanation.'**
  String get bedtimeActionCompletedBody;

  /// No description provided for @bedtimeRestoredSessionBody.
  ///
  /// In en, this message translates to:
  /// **'We restored the unfinished choice from tonight.'**
  String get bedtimeRestoredSessionBody;

  /// No description provided for @bedtimeReminderEnabledBody.
  ///
  /// In en, this message translates to:
  /// **'Reminders are on, and tonight will keep nudging you around the {bedtime} target.'**
  String bedtimeReminderEnabledBody(Object bedtime);

  /// No description provided for @bedtimeReminderDisabledBody.
  ///
  /// In en, this message translates to:
  /// **'Reminders are currently off. Follow tonight\'\'s action here first, then enable them later in settings if you want.'**
  String get bedtimeReminderDisabledBody;

  /// No description provided for @bedtimeCountdownCompletedValue.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get bedtimeCountdownCompletedValue;

  /// No description provided for @bedtimePrimaryActionLabel.
  ///
  /// In en, this message translates to:
  /// **'Do this step'**
  String get bedtimePrimaryActionLabel;

  /// No description provided for @bedtimePrimaryActionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Tonight is already done'**
  String get bedtimePrimaryActionCompleted;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTitle;

  /// No description provided for @calendarBody.
  ///
  /// In en, this message translates to:
  /// **'Review monthly offsets, adjustments, and day details against your goal.'**
  String get calendarBody;

  /// No description provided for @calendarSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read this month through goal offsets before deciding what to correct or revisit.'**
  String get calendarSummarySubtitle;

  /// No description provided for @calendarRecordedNightsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} nights recorded this month'**
  String calendarRecordedNightsLabel(int count);

  /// No description provided for @calendarOnTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} nights on target'**
  String calendarOnTargetLabel(int count);

  /// No description provided for @calendarDelayedLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} nights delayed'**
  String calendarDelayedLabel(int count);

  /// No description provided for @calendarAdjustedLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} nights adjusted'**
  String calendarAdjustedLabel(int count);

  /// No description provided for @calendarPartialLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} partial nights'**
  String calendarPartialLabel(int count);

  /// No description provided for @calendarFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All records'**
  String get calendarFilterAll;

  /// No description provided for @calendarFilterDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get calendarFilterDelayed;

  /// No description provided for @calendarFilterAdjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted'**
  String get calendarFilterAdjusted;

  /// No description provided for @calendarFilterLockedInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get calendarFilterLockedInsights;

  /// No description provided for @calendarNoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No sleep records yet this month'**
  String get calendarNoDataTitle;

  /// No description provided for @calendarNoDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Keep the monthly view in place and add your first night to start reading offsets against your goal.'**
  String get calendarNoDataMessage;

  /// No description provided for @calendarLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Earlier history and cause breakdown unlock in Insights'**
  String get calendarLockedTitle;

  /// No description provided for @calendarLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'This month\'\'s heatmap stays here. Jump to Insights when you want deeper history and premium explanations.'**
  String get calendarLockedMessage;

  /// No description provided for @calendarOpenInsightsCta.
  ///
  /// In en, this message translates to:
  /// **'Open Insights'**
  String get calendarOpenInsightsCta;

  /// No description provided for @calendarHeatmapLegendOnTarget.
  ///
  /// In en, this message translates to:
  /// **'On target'**
  String get calendarHeatmapLegendOnTarget;

  /// No description provided for @calendarHeatmapLegendDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get calendarHeatmapLegendDelayed;

  /// No description provided for @calendarHeatmapLegendPartial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get calendarHeatmapLegendPartial;

  /// No description provided for @calendarHeatmapLegendEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get calendarHeatmapLegendEmpty;

  /// No description provided for @calendarMetricAverageDelayLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg. offset'**
  String get calendarMetricAverageDelayLabel;

  /// No description provided for @calendarMetricAverageSleepLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg. sleep'**
  String get calendarMetricAverageSleepLabel;

  /// No description provided for @calendarMetricAverageWakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg. wake'**
  String get calendarMetricAverageWakeLabel;

  /// No description provided for @calendarMetricTrackedDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Days tracked'**
  String get calendarMetricTrackedDaysLabel;

  /// No description provided for @calendarDetailBedtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get calendarDetailBedtimeLabel;

  /// No description provided for @calendarDetailWakeTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Wake time'**
  String get calendarDetailWakeTimeLabel;

  /// No description provided for @calendarDetailTotalSleepLabel.
  ///
  /// In en, this message translates to:
  /// **'Total sleep'**
  String get calendarDetailTotalSleepLabel;

  /// No description provided for @calendarDayDetailSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get calendarDayDetailSourceLabel;

  /// No description provided for @calendarDayDetailAdjustmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get calendarDayDetailAdjustmentLabel;

  /// No description provided for @calendarDayDetailOffsetLabel.
  ///
  /// In en, this message translates to:
  /// **'Vs target'**
  String get calendarDayDetailOffsetLabel;

  /// No description provided for @calendarDayDetailDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Total sleep'**
  String get calendarDayDetailDurationLabel;

  /// No description provided for @calendarDayDetailConfidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get calendarDayDetailConfidenceLabel;

  /// No description provided for @calendarDayDetailNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get calendarDayDetailNoteLabel;

  /// No description provided for @calendarDayDetailNoNote.
  ///
  /// In en, this message translates to:
  /// **'No additional note'**
  String get calendarDayDetailNoNote;

  /// No description provided for @calendarRecordSourceManual.
  ///
  /// In en, this message translates to:
  /// **'Manual entry'**
  String get calendarRecordSourceManual;

  /// No description provided for @calendarRecordSourceHealth.
  ///
  /// In en, this message translates to:
  /// **'Health sync'**
  String get calendarRecordSourceHealth;

  /// No description provided for @calendarAdjustmentAdjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted manually'**
  String get calendarAdjustmentAdjusted;

  /// No description provided for @calendarAdjustmentOriginal.
  ///
  /// In en, this message translates to:
  /// **'Original record'**
  String get calendarAdjustmentOriginal;

  /// No description provided for @calendarConfidenceTrusted.
  ///
  /// In en, this message translates to:
  /// **'Complete sample'**
  String get calendarConfidenceTrusted;

  /// No description provided for @calendarConfidencePartial.
  ///
  /// In en, this message translates to:
  /// **'Partial sample'**
  String get calendarConfidencePartial;

  /// No description provided for @calendarOffsetOnTarget.
  ///
  /// In en, this message translates to:
  /// **'On target'**
  String get calendarOffsetOnTarget;

  /// No description provided for @calendarOffsetEarly.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes early'**
  String calendarOffsetEarly(int minutes);

  /// No description provided for @calendarOffsetLate.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes late'**
  String calendarOffsetLate(int minutes);

  /// No description provided for @calendarDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String calendarDurationLabel(int hours, int minutes);

  /// No description provided for @calendarSleepWindowLabel.
  ///
  /// In en, this message translates to:
  /// **'Bedtime / wake time'**
  String get calendarSleepWindowLabel;

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

  /// No description provided for @profileAccountAnonymousTitle.
  ///
  /// In en, this message translates to:
  /// **'You are currently in local-first mode'**
  String get profileAccountAnonymousTitle;

  /// No description provided for @profileAccountAnonymousBody.
  ///
  /// In en, this message translates to:
  /// **'Tonight updates stay on this device first. You can connect an account and enable sync later.'**
  String get profileAccountAnonymousBody;

  /// No description provided for @profileAccountConnectedTitle.
  ///
  /// In en, this message translates to:
  /// **'{provider} account connected'**
  String profileAccountConnectedTitle(Object provider);

  /// No description provided for @profileAccountConnectedBody.
  ///
  /// In en, this message translates to:
  /// **'Your account snapshot is already stored on this device, and sync, membership, and privacy settings can build on it next.'**
  String get profileAccountConnectedBody;

  /// No description provided for @profileAccountLoadFallbackBody.
  ///
  /// In en, this message translates to:
  /// **'Account state could not be restored just now, so settings will stay in the local-first path for now.'**
  String get profileAccountLoadFallbackBody;

  /// No description provided for @accountProviderAppleLabel.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get accountProviderAppleLabel;

  /// No description provided for @accountProviderGoogleLabel.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get accountProviderGoogleLabel;

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
