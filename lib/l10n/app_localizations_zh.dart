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
  String get todayOpenSleepRecordsButton => '进入睡眠记录管理';

  @override
  String get todayGoalMissingTitle => '还没有设置作息目标';

  @override
  String get todayGoalMissingPrimaryAction => '去设置目标作息';

  @override
  String get todayPermissionFailedTitle => '系统睡眠记录暂时不可用';

  @override
  String get todayPermissionFailedPrimaryAction => '查看权限说明';

  @override
  String get todayEmptyTitle => '昨晚还没有记录';

  @override
  String get todayEmptyPrimaryAction => '手动补录昨晚记录';

  @override
  String get todayStatusSectionTitle => '昨晚结果';

  @override
  String get todayActionSectionTitle => '今晚行动';

  @override
  String get todayTrendSectionTitle => '最近 7 天';

  @override
  String get todayRecoverySectionTitle => '恢复建议';

  @override
  String get sleepRecordsHubTitle => '睡眠记录管理';

  @override
  String get sleepRecordsHubSyncTitle => '最近 30 天睡眠记录';

  @override
  String get sleepRecordsHubSyncDescription => '自动记录是加速器，手动补录是保底路径。';

  @override
  String get sleepRecordsHubManualButton => '手动补录';

  @override
  String get sleepRecordsHubRetryButton => '重新同步';

  @override
  String get sleepRecordsHubInstallButton => '安装 Health Connect';

  @override
  String get sleepRecordsHubAuthorizeButton => '重新授权';

  @override
  String get sleepRecordsHubManualModeButton => '改用手动模式';

  @override
  String get sleepRecordsHubStatusIdle => '等待同步';

  @override
  String get sleepRecordsHubStatusIdleDescription =>
      '尚未读取最近 30 天睡眠记录，你可以先同步，或直接改用手动补录。';

  @override
  String get sleepRecordsHubStatusSyncing => '正在同步';

  @override
  String get sleepRecordsHubStatusSyncingDescription => '正在读取最近 30 天睡眠记录，请稍候。';

  @override
  String get sleepRecordsHubStatusConnected => '已连接健康数据';

  @override
  String sleepRecordsHubStatusConnectedDescription(int count) {
    return '最近 30 天已写入 $count 条睡眠记录。';
  }

  @override
  String get sleepRecordsHubStatusInstallRequired => '需要安装 Health Connect';

  @override
  String get sleepRecordsHubStatusInstallRequiredDescription =>
      '检测到当前设备尚未安装 Health Connect，安装后才可自动同步睡眠记录。';

  @override
  String get sleepRecordsHubStatusPermissionRequired => '需要授权读取睡眠数据';

  @override
  String get sleepRecordsHubStatusPermissionRequiredDescription =>
      '未获得睡眠记录读取权限，重新授权后可继续自动同步。';

  @override
  String get sleepRecordsHubStatusUnavailable => '当前设备暂不支持睡眠同步';

  @override
  String get sleepRecordsHubStatusUnavailableDescription =>
      '你仍可以手动补录昨晚结果，后续再接入自动记录。';

  @override
  String get sleepRecordsHubStatusManualFallback => '当前改用手动补录';

  @override
  String get sleepRecordsHubStatusManualFallbackDescription =>
      '未读取到可用睡眠记录，你仍可手动确认昨晚的睡眠结果。';

  @override
  String get sleepRecordsHubStatusError => '同步失败';

  @override
  String get sleepRecordsHubStatusErrorDescription =>
      '这次自动同步没有完成，你可以稍后重试，或直接改用手动补录。';

  @override
  String get sleepRecordsHubLastSyncedTitle => '最近同步';

  @override
  String get sleepRecordsHubFailureReasonTitle => '失败原因';

  @override
  String get sleepRecordsHubFailureReasonSyncFailed => '健康数据读取失败，请稍后重试。';

  @override
  String get sleepRecordsHubFailureReasonPlatformUnavailable =>
      '当前设备暂时无法读取健康数据，请先改用手动补录。';

  @override
  String get sleepRecordsHubFailureReasonGeneric => '这次同步没有完成，请稍后再试。';

  @override
  String get sleepRecordsHubSourceTitle => '来源与可信度';

  @override
  String get sleepRecordsHubSourceBulletOriginal => '• 系统自动读取会保留原始来源';

  @override
  String get sleepRecordsHubSourceBulletManual => '• 手动修正不会覆盖原始记录，只会生成确认结果';

  @override
  String get sleepRecordsHubSourceBulletFallback => '• 无权限时今日页、日历和周报仍可继续使用';

  @override
  String get sleepRecordsHubEmptyState => '暂无已确认记录';

  @override
  String get sleepRecordsHubLoadFailed => '记录加载失败，请稍后再试';

  @override
  String get sleepRecordsHubManualRecordTitle => '手动补录记录';

  @override
  String get sleepRecordsHubHealthConnectRecordTitle => 'Health Connect 同步记录';

  @override
  String get sleepRecordsHubHealthKitRecordTitle => 'HealthKit 同步记录';

  @override
  String get sleepRecordsHubImportedRecordTitle => '导入记录';

  @override
  String get manualSleepRecordPageTitle => '手动补录';

  @override
  String get manualSleepRecordPageSubtitle => '手动确认昨晚的睡眠结果';

  @override
  String get manualSleepRecordPageDescription =>
      '当自动记录缺失或不够准确时，你可以直接补录或修正入睡与起床时间。';

  @override
  String get manualSleepRecordDateLabel => '归属日期';

  @override
  String get manualSleepRecordSleepTimeLabel => '入睡时间';

  @override
  String get manualSleepRecordWakeTimeLabel => '起床时间';

  @override
  String get manualSleepRecordDurationLabel => '睡眠时长';

  @override
  String get manualSleepRecordSourceLabel => '数据来源';

  @override
  String get manualSleepRecordSourceValue => '手动修正';

  @override
  String get manualSleepRecordSaveButton => '保存补录结果';

  @override
  String get manualSleepRecordDiscardButton => '放弃本次修改';

  @override
  String get manualSleepRecordHelperTitle => '修正说明';

  @override
  String get manualSleepRecordHelperDescription =>
      '系统原始记录会保留，你保存的是“用户确认结果”，今日页和日历都会优先展示它。';

  @override
  String get manualSleepRecordValidationSameTime => '入睡时间和起床时间不能相同。';

  @override
  String get manualSleepRecordEditTimeButton => '修改时间';

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
  String get onboardingAuthTitle => '先把节奏跑起来，登录只在需要同步时再做。';

  @override
  String get onboardingAuthDescription => '匿名进入降低首启压力，登录用于换机恢复和会员状态同步。';

  @override
  String get onboardingAuthAppleLabel => '本地优先';

  @override
  String get onboardingAuthAppleDescription => '数据先留在设备里';

  @override
  String get onboardingAuthGoogleLabel => '随时绑定';

  @override
  String get onboardingAuthGoogleDescription => '之后再连账号也不会丢';

  @override
  String get onboardingAuthAnonymousButton => '匿名进入';

  @override
  String get onboardingAuthLaterButton => '使用 Apple 继续';

  @override
  String get onboardingAuthGoogleButton => '使用 Google 继续';

  @override
  String get onboardingStepThreeEyebrow => '第 3 步 / 3';

  @override
  String get onboardingHealthTitle => '读取睡眠数据';

  @override
  String get onboardingHealthDescription => '我们只读取睡眠记录，不会把数据用于医疗判断或广告。';

  @override
  String get onboardingHealthAppleSummary => '自动同步睡眠记录';

  @override
  String get onboardingHealthGoogleSummary => '近 30 天数据会写入本地节律时间线';

  @override
  String get onboardingHealthAnonymousSummary => '授权失败可降级';

  @override
  String get onboardingHealthDefaultSummary => '没有权限时仍能手动补录并生成周报';

  @override
  String get onboardingHealthBenefitTitle => '为什么建议开启';

  @override
  String get onboardingHealthBenefitDescription =>
      '后续接入健康数据后，可减少手动补录并提升趋势回顾完整度。';

  @override
  String get onboardingHealthCurrentStageTitle => '当前阶段说明';

  @override
  String get onboardingHealthCurrentStageDescription =>
      '本任务只完成说明流程，不触发真实系统权限请求。';

  @override
  String get onboardingHealthSkipButton => '先用手动模式';

  @override
  String get onboardingHealthAuthorizeButton => '授权读取睡眠数据';

  @override
  String get goalSetupEyebrow => '设置一个能做到的目标';

  @override
  String get goalSetupPageTitle => '目标是节律的参考线，不是每天必须完美做到的红线。';

  @override
  String get goalSetupPageDescription => '先给出一版基础目标，后面随时可以调整。';

  @override
  String get goalSetupContinueButton => '保存目标，继续下一步';

  @override
  String get goalSetupWorkdayTitle => '工作日规则';

  @override
  String get goalSetupWorkdayWeekdays => '工作日优先';

  @override
  String get goalSetupWorkdayFlexible => '后续再调';

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
  String get reminderSetupEyebrow => '把提醒调到刚刚好';

  @override
  String get reminderSetupPageTitle => '默认只开柔性提醒，不做连续轰炸式打断。';

  @override
  String get reminderSetupPageDescription => '你可以先开轻提醒，后续再决定是否需要到点提醒。';

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
  String get reminderLeadHintTitle => '提前量建议';

  @override
  String get reminderLeadHintEarly => '15 分钟';

  @override
  String get reminderLeadHintRecommended => '30 分钟';

  @override
  String get reminderLeadHintMinimal => '45 分钟';

  @override
  String reminderLeadTimeValue(int minutes) {
    return '在目标入睡前 $minutes 分钟提醒';
  }
}
