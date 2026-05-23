// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Rhythm';

  @override
  String get tabToday => '今日';

  @override
  String get tabCalendar => '日历';

  @override
  String get tabBedtime => '睡前';

  @override
  String get tabInsights => '洞察';

  @override
  String get tabProfile => '我的';

  @override
  String get goalSetupTitle => '目标设置';

  @override
  String get goalSetupDescription => '目标设置将在 Task 3 中实现，这里仅承接首次引导的下一步路由。';

  @override
  String get calendarTitle => '日历';

  @override
  String get calendarDescription => '用热力图看清最近的作息节奏。';

  @override
  String get bedtimeTitle => '睡前';

  @override
  String get bedtimeDescription => '进入准备睡了模式，给今晚一个温和收尾。';

  @override
  String get insightsTitle => '洞察';

  @override
  String get insightsDescription => '复盘一周表现，找到更稳定的作息线索。';

  @override
  String get profileTitle => '我的';

  @override
  String get profileDescription => '管理目标、提醒、账号和隐私设置。';

  @override
  String get todayPageTitle => '今日';

  @override
  String get todayCardTitle => '今晚先轻一点';

  @override
  String get todayCardDescription => '设置目标作息后，这里会展示昨晚结果和今晚行动。';

  @override
  String get onboardingStepOneEyebrow => '第 1 步 / 3';

  @override
  String get onboardingWelcomeTitle => '欢迎使用 Rhythm';

  @override
  String get onboardingWelcomeDescription => '从今晚开始，用更温和的方式建立稳定作息，先完成 3 步基础设置。';

  @override
  String get onboardingWelcomeChecklistTitle => '你将会完成';

  @override
  String get onboardingWelcomeBulletAuthTitle => '选择进入方式';

  @override
  String get onboardingWelcomeBulletAuthDescription =>
      '支持匿名体验，也为后续接入 Apple / Google 登录预留入口。';

  @override
  String get onboardingWelcomeBulletHealthTitle => '了解健康数据价值';

  @override
  String get onboardingWelcomeBulletHealthDescription => '先说明记录价值，暂不请求真实系统权限。';

  @override
  String get onboardingWelcomeBulletGoalTitle => '设置目标作息';

  @override
  String get onboardingWelcomeBulletGoalDescription =>
      '本次实现会把流程继续推进到真实目标设置和提醒策略，而不是停在占位页。';

  @override
  String get onboardingWelcomePrimaryButton => '开始设置';

  @override
  String get onboardingStepTwoEyebrow => '第 2 步 / 3';

  @override
  String get onboardingAuthTitle => '选择你的进入方式';

  @override
  String get onboardingAuthDescription =>
      '你可以先匿名体验，后续再决定是否绑定 Apple 或 Google 账号。';

  @override
  String get onboardingAuthAppleLabel => '使用 Apple 继续';

  @override
  String get onboardingAuthAppleDescription => '保留设计中的账号入口，当前版本暂不接入真实 SDK。';

  @override
  String get onboardingAuthGoogleLabel => '使用 Google 继续';

  @override
  String get onboardingAuthGoogleDescription => '先作为流程选项展示，后续任务再补充真实登录逻辑。';

  @override
  String get onboardingAuthAnonymousButton => '匿名体验';

  @override
  String get onboardingAuthLaterButton => '稍后再绑定账号';

  @override
  String get onboardingStepThreeEyebrow => '第 3 步 / 3';

  @override
  String get onboardingHealthTitle => '连接健康数据，记录会更完整';

  @override
  String get onboardingHealthDescription =>
      'Rhythm 会优先用你已有的睡眠与活动数据，帮助你更稳定地回看节奏变化。';

  @override
  String get onboardingHealthAppleSummary => '你刚刚选择了 Apple 入口，后续可再补充账号绑定。';

  @override
  String get onboardingHealthGoogleSummary => '你刚刚选择了 Google 入口，后续可再补充账号绑定。';

  @override
  String get onboardingHealthAnonymousSummary => '你当前以匿名体验进入，后续也可以在设置里再绑定账号。';

  @override
  String get onboardingHealthDefaultSummary => '你可以先了解健康记录会带来什么，再决定是否授权。';

  @override
  String get onboardingHealthBenefitTitle => '为什么建议开启';

  @override
  String get onboardingHealthBenefitDescription =>
      '如果后续接入健康数据，你可以减少手动补录，趋势回顾也会更完整。';

  @override
  String get onboardingHealthCurrentStageTitle => '当前阶段说明';

  @override
  String get onboardingHealthCurrentStageDescription =>
      '本任务先完成流程说明，不触发真实系统权限请求。';

  @override
  String get onboardingHealthSkipButton => '先用手动模式';

  @override
  String get onboardingHealthAuthorizeButton => '授权并继续';

  @override
  String get goalSetupEyebrow => '目标设置';

  @override
  String get goalSetupPageTitle => '设置你的目标作息';

  @override
  String get goalSetupPageDescription => '这个 MVP 版本先用轻量表单锁定你的首个目标作息，再进入提醒策略确认。';

  @override
  String get goalSetupContinueButton => '保存目标，继续下一步';

  @override
  String get goalScheduleBedtimeLabel => '目标入睡时间';

  @override
  String get goalScheduleBedtimeDescription => 'Rhythm 会以这个时间作为后续恢复建议的参考基准。';

  @override
  String get goalScheduleWakeLabel => '目标起床时间';

  @override
  String get goalScheduleWakeDescription => '请与入睡时间保持清晰间隔，确保目标窗口有实际意义。';

  @override
  String get goalScheduleLateThresholdLabel => '熬夜阈值';

  @override
  String get goalScheduleLateThresholdDescription => '后续会用这个阈值判断当晚是否算作明显晚睡。';

  @override
  String get goalScheduleDayStartLabel => '一天起始时间';

  @override
  String get goalScheduleDayStartDescription => '后续会用这个时间把跨午夜记录归到同一统计日。';

  @override
  String get goalScheduleWakeSameAsBedtimeError => '起床时间不能与目标入睡时间相同。';

  @override
  String goalScheduleMinutesValue(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String get reminderSetupEyebrow => '提醒策略';

  @override
  String get reminderSetupPageTitle => '选择你的提醒方式';

  @override
  String get reminderSetupPageDescription => '确认好提示节奏后，就可以结束首次设置并进入今日页。';

  @override
  String get reminderSetupCompleteButton => '完成设置，进入今日页';

  @override
  String get reminderSoftReminderTitle => '柔性提醒';

  @override
  String get reminderSoftReminderDescription => '在你明显偏离今晚计划前，先给一个低压力提醒。';

  @override
  String get reminderTargetReminderTitle => '到点提醒';

  @override
  String get reminderTargetReminderDescription => '到了该开始收尾的时间，再给一个更明确的提示。';

  @override
  String get reminderWeeklyReportTitle => '每周回顾';

  @override
  String get reminderWeeklyReportDescription => '每周给出一次节奏回顾，帮助你看到作息是否更稳定。';

  @override
  String get reminderLeadTimeTitle => '提醒提前量';

  @override
  String reminderLeadTimeValue(int minutes) {
    return '在目标入睡前 $minutes 分钟提醒';
  }
}
