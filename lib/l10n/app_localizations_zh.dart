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
  String get calendarTitle => '作息日历';

  @override
  String get calendarDescription => '颜色越深，越接近你的目标入睡时间。';

  @override
  String get calendarHeroEyebrow => '五月仍有节律感';

  @override
  String get calendarHeroTitle => '颜色不是坏消息，而是你与目标时间的距离。';

  @override
  String calendarHeroSubtitle(int onTrackDays, int driftDays) {
    return '本月已有 $onTrackDays 天在轨道里，更多 $driftDays 天有偏航。';
  }

  @override
  String get calendarHeroSubtitleEmpty => '本月还没有可用节律样本。先记录几天，再回来看走势。';

  @override
  String get calendarFilterMetGoal => '入轨内';

  @override
  String get calendarFilterLate => '晚起波动';

  @override
  String get calendarFilterDataSource => '看晚睡次数';

  @override
  String get calendarFilterAllDays => '看入睡时间';

  @override
  String get calendarFilterOpen => '筛选';

  @override
  String get calendarFilterOpenSemantics => '打开筛选';

  @override
  String get calendarFilterOpenActiveSemantics => '打开筛选，当前已启用筛选';

  @override
  String get calendarFilterSheetTitle => '筛选日历反馈';

  @override
  String get calendarFilterRecordedOnly => '只看有记录日期';

  @override
  String get calendarFilterLateOnly => '只看晚睡日期';

  @override
  String get calendarFilterSummaryRecorded => '看稳定度';

  @override
  String get calendarFilterSummaryLateOnly => '仅晚睡';

  @override
  String calendarFilterSummaryAppliedCount(int count) {
    return '已筛选 $count 项';
  }

  @override
  String calendarFilterLateCountSummary(int count) {
    return '晚睡 $count 天';
  }

  @override
  String get calendarFilterReset => '重置筛选';

  @override
  String get calendarFilterApply => '应用筛选';

  @override
  String get calendarMetricOnTrack => '达标率';

  @override
  String get calendarMetricLatestLate => '最晚一晚';

  @override
  String get calendarDetailSleepTime => '实际入睡';

  @override
  String get calendarDetailWakeTime => '实际起床';

  @override
  String get calendarDetailOffset => '偏差';

  @override
  String get calendarDetailSource => '来源与可信度';

  @override
  String get calendarDetailNoRecord => '当天还没有可解释的睡眠记录。';

  @override
  String get calendarDetailTagsTitle => '原因标签';

  @override
  String get calendarDetailAddTag => '添加标签';

  @override
  String get calendarDetailEditRecord => '编辑昨晚记录';

  @override
  String calendarDetailOffsetValue(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String get sleepDelayTagPickerTitle => '补一个晚睡原因';

  @override
  String get sleepDelayTagPickerSave => '保存标签';

  @override
  String get sleepDelayTagPickerCustom => '自定义标签';

  @override
  String get customDelayTagTitle => '添加自定义原因';

  @override
  String get customDelayTagHint => '输入这次晚睡的原因';

  @override
  String get customDelayTagSave => '保存自定义标签';

  @override
  String get customDelayTagErrorEmpty => '请输入原因标签';

  @override
  String get customDelayTagErrorTooLong => '原因标签最多 12 个字';

  @override
  String get customDelayTagErrorDuplicate => '这个原因已经在默认标签里了';

  @override
  String get bedtimeTitle => '睡前';

  @override
  String get bedtimeDescription => '进入准备睡了模式，给今晚一个温和收尾。';

  @override
  String get insightsTitle => '洞察';

  @override
  String get insightsDescription => '复盘一周表现，找到更稳定的作息线索。';

  @override
  String get insightsViewWeeklyReportButton => '查看完整周报';

  @override
  String get insightsViewHistoryButton => '查看历史洞察';

  @override
  String insightsWeeklyHeadline(int rate, int score, String weekday) {
    return '最近 7 天达标率 $rate%，稳定度 $score 分。最晚的一天在$weekday。';
  }

  @override
  String insightsWeeklyDescription(String reason) {
    return '你已经把波动收窄了，下一步只需要先处理掉最常见的拖延原因：$reason。';
  }

  @override
  String get insightsOnTrackRateLabel => '达标率';

  @override
  String get insightsStabilityLabel => '稳定度';

  @override
  String get insightsLatestLateTitle => '最晚入睡日';

  @override
  String get insightsNextWeekAdviceTitle => '下周建议';

  @override
  String get insightsReasonDistributionTitle => '主要晚睡原因';

  @override
  String get insightsNoReasonTags => '未记录原因标签';

  @override
  String get insightsNoWeeklyReport => '暂无周报';

  @override
  String get insightsNoHistory => '暂无历史洞察';

  @override
  String get insightsWeeklyReportPageTitle => '本周周报';

  @override
  String get insightsHistoryPageTitle => '历史洞察';

  @override
  String get insightsHistoryHeadline => '回看长期变化';

  @override
  String get insightsHistoryDescription => '最近 30 天内可直接查看，30 天前历史会在此承接会员能力。';

  @override
  String get insightsHistoryPaywallTitle => '需要更长时间线？';

  @override
  String get insightsHistoryPaywallDescription =>
      '会员可查看 30 天前历史、月报入口和更完整的恢复轨迹。';

  @override
  String get insightsHistoryUnlockButton => '解锁全部历史洞察';

  @override
  String get membershipCenterPageTitle => '会员中心';

  @override
  String get membershipCenterHeroTitle => '把长期改善能力接上';

  @override
  String get membershipCenterHeroDescription => '会员不替代核心闭环，而是让你更容易看懂原因和恢复路径。';

  @override
  String get membershipStatusFree => '免费版中';

  @override
  String get membershipStatusTrial => '试用中';

  @override
  String get membershipStatusMonthly => '月会员已激活';

  @override
  String get membershipStatusAnnual => '年会员已激活';

  @override
  String get membershipStatusLifetime => '永久会员已激活';

  @override
  String get membershipStatusDescription => '升级后可查看恢复计划详情、长期历史、稳定度解释和更完整的小组件。';

  @override
  String get membershipPlanMonthly => '月付';

  @override
  String get membershipPlanAnnual => '年付';

  @override
  String get membershipPlanLifetime => '永久';

  @override
  String get membershipPlanTrial => '试用';

  @override
  String get membershipPlanFree => '免费';

  @override
  String get membershipPlanTryBadge => '先试试看';

  @override
  String get membershipPlanRecommendedBadge => '最推荐';

  @override
  String get membershipBenefitRecoveryDetail => '恢复计划完整详情';

  @override
  String get membershipBenefitStabilityExplainer => '稳定度评分解释';

  @override
  String get membershipBenefitHistoryMonthly => '30 天前历史与月报入口';

  @override
  String get membershipBenefitRestoreSync => '恢复购买与设备同步';

  @override
  String get membershipBenefitsSheetTitle => '会员权益对比';

  @override
  String get membershipBenefitsSheetDescription => '从洞察页或我的页打开，解释免费版与会员版边界。';

  @override
  String get membershipBenefitRecoveryShort => '恢复计划';

  @override
  String get membershipBenefitHistoryShort => '长期历史';

  @override
  String get membershipBenefitMonthlyShort => '月报';

  @override
  String get membershipPrimaryActionAnnual => '立即开通年会员';

  @override
  String get membershipPrimaryActionMonthly => '立即开通月会员';

  @override
  String get membershipPrimaryActionLifetime => '立即开通永久会员';

  @override
  String get membershipPrimaryActionManage => '管理当前会员';

  @override
  String get membershipViewBenefitsButton => '查看权益说明';

  @override
  String get membershipRestoreButton => '恢复购买';

  @override
  String get paywallHeroBadge => '把改善能力也解锁出来';

  @override
  String get paywallHeroTitle => '免费版给你结果，会员版把恢复计划、稳定度解释和长期历史都接上。';

  @override
  String get paywallHeroDescription => '不在首开硬拦，只在你真正需要更深帮助的时候出现。';

  @override
  String get paywallHintTitle => '会员能力提示';

  @override
  String get paywallHintDescription => '恢复计划详情属于会员能力，但免费闭环仍可继续使用。';

  @override
  String get paywallBenefitRecoveryDetail => '恢复计划详情';

  @override
  String get paywallBenefitStabilityExplainer => '稳定度详细解释';

  @override
  String get paywallBenefitHistoryMonthly => '30 天前历史与月报入口';

  @override
  String get paywallBenefitWidgetSync => '更完整的小组件与跨端同步';

  @override
  String get paywallPrimaryActionAnnual => '开通年会员';

  @override
  String get paywallPrimaryActionMonthly => '开通月会员';

  @override
  String get paywallPrimaryActionLifetime => '开通永久会员';

  @override
  String get paywallPrimaryActionTrial => '开始试用';

  @override
  String get paywallContinueFreeButton => '先继续免费版';

  @override
  String get insightsHistoryLocked => '超过免费范围';

  @override
  String insightsHistorySummary(int rate, int score) {
    return '达标率 $rate% · 稳定度 $score';
  }

  @override
  String insightsLatestLateSummary(String weekday, String time, int minutes) {
    return '$weekday $time 入睡，比目标晚 $minutes 分钟。';
  }

  @override
  String insightsLatestLateSummaryWithReasons(String base, String reasons) {
    return '$base 主要原因是 $reasons。';
  }

  @override
  String get insightsStabilitySummaryInsufficient => '样本还不够';

  @override
  String get insightsStabilitySummarySteady => '这一周节奏很稳';

  @override
  String get insightsStabilitySummaryRecovering => '这一周不是更差，而是正在回稳';

  @override
  String get insightsStabilitySummaryNeedsRecovery => '这周波动比较明显';

  @override
  String get insightsStabilityDescriptionInsufficient =>
      '至少需要 3 天有效记录，才能判断这周是否稳定。';

  @override
  String get insightsStabilityDescriptionSteady => '你的入睡偏差和波动都比较小，可以继续沿用当前节奏。';

  @override
  String get insightsStabilityDescriptionRecovering =>
      '虽然仍有波动，但整体已经开始收窄，优先处理高频拖延原因即可。';

  @override
  String get insightsStabilityDescriptionNeedsRecovery =>
      '当前偏差较大，建议优先执行 1 到 3 天恢复计划，把最晚入睡点先拉回阈值内。';

  @override
  String get insightsStabilityExplainerTitle => '稳定度说明';

  @override
  String insightsStabilityScoreLabel(int score) {
    return '当前得分 $score 分';
  }

  @override
  String get insightsStabilitySampleHint => '至少需要 3 天有效记录才会生成正式稳定度。';

  @override
  String get insightsRecoveryEffectTitle => '恢复效果';

  @override
  String get insightsRecoveryNoPlan => '当前这周还没有触发恢复计划。';

  @override
  String insightsRecoveryPlanSummary(int days) {
    return '最近一次明显晚睡后，建议用 $days 天把入睡时间拉回到阈值内。';
  }

  @override
  String insightsRecoveryPlanTitle(int days) {
    return '$days 天恢复节奏';
  }

  @override
  String get insightsRecoveryPlanDetailTitle => '恢复计划详情';

  @override
  String insightsRecoveryStepLabel(int day, String title) {
    return '第 $day 天 · $title';
  }

  @override
  String get insightsRecoveryStepCloseWorkEarlierTitle => '先把今晚收回来';

  @override
  String get insightsRecoveryStepCloseWorkEarlierDetail =>
      '把最后一项工作或娱乐提前到目标睡前 45 分钟前结束。';

  @override
  String get insightsRecoveryStepReduceNightNoiseTitle => '缩短拖延缓冲区';

  @override
  String get insightsRecoveryStepReduceNightNoiseDetail =>
      '今天只保留一个睡前动作，避免再次把节奏拖过阈值。';

  @override
  String get insightsRecoveryStepReviewLateTriggersTitle => '确认是否回到阈值内';

  @override
  String get insightsRecoveryStepReviewLateTriggersDetail =>
      '如果今晚仍偏晚，优先查看晚睡原因并保留最常见触发点。';

  @override
  String get insightsRecommendationFinishWorkEarlier =>
      '把睡前最后一项工作提前到 22:45 前结束';

  @override
  String get insightsRecommendationEnableSoftReminder => '周中高风险日优先启用柔性提醒';

  @override
  String get insightsRecommendationOpenRecoveryPlan => '若连续 2 天偏晚，直接查看恢复计划';

  @override
  String get insightsWeekdayMon => '周一';

  @override
  String get insightsWeekdayTue => '周二';

  @override
  String get insightsWeekdayWed => '周三';

  @override
  String get insightsWeekdayThu => '周四';

  @override
  String get insightsWeekdayFri => '周五';

  @override
  String get insightsWeekdaySat => '周六';

  @override
  String get insightsWeekdaySun => '周日';

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
  String get todayQuickActionsTitle => '快捷记录';

  @override
  String get todayQuickActionManualButton => '手动补录';

  @override
  String get todayQuickActionEditButton => '修改昨晚记录';

  @override
  String get todayQuickActionOpenHubButton => '进入记录管理';

  @override
  String get todayRecoveryDescription => '今晚先把最晚一件事提前完成，给明天留一点回正空间。';

  @override
  String get todayTrendEmptyState => '再积累几天就能看到趋势';

  @override
  String get todayStatusUserConfirmed => '用户确认结果';

  @override
  String get todayStatusGoalMet => '昨晚基本达标';

  @override
  String todayStatusLateBy(int minutes) {
    return '昨晚比目标晚了 $minutes 分钟';
  }

  @override
  String get todayStatusWithinThreshold => '已控制在阈值内';

  @override
  String todayStatusEarlyBy(int minutes) {
    return '比目标提前 $minutes 分钟';
  }

  @override
  String todayStatusLateDetail(int minutes) {
    return '比目标晚了 $minutes 分钟';
  }

  @override
  String get todayActionEnterBedtimeMode => '进入睡前模式';

  @override
  String get todayActionManualRecord => '手动补录昨晚记录';

  @override
  String get todayActionPermissionHelp => '查看权限说明';

  @override
  String get todayActionGoalSetup => '去设置目标作息';

  @override
  String get todayActionRecoveryPlan => '查看恢复建议';

  @override
  String todayActionTargetBedtime(String time) {
    return '今晚目标 $time';
  }

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
  String get recordSourceExplainerTitle => '数据来源说明';

  @override
  String get recordSourceExplainerDescription =>
      '说明这条记录来自哪里、可信度如何理解，以及为什么手动修正会成为最终确认结果。';

  @override
  String get recordSourceExplainerChipHealthKit => 'HealthKit';

  @override
  String get recordSourceExplainerChipManual => '手动修正';

  @override
  String get recordSourceExplainerChipConfidence => '可信度';

  @override
  String get recordSourceExplainerHealthTitle => '系统来源';

  @override
  String get recordSourceExplainerHealthBody =>
      '当睡眠数据来自 HealthKit 或 Health Connect 时，Rhythm 会保留原始来源，方便你回溯记录是从哪里来的。';

  @override
  String get recordSourceExplainerManualTitle => '手动修正';

  @override
  String get recordSourceExplainerManualBody =>
      '手动修改不会覆盖原始记录，而是生成一条用户确认结果，供今日页和日历优先展示。';

  @override
  String get recordSourceExplainerConfidenceTitle => '可信度';

  @override
  String get recordSourceExplainerConfidenceBody =>
      '可信度表示当前来源记录的完整度和可参考程度；一旦由你手动确认，会按最终展示结果处理。';

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
  String get onboardingStepOneEyebrow => 'STEP 1 · 欢迎进入';

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
  String get onboardingWelcomeQuickDuration => '通常只需要 3 分钟';

  @override
  String get onboardingWelcomeHeroTileLocalTitle => '本地优先';

  @override
  String get onboardingWelcomeHeroTileLocalSubtitle => '可先匿名体验';

  @override
  String get onboardingWelcomeHeroTileFeedbackTitle => '节律反馈';

  @override
  String get onboardingWelcomeHeroTileFeedbackSubtitle => '记录与提醒并行';

  @override
  String get onboardingWelcomeHeroTileFlowTitle => '三步完成';

  @override
  String get onboardingWelcomeHeroTileFlowSubtitle => '直接进入主线';

  @override
  String get onboardingWelcomeFooterNote => '后续每一步都可以返回调整，不会一次要求你填很多内容。';

  @override
  String get onboardingStepTwoEyebrow => '第 2 步 / 3';

  @override
  String get onboardingAuthEyebrow => '从今晚开始，先轻一点进入状态';

  @override
  String get onboardingAuthTitle => '今晚开始，慢慢早一点睡';

  @override
  String get onboardingAuthDescription => '先体验记录、提醒和睡前模式。等你觉得有用，再决定要不要绑定账号。';

  @override
  String get onboardingAuthOptionsTitle => '先选一个你舒服的进入方式';

  @override
  String get onboardingAuthOptionsDescription => '账号用于同步你的记录，游客模式也可以先体验主要流程。';

  @override
  String get onboardingAuthAppleLabel => '本地优先';

  @override
  String get onboardingAuthAppleDescription => '数据先留在设备里';

  @override
  String get onboardingAuthGoogleLabel => '随时绑定';

  @override
  String get onboardingAuthGoogleDescription => '之后再连账号也不会丢';

  @override
  String get onboardingAuthAnonymousButton => '使用匿名继续';

  @override
  String get onboardingAuthLaterButton => '使用 Apple 继续';

  @override
  String get onboardingAuthGoogleButton => '使用 Google 继续';

  @override
  String get onboardingAuthEmailButton => '使用邮箱继续';

  @override
  String get onboardingAuthFooterNote => '继续即表示你同意服务协议与隐私政策，后续可在设置中修改登录方式。';

  @override
  String get onboardingStepThreeEyebrow => '第 3 步 / 3';

  @override
  String get onboardingHealthTitle => '让系统帮你记录昨晚的睡眠';

  @override
  String get onboardingHealthDescription =>
      '授权后，首页会自动显示昨晚结果、趋势和恢复建议；不授权也能先手动记录。';

  @override
  String get onboardingHealthAppleSummary => '自动同步睡眠记录';

  @override
  String get onboardingHealthGoogleSummary => '近 30 天数据会写入本地节律时间线';

  @override
  String get onboardingHealthEmailSummary => '邮箱登录会保留后续绑定和找回路径，但当前仍以本地体验为主';

  @override
  String get onboardingHealthAnonymousSummary => '授权失败可降级';

  @override
  String get onboardingHealthDefaultSummary => '没有权限时仍能手动补录并生成周报';

  @override
  String get onboardingHealthBenefitTitle => '我们会读取什么';

  @override
  String get onboardingHealthBenefitDescription =>
      '入睡时间、起床时间、睡眠时长和来源状态，用来生成昨晚反馈与作息趋势。';

  @override
  String get onboardingHealthReadTitle => '会读取什么';

  @override
  String get onboardingHealthReadDescription => '自动读取昨晚的入睡和起床信息，尽量减少你手动输入。';

  @override
  String get onboardingHealthProtectTitle => '不会做什么';

  @override
  String get onboardingHealthProtectDescription =>
      '不会公开分享，不会用于医疗诊断，也不会影响你手动修改记录。';

  @override
  String get onboardingHealthOutcomeTitle => '你会得到什么';

  @override
  String get onboardingHealthOutcomeDescription => '更早看到昨晚结果、稳定度变化和更轻的恢复建议。';

  @override
  String get onboardingHealthUnderstandFirstButton => '我先了解一下';

  @override
  String get onboardingHealthLaterButton => '稍后再说';

  @override
  String get onboardingHealthFooterNote => '授权可随时在系统设置中关闭；我们只用来生成你的作息反馈。';

  @override
  String get onboardingHealthCurrentStageTitle => '当前阶段说明';

  @override
  String get onboardingHealthCurrentStageDescription =>
      '本任务只完成说明流程，不触发真实系统权限请求。';

  @override
  String get onboardingHealthSkipButton => '先手动记录';

  @override
  String get onboardingHealthAuthorizeButton => '授权读取睡眠数据';

  @override
  String get goalSetupEyebrow => '设置一个能做到的目标';

  @override
  String get goalSetupPageTitle => '先定一个你想靠近的作息';

  @override
  String get goalSetupPageDescription => '先设置入睡和起床时间，后面的阈值和细节可以再慢慢补。';

  @override
  String get goalSetupCardTitle => '先决定两个关键时间';

  @override
  String get goalSetupCardDescription => '点开时间卡后可进入滚轮调整。默认先给你一组常见作息，后面随时能改。';

  @override
  String get goalSetupBedtimeHint => '我们会围绕这个时间判断你是否晚睡。';

  @override
  String get goalSetupWakeHint => '用于计算你的节奏，并安排提醒窗口。';

  @override
  String get goalSetupFooterHint => '如果你现在还不确定，也可以先用这组默认值开始，后面在“我的”里再微调。';

  @override
  String get goalSetupContinueButton => '这样开始';

  @override
  String get goalSetupSecondaryButton => '稍后再细调';

  @override
  String get goalSetupBottomNote => '下一步会继续补充熬夜阈值和提醒方式，不会一次让你填很多。';

  @override
  String get goalSetupPickerConfirm => '确认时间';

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
  String get reminderSetupPageTitle => '提醒我在夜晚轻一点停下来';

  @override
  String get reminderSetupPageDescription => '先选一种不打扰的提醒方式；后面随时都能在设置里改。';

  @override
  String get reminderSetupPanelTitle => '你希望我怎么提醒你';

  @override
  String get reminderSetupPanelDescription =>
      '默认推荐柔和提醒。首启阶段先帮你把打扰感压低，等你熟悉后再精调频率。';

  @override
  String get reminderSetupSoftTitle => '柔和提醒';

  @override
  String get reminderSetupSoftDescription => '在目标入睡前轻提醒一次，不催促，只提醒你开始收尾。';

  @override
  String get reminderSetupStandardTitle => '标准提醒';

  @override
  String get reminderSetupStandardDescription => '临近目标时间提醒一次，到点后再轻轻补一句，更稳一点。';

  @override
  String get reminderSetupOffTitle => '先不开提醒';

  @override
  String get reminderSetupOffDescription => '先靠自己感受节奏，等你准备好了再把提醒打开。';

  @override
  String get reminderSetupContinueButton => '按这个继续';

  @override
  String get reminderSetupSecondaryButton => '之后再设置';

  @override
  String get reminderSetupBottomNote => '提醒方式不会固定锁死；后面你可以改成更轻或更明确的节奏。';

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

  @override
  String get bedtimePageTitle => '睡前模式';

  @override
  String get bedtimeCountdownTitle => '今晚目标';

  @override
  String get bedtimeCurrentTimeLabel => '现在';

  @override
  String get bedtimeTargetTimeLabel => '目标';

  @override
  String bedtimeTargetDiffAhead(int minutes) {
    return '距离目标入睡还有 $minutes 分钟';
  }

  @override
  String bedtimeTargetDiffLate(int minutes) {
    return '已经晚于目标入睡 $minutes 分钟';
  }

  @override
  String get bedtimeStatusTitle => '今晚现在更像哪种状态？';

  @override
  String get bedtimeHeroSubtitle => '现在还来得及。你不需要一次做很多，只要先让今晚少拖一点点。';

  @override
  String get bedtimeStatusDescription => '先选一个最接近你的状态，后面动作建议会跟着变。';

  @override
  String get bedtimeStatusReady => '准备睡觉';

  @override
  String get bedtimeStatusMoreTime => '还想拖一会儿';

  @override
  String get bedtimeStatusLikelyLate => '今晚大概率会晚睡';

  @override
  String get bedtimeActionTitle => '下一步先轻一点';

  @override
  String get bedtimeActionDescriptionReady => '先把刺激降下来，让身体更快收到今晚已经结束的信号。';

  @override
  String get bedtimeActionDescriptionMoreTime =>
      '先停掉最容易拖住你的那件事，再把明早要处理的事情写给明天的自己。';

  @override
  String get bedtimeActionDescriptionLikelyLate => '先接受今晚可能会偏晚，再给明早留一个最轻的恢复动作。';

  @override
  String get bedtimeActionDimLights => '先把灯光收暗一点';

  @override
  String get bedtimeActionPutPhoneAway => '先把手机放远一点';

  @override
  String get bedtimeActionTenMinuteWrapUp => '给自己 10 分钟收尾';

  @override
  String get bedtimeActionCloseTonight => '今晚先尽快收尾';

  @override
  String get bedtimeActionPlanRecoveryTomorrow => '给明早留一个轻恢复动作';

  @override
  String get bedtimeOptionalTagsTitle => '如果需要，也可以顺手记一下';

  @override
  String get bedtimeTrendDescription => '你已经比上周平均早睡了 18 分钟。';

  @override
  String get bedtimeGoalMissingTitle => '还没有设置今晚目标';

  @override
  String get bedtimeGoalMissingDescription => '睡前模式需要先知道你的目标作息，才能给出今晚倒计时和建议。';

  @override
  String get bedtimeGoalMissingButton => '去设置目标作息';

  @override
  String get commonCancelButton => '取消';

  @override
  String get commonConfirmButton => '确认';

  @override
  String get accountSyncPageTitle => '先本地，后同步';

  @override
  String get accountSyncPageDescription => '登录是为了换机恢复、多端一致和会员状态同步。';

  @override
  String get accountSyncCurrentIdentityTitle => '当前身份';

  @override
  String get accountSyncSyncStatusTitle => '同步状态';

  @override
  String get accountSyncConflictPolicyTitle => '冲突策略';

  @override
  String get accountSyncConflictPolicyDescription =>
      '冲突时以用户手动修改结果优先，同时保留来源和更新时间。';

  @override
  String get accountSyncIdentityAnonymousTitle => '匿名用户';

  @override
  String get accountSyncIdentityAnonymousDescription => '本地优先 · 可随时绑定账号';

  @override
  String get accountSyncIdentitySignInRequiredDescription =>
      '本地优先 · 登录后可恢复多端同步';

  @override
  String get accountSyncIdentityLinkedFallbackTitle => '已绑定账号';

  @override
  String get accountSyncIdentityLinkedDescription => '已绑定账号 · 云端会话可恢复';

  @override
  String get accountSyncIdentityConnectedDescription => '已绑定账号 · 云端会话已连接';

  @override
  String get accountSyncBindAppleButton => '绑定 Apple 账号';

  @override
  String get accountSyncViewAccountButton => '查看账号状态';

  @override
  String get accountSyncCloudIdentityPendingTitle => '云端同步身份尚未建立';

  @override
  String get accountSyncCloudIdentityReadyTitle => '已建立云端同步身份';

  @override
  String get accountSyncCloudIdentityPendingButton => '建立云端同步身份';

  @override
  String get accountSyncCloudIdentityReadyButton => '云端同步身份已就绪';

  @override
  String get accountSyncLocalOnlyDescription => '当前环境保持本地优先模式，未触发云端同步。';

  @override
  String get accountSyncSignInRequiredDescription =>
      '登录后才会触发云端同步，本地数据会继续留在当前设备。';

  @override
  String get accountSyncFailedDescription => '最近一次云端同步失败了，你可以稍后重试，同时继续使用本地数据。';

  @override
  String get accountSyncSyncedDescription => '已启用云端同步';

  @override
  String get accountSyncRetryButton => '重试同步';

  @override
  String get accountSyncLastSyncedLabel => '最近同步：';

  @override
  String get accountSyncUnavailableError => '账号与同步状态暂时不可用';

  @override
  String get profileHeroAnonymousTitle => '匿名用户';

  @override
  String get profileHeroAnonymousSubtitle => '本地优先 · 可随时绑定账号';

  @override
  String get profileHeroBadgeLabel => '免费版';

  @override
  String get profileHeroSummaryTitle => '你的节奏已经开始成形';

  @override
  String get profileHeroSummarySubtitle =>
      '账户、同步、提醒、目标和小组件都在这里管理。需要的时候再进来细调，不用一次弄完。';

  @override
  String get profileMembershipEntryTitle => '会员中心';

  @override
  String get profileMembershipEntrySubtitle => '解锁恢复计划详情、长期历史和月报入口';

  @override
  String get profileMembershipSyncCardTitle => '账户与会员';

  @override
  String get profileGoalScheduleEntryTitle => '目标作息设置';

  @override
  String get profileGoalScheduleEntryEmpty => '还没有保存目标作息';

  @override
  String get profileGoalScheduleEntryLoading => '正在读取目标作息';

  @override
  String get profileGoalScheduleEntryError => '目标作息暂时不可用';

  @override
  String get profileGoalReminderCardTitle => '目标与提醒';

  @override
  String get profileNotificationEntryTitle => '提醒设置';

  @override
  String get profileNotificationEntryEnabled => '柔性提醒已开启';

  @override
  String get profileNotificationEntryDisabled => '提醒策略待调整';

  @override
  String get profileDataAccessEntryTitle => '数据接入与权限';

  @override
  String get profileDataAccessEntryLoading => '正在读取接入状态';

  @override
  String get profileDataAccessEntryError => '接入状态暂时不可用';

  @override
  String get profileDisplayDeviceCardTitle => '显示与设备';

  @override
  String get profileTimezoneModeEntryTitle => '时区与特殊模式';

  @override
  String profileTimezoneModeEntrySubtitle(String timezone) {
    return '$timezone · 记录归属与特殊情况';
  }

  @override
  String get profilePrivacyEntryTitle => '隐私与数据';

  @override
  String get profilePrivacyEntrySubtitle => '导出、删除、协议';

  @override
  String get profilePrivacyExportCardTitle => '隐私与导出';

  @override
  String get profilePreferencesCardTitle => '偏好设置';

  @override
  String get profilePreferencesLocaleTitle => '语言';

  @override
  String get profilePreferencesThemeTitle => '主题';

  @override
  String get profilePreferencesFollowSystem => '跟随系统';

  @override
  String get profilePreferencesSystemShort => '系统';

  @override
  String get profilePreferencesSimplifiedChinese => '简体中文';

  @override
  String get profilePreferencesSimplifiedChineseNative => '简体中文';

  @override
  String get profilePreferencesEnglish => 'English';

  @override
  String get profilePreferencesLight => '浅色';

  @override
  String get profilePreferencesDark => '深色';

  @override
  String get profilePreferencesSaveFailed => '设置未保存成功，请稍后再试';

  @override
  String get profileDesktopPresenceTitle => '桌面存在感';

  @override
  String get profileDesktopPresenceDescription =>
      '把小组件放到桌面后，今晚目标和昨晚状态会一直留在你的视线里。';

  @override
  String get widgetGuideEyebrow => '把今晚的目标放到桌面上';

  @override
  String get widgetGuideTitle => '把今晚的目标放到桌面上';

  @override
  String get widgetGuideDescription =>
      '你不用每次都打开 App。把它放到桌面后，今晚剩余时间和目标作息会一直在眼前。';

  @override
  String get widgetGuidePreviewPanelTitle => '添加后，你会先看到这些';

  @override
  String get widgetGuidePreviewPanelDescription =>
      '首发先提供一个基础小组件：看今晚目标、剩余时间和最近状态。后面还可以换更细的样式。';

  @override
  String get widgetGuidePrimaryCardLabel => '今晚目标 23:30';

  @override
  String get widgetGuidePrimaryCardValue => '01:42';

  @override
  String get widgetGuidePrimaryCardDescription => '距离准备睡觉还剩一点时间，记得开始收尾。';

  @override
  String get widgetGuidePrimaryCardBadge => '已连续 3 天';

  @override
  String get widgetGuideSecondaryCardLabel => '明早起床 07:30';

  @override
  String get widgetGuideSecondaryCardValue => '睡前剩余 1 小时 42 分';

  @override
  String get widgetGuideSecondaryCardStatus => '今晚偏稳';

  @override
  String get widgetGuidePreviewPanelNote =>
      '添加后，你会更容易在锁屏前想起今晚的目标；不需要主动打开 App 才看得到。';

  @override
  String get widgetGuidePreviewTitle => 'Rhythm 小组件';

  @override
  String get widgetGuidePreviewRemaining => '距目标 52m';

  @override
  String get widgetGuidePreviewSummary => '今晚目标 23:30\n昨晚比目标晚 26 分钟';

  @override
  String get widgetGuideStepAdd => '• 长按桌面，添加小组件';

  @override
  String get widgetGuideStepChoose => '• 搜索 Rhythm，选择中号组件';

  @override
  String get widgetGuideStepPlace => '• 把它放在晚上最容易看见的位置';

  @override
  String get widgetGuidePrimaryButton => '去添加小组件';

  @override
  String get widgetGuideSecondaryButton => '以后再说';

  @override
  String get widgetGuideBottomNote => '不同系统的添加方式会略有区别；我们下一步会用最短路径带你完成。';

  @override
  String get widgetThemePageTitle => '小组件与主题';

  @override
  String get widgetThemePreviewTitle => '桌面预览';

  @override
  String get widgetThemePreviewTargetCaption => '今晚目标';

  @override
  String get widgetThemePreviewLastNightMissing => '昨晚还没有记录';

  @override
  String widgetThemeMinutesToTargetAhead(int minutes) {
    return '距目标 $minutes 分钟';
  }

  @override
  String widgetThemeMinutesToTargetLate(int minutes) {
    return '已晚于目标 $minutes 分钟';
  }

  @override
  String get widgetThemeStateGoalMissingTitle => '还没有目标作息';

  @override
  String get widgetThemeStateGoalMissingDescription =>
      '先设置目标作息后，小组件才知道今晚该展示哪条参考线。';

  @override
  String get widgetThemeStateGoalMissingAction => '去设置目标作息';

  @override
  String get widgetThemeStateNoDataTitle => '昨晚还没有记录';

  @override
  String get widgetThemeStateNoDataDescription =>
      '小组件会继续展示今晚目标，等你补录或同步到昨晚结果后再补齐状态。';

  @override
  String get widgetThemeStateNoDataAction => '去补录昨晚记录';

  @override
  String get widgetThemeStatePermissionTitle => '需要先授权睡眠数据';

  @override
  String get widgetThemeStatePermissionDescription => '小组件只会展示必要信息，不会展开原始睡眠细节。';

  @override
  String get widgetThemeStatePermissionAction => '查看数据接入说明';

  @override
  String get widgetThemeStateReadyDescription => '当前桌面快照已经能展示今晚目标与昨晚状态。';

  @override
  String get widgetThemePinButton => '添加到桌面';

  @override
  String get widgetThemePinningButton => '正在打开系统添加面板';

  @override
  String get widgetThemePinSuccess => '系统添加面板已打开';

  @override
  String get widgetThemePinManualHint => '请先在系统桌面手动添加 Rhythm 小组件';

  @override
  String get widgetThemePinFailure => '暂时无法打开系统添加面板，请稍后再试';

  @override
  String get widgetThemeRefreshButton => '刷新小组件快照';

  @override
  String get widgetThemeRefreshingButton => '正在刷新小组件快照';

  @override
  String get widgetThemeRefreshSuccess => '小组件快照已刷新';

  @override
  String get widgetThemeRefreshFailure => '刷新失败，请稍后再试';

  @override
  String get widgetThemeRefreshUnavailable => '当前设备还没有添加 Rhythm 小组件';

  @override
  String get widgetThemeOpenTodayButton => '打开今日页';

  @override
  String get widgetThemeOpenBedtimeButton => '进入睡前模式';

  @override
  String widgetSnapshotLastNightLate(int minutes) {
    return '昨晚晚 $minutes 分钟';
  }

  @override
  String widgetSnapshotLastNightEarly(int minutes) {
    return '昨晚早 $minutes 分钟';
  }

  @override
  String get widgetSnapshotLastNightOnTime => '昨晚准点';

  @override
  String get commonRecordSourceHealthKit => 'HealthKit';

  @override
  String get commonRecordSourceHealthConnect => 'Health Connect';

  @override
  String get commonRecordSourceManual => '手动补录';

  @override
  String get commonRecordSourceImported => '导入记录';

  @override
  String get commonConfidenceHigh => '高可信';

  @override
  String get commonConfidenceMedium => '可用';

  @override
  String get commonConfidenceLow => '低可信';

  @override
  String get commonConfidenceUnknown => '未知可信度';

  @override
  String get profileHealthSummaryHealthKitConnected => 'HealthKit 已连接';

  @override
  String get profileHealthSummaryHealthConnectConnected => 'Health Connect 已连接';

  @override
  String get profileHealthSummaryPermissionRequired => '需要重新授权';

  @override
  String get profileHealthSummaryManualFallback => '当前先使用手动模式';

  @override
  String get dataAccessPageTitle => '健康数据接入状态';

  @override
  String get dataAccessPageDescription => '自动记录是加速器，手动补录是保底路径。';

  @override
  String get dataAccessReauthorizeButton => '重新授权';

  @override
  String get dataAccessManualModeButton => '改用手动模式';

  @override
  String get dataAccessStatusHealthKitConnected => 'HealthKit 已连接';

  @override
  String get dataAccessStatusHealthConnectConnected => 'Health Connect 已连接';

  @override
  String get dataAccessStatusInstallRequired => '需要安装 Health Connect';

  @override
  String get dataAccessStatusPermissionRequired => '需要重新授权';

  @override
  String get dataAccessStatusManualFallback => '当前先使用手动模式';

  @override
  String dataAccessStatusConnectedDescription(int count) {
    return '最近 30 天已写入 $count 条记录。';
  }

  @override
  String get dataAccessStatusInstallRequiredDescription =>
      '当前设备尚未安装 Health Connect，安装后才能继续自动读取睡眠数据。';

  @override
  String get dataAccessStatusPermissionRequiredDescription =>
      '当前还没有读取睡眠数据的权限，重新授权后即可恢复自动读取。';

  @override
  String get dataAccessStatusManualFallbackDescription =>
      '如果当前设备不支持自动读取，你仍然可以继续手动补录和查看趋势。';

  @override
  String get goalScheduleSettingsPageTitle => '微调你的参考线';

  @override
  String get goalScheduleSettingsPageDescription => '目标越贴近真实生活，反馈就越有用。';

  @override
  String get goalScheduleSettingsSummaryBedtimeLabel => '目标入睡时间';

  @override
  String get goalScheduleSettingsSummaryWakeLabel => '目标起床时间';

  @override
  String get goalScheduleSettingsSummaryLateThresholdLabel => '晚睡阈值';

  @override
  String get goalScheduleSettingsSummaryDayStartLabel => '一天起始时间';

  @override
  String get goalScheduleSettingsHintDescription =>
      '如果最近两周经常无法达到目标，可以把目标先往现实靠近 10-15 分钟，再慢慢提前。';

  @override
  String get goalScheduleSettingsSaveButton => '保存修改';

  @override
  String get notificationSettingsPageTitle => '让提醒保持温和';

  @override
  String get notificationSettingsPageDescription => '优先做引导，不做高压监督。';

  @override
  String get notificationSettingsPermissionGranted => '通知权限已开启';

  @override
  String get notificationSettingsPermissionMissing => '通知权限未开启';

  @override
  String get notificationSettingsLeadTitle => '提前量';

  @override
  String get notificationSettingsSaveButton => '保存提醒策略';

  @override
  String get privacyDataPageTitle => '敏感数据要清楚可控';

  @override
  String get privacyDataPageDescription => '先告诉你会发生什么，再让你决定是否继续。';

  @override
  String get privacyDataPolicyTitle => '隐私协议';

  @override
  String get privacyDataPolicyDescription => '查看我们如何存储和使用数据';

  @override
  String get privacyDataPolicyDialogMessage =>
      '当前版本会在本地保存目标、记录、标签与提醒设置，不会把数据用于广告。';

  @override
  String get privacyDataExportTitle => '导出数据';

  @override
  String get privacyDataExportDescription => '把目标、记录、标签和周报导出';

  @override
  String get privacyDataExportDialogTitle => '确认导出数据';

  @override
  String get privacyDataExportDialogMessage => '导出会包含目标作息、睡眠记录、标签和周报摘要，请确认继续。';

  @override
  String get privacyDataDeleteAccountTitle => '删除账号';

  @override
  String get privacyDataDeleteAccountDescription => '删除云端账号与同步关系';

  @override
  String get privacyDataDeleteAccountDialogTitle => '确认删除账号';

  @override
  String get privacyDataDeleteAccountDialogMessage =>
      '删除账号后会断开当前设备与云端同步关系，本地数据不会自动恢复。';

  @override
  String get privacyDataClearLocalTitle => '清空本地数据';

  @override
  String get privacyDataClearLocalDescription => '仅清空当前设备缓存';

  @override
  String get privacyDataClearLocalDialogTitle => '确认清空本地数据';

  @override
  String get privacyDataClearLocalDialogMessage =>
      '清空后会移除当前设备上的目标、记录和标签缓存，请再次确认。';

  @override
  String get privacyDataDangerCardTitle => '危险操作需要二次确认';

  @override
  String get privacyDataDangerCardDescription =>
      '删除账号和清空数据都必须经过确认对话框，不会在普通列表点击后直接执行。';

  @override
  String get timezoneModePageTitle => '时区与记录归属';

  @override
  String get timezoneModePageDescription => '这里会说明时区变化对记录归属的影响，以及特殊作息的处理方式。';

  @override
  String get timezoneModeCurrentTimezoneTitle => '当前时区';

  @override
  String get timezoneModeCurrentTimezoneDescription =>
      '记录会保存事件发生时的时区，旧记录不会因切换时区被重算归属日。';

  @override
  String get timezoneModeSpecialModeTitle => '特殊情况';

  @override
  String get timezoneModeCrossTimezoneDescription =>
      '• 跨时区时，如果检测到时区变化，我们会提醒你确认目标是否需要临时调整。';

  @override
  String get timezoneModeShiftWorkDescription =>
      '• 轮班作息暂不参与默认达标计算，建议先把记录和目标分开查看。';
}
