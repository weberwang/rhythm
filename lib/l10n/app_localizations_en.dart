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
}
