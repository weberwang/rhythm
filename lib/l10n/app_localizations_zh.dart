// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Rhythm';

  @override
  String get launchLoadingTitle => '正在准备你的 Rhythm';

  @override
  String get launchLoadingBody => '正在装配本地优先基线与根路由宿主。';

  @override
  String get launchErrorTitle => '启动基线需要修复';

  @override
  String get launchErrorBody => '初始化基线尚未准备完成，请重试。';

  @override
  String get retry => '重试';

  @override
  String get onboardingTitle => '激活引导';

  @override
  String get onboardingBody => '初始化阶段只保留引导路由骨架，完整激活漏斗将在后续模块实现阶段接入。';

  @override
  String get onboardingContinue => '进入主壳';

  @override
  String onboardingStepCounter(int current, int total) {
    return '第 $current 步 / $total';
  }

  @override
  String get onboardingWelcomeTitle => '欢迎使用 Rhythm';

  @override
  String get onboardingWelcomeBody => '从今晚开始，用更温和的方式建立稳定作息，先完成一轮简短的引导设置。';

  @override
  String get onboardingEntryTitle => '选择进入方式';

  @override
  String get onboardingEntryBody => '先完成本地激活，后续再决定是否连接账号与同步能力。';

  @override
  String get onboardingPermissionTitle => '先理解价值，再决定是否授权';

  @override
  String get onboardingPermissionBody => '这一页先说明健康权限会带来什么，不会立即请求真实系统权限。';

  @override
  String get onboardingGoalTitle => '设置目标作息';

  @override
  String get onboardingGoalBody => '先给今晚一个清晰目标。后续提醒、睡前模式和今日页都会基于这组时间继续工作。';

  @override
  String get onboardingReminderTitle => '提醒怎么开始更合适';

  @override
  String get onboardingReminderBody => '先选一个今晚就愿意接受的提醒姿态，后续仍可在设置中精调。';

  @override
  String get onboardingWidgetGuideTitle => '把 Rhythm 放到桌面，回到今晚更快';

  @override
  String get onboardingWidgetGuideBody => '桌面入口不是必须，但它能让你在今晚和明早更快回到关键动作。';

  @override
  String get onboardingWidgetGuideBaseTitle => '这一步只负责说明价值，不强迫你现在配置';

  @override
  String get onboardingWidgetGuideBaseBody =>
      '先完成今晚激活，后续再按你的设备能力决定是否把 Rhythm 固定到桌面。';

  @override
  String get onboardingWidgetGuideSupportedTitle => '当前设备支持直接固定入口';

  @override
  String get onboardingWidgetGuideSupportedBody =>
      '当你准备好后，可以把 Rhythm 固定到桌面或小组件面板，减少再次寻找入口的成本。';

  @override
  String get onboardingWidgetGuideManualTitle => '这个平台更适合稍后手动添加';

  @override
  String get onboardingWidgetGuideManualBody =>
      '先完成今晚激活。之后可在主屏编辑模式里把 Rhythm 小组件加到桌面。';

  @override
  String get onboardingWidgetGuideUnavailableTitle => '当前设备暂不支持桌面小组件';

  @override
  String get onboardingWidgetGuideUnavailableBody =>
      '这不会影响今晚开始使用。之后换到移动设备时再添加桌面入口即可。';

  @override
  String get onboardingCompletionTitle => '今晚已经可以开始';

  @override
  String get onboardingCompletionBody =>
      'Rhythm 已经拿到开始第一晚所需的最小信息，接下来会把你自然带入主壳。';

  @override
  String get onboardingStartSetup => '开始设置';

  @override
  String get onboardingContinueSetup => '继续设置';

  @override
  String get onboardingFinishSetup => '完成并进入今日页';

  @override
  String get onboardingBack => '返回';

  @override
  String get onboardingBenefitReminderTitle => '轻提醒，不打断';

  @override
  String get onboardingBenefitReminderBody => '先建立节奏，再决定是否打开更完整的提醒策略。';

  @override
  String get onboardingBenefitRoutineTitle => '更容易坚持的睡前节奏';

  @override
  String get onboardingBenefitRoutineBody => '把复杂设置拆成可执行的小步骤，先让今晚可用。';

  @override
  String get onboardingBenefitTrackingTitle => '先用起来，再慢慢完善';

  @override
  String get onboardingBenefitTrackingBody => '先完成基础作息目标，后续再接健康数据、同步和洞察。';

  @override
  String get onboardingEntryLocalTitle => '先本地开始';

  @override
  String get onboardingEntryLocalBody => '直接进入本地优先体验，今晚就可以设置目标作息和提醒策略。';

  @override
  String get onboardingEntryAppleTitle => '使用 Apple 登录';

  @override
  String get onboardingEntryAppleBody =>
      '先把你的 Apple 身份接进引导，后续再继续补健康权限、目标作息和同步语义。';

  @override
  String get onboardingEntryGoogleTitle => '使用 Google 登录';

  @override
  String get onboardingEntryGoogleBody =>
      '先把你的 Google 身份接进引导，后续再继续补健康权限、目标作息和同步语义。';

  @override
  String get onboardingEntryAuthCancelledTitle => '这次登录已取消';

  @override
  String get onboardingEntryAuthCancelledBody =>
      '你可以再试一次，或者改走本地优先路径，先把今晚的引导完成。';

  @override
  String get onboardingEntryAuthUnavailableTitle => '当前设备暂时不能走这个登录入口';

  @override
  String get onboardingEntryAuthUnavailableBody =>
      '你可以改走本地优先路径，先完成今晚引导，后续再在支持的平台上补账号同步。';

  @override
  String get onboardingEntryAuthFailedTitle => '登录没有成功完成';

  @override
  String get onboardingEntryAuthFailedBody =>
      '请重试一次；如果当前环境还没准备好，也可以先按本地优先路径继续使用。';

  @override
  String get onboardingHealthValueTitle => '先理解价值，再决定是否授权';

  @override
  String get onboardingHealthValueBody =>
      '当前步骤只说明健康数据能带来什么，不会立刻请求系统权限；即使之后拒绝，也仍然可以继续使用手动路径。';

  @override
  String get onboardingPermissionBenefitTitle => '健康数据能补全什么';

  @override
  String get onboardingPermissionBenefitBody =>
      '当你之后愿意连接时，它可以帮助补全睡眠记录、可信度标记和后续洞察。';

  @override
  String get onboardingPermissionPrivacyTitle => '当前不会默认读取什么';

  @override
  String get onboardingPermissionPrivacyBody =>
      '本轮激活不会请求真实权限，也不会因为未授权而阻断本地优先使用。';

  @override
  String get onboardingPermissionFallbackTitle => '即使不授权也能继续';

  @override
  String get onboardingPermissionFallbackBody =>
      '后续如果你仍选择跳过健康权限，Rhythm 也会继续围绕手动作息目标与晚间行动工作。';

  @override
  String get onboardingBedtimeLabel => '目标入睡时间';

  @override
  String get onboardingWakeTimeLabel => '目标起床时间';

  @override
  String get onboardingGoalHint => '不需要一次就设得很完美。先给自己一个愿意尝试的节奏，后续仍可以在设置页调整。';

  @override
  String get onboardingReminderGentleTitle => '先用轻提醒';

  @override
  String get onboardingReminderGentleBody => '给自己一个更柔和的睡前提示，优先降低打扰感和心理压力。';

  @override
  String get onboardingReminderNoneTitle => '先不主动提醒';

  @override
  String get onboardingReminderNoneBody => '先完成激活并观察你的自然节奏，之后再到设置页补提醒时机。';

  @override
  String get onboardingCompletionSummaryTitle => '你的首晚准备已就绪';

  @override
  String get onboardingCompletionSummaryBody =>
      '本轮激活会把这组起始节奏带进应用，你之后仍可以继续细化同步、提醒和权限设置。';

  @override
  String get onboardingCompletionScheduleLabel => '目标作息';

  @override
  String onboardingCompletionScheduleValue(Object bedtime, Object wakeTime) {
    return '$bedtime 到 $wakeTime';
  }

  @override
  String get onboardingCompletionEntryLabel => '进入方式';

  @override
  String get onboardingCompletionReminderLabel => '提醒策略';

  @override
  String get onboardingCompletionHealthLabel => '健康权限';

  @override
  String get onboardingPermissionStatusGranted => '已授权';

  @override
  String get onboardingPermissionStatusDeferred => '稍后决定';

  @override
  String get onboardingPermissionStatusUnavailable => '当前设备不支持';

  @override
  String get tabToday => '今日';

  @override
  String get tabBedtime => '睡前';

  @override
  String get tabCalendar => '日历';

  @override
  String get tabInsights => '洞察';

  @override
  String get tabProfile => '我的';

  @override
  String get placeholderStatus => '初始化占位';

  @override
  String get todayTitle => '今日';

  @override
  String get todayBody => '今日页会在后续实现阶段接入 sleep-data-core 的共享数据契约。';

  @override
  String todayGreetingNamed(Object name) {
    return '早安，$name';
  }

  @override
  String get todayGreetingGeneric => '早安，今晚先按节奏开始';

  @override
  String get todayGreetingBody => '先看昨晚，再决定今晚怎么做。';

  @override
  String get todaySectionLastNight => '昨晚结果';

  @override
  String get todayLastNightNoDataTitle => '昨晚数据还在建立中';

  @override
  String get todayLastNightNoDataBody =>
      '你已经完成激活。今晚开始记录后，这里会优先告诉你昨晚结果、来源可信度和下一步建议。';

  @override
  String get todayLastNightSyncTitle => '本地结果已保住，稍后再修复同步';

  @override
  String get todayLastNightSyncBody =>
      '当前同步没有完整完成，但你的更新仍安全保留在这台设备里，今晚先继续按目标作息推进。';

  @override
  String get todayLastNightManualTitle => '这份结果来自手动修正';

  @override
  String get todayLastNightManualBody =>
      'Rhythm 会继续尊重你最近一次的手动调整，并据此安排今晚目标和后续解释。';

  @override
  String get todayLastNightOnTargetTitle => '昨晚基本贴近目标';

  @override
  String get todayLastNightOnTargetBody => '昨晚已经比较稳，不需要额外用力补救。今晚继续守住这条节奏就够了。';

  @override
  String get todayLastNightSlightDelayTitle => '昨晚比目标稍晚了一点';

  @override
  String get todayLastNightSlightDelayBody =>
      '这次偏移还在可控范围内。今晚把放松动作提前一点，明早起床时间先稳住。';

  @override
  String get todayLastNightMajorDelayTitle => '昨晚明显晚于目标';

  @override
  String get todayLastNightMajorDelayBody => '今晚优先把节奏往前拉回来，早点降刺激，别再让明早继续后移。';

  @override
  String get todaySectionTonightGoal => '今晚目标';

  @override
  String get todayTonightGoalHeadline => '目标入睡时间';

  @override
  String get todayTonightGoalReminderLabel => '放松提醒';

  @override
  String todayTonightGoalBody(Object windDown, Object wakeTime) {
    return '建议在 $windDown 开始放松，明早目标起床时间保持在 $wakeTime。';
  }

  @override
  String get todaySectionRecovery => '恢复建议';

  @override
  String get todayRecoveryBuildBaselineTitle => '先把第一晚记录跑起来';

  @override
  String get todayRecoveryBuildBaselineBody => '先完成今晚的睡前流程，明早再回来看首个结果和恢复建议。';

  @override
  String get todayRecoverySyncTitle => '先按本地节奏继续，稍后再修复同步';

  @override
  String get todayRecoverySyncBody => '现在最重要的是维持今晚节奏，不要为了同步问题打断已经建立的本地记录链路。';

  @override
  String get todayRecoveryDelayTitle => '今晚先把节奏往前拉一格';

  @override
  String get todayRecoveryDelayBody => '这次偏移已经够明显，今晚把收尾动作做短做实，明早也不要用晚起去补偿。';

  @override
  String get todayRecoveryMomentumTitle => '保持这次修正后的节奏';

  @override
  String get todayRecoveryMomentumBody =>
      '既然你已经手动校正了结果，今晚就先围绕这条目标作息保持一致，不要再叠加太多动作。';

  @override
  String get todaySectionQuickRecord => '快捷记录';

  @override
  String get todayQuickRecordTitle => '记录今晚的 check-in';

  @override
  String get todayQuickRecordRecommendedBody =>
      '如果你今晚偏离目标，可以快速补一条心情、能量或备注，方便明早解释结果。';

  @override
  String get todayQuickRecordOptionalBody => '今晚如果有额外感受，也可以补一条简短记录，帮助后续趋势逐步建立。';

  @override
  String get todayQuickRecordSheetTitle => '补录昨晚记录';

  @override
  String get todayQuickRecordSheetBody => '先把最小事实补上，让昨晚结果卡和首周趋势不再回退到占位语义。';

  @override
  String get todayQuickRecordDateLabel => '记录日期';

  @override
  String get todayQuickRecordBedtimeLabel => '入睡时间';

  @override
  String get todayQuickRecordWakeTimeLabel => '起床时间';

  @override
  String get todayQuickRecordNoteLabel => '备注（可选）';

  @override
  String get todayQuickRecordSaveAction => '保存记录';

  @override
  String get todayQuickRecordSaved => '昨晚记录已保存。';

  @override
  String get todaySectionTrend => '7 日趋势';

  @override
  String get todayTrendScoreLabel => '睡眠分';

  @override
  String get todayTrendBuildingTitle => '7 日趋势会从今晚开始建立';

  @override
  String get todayTrendBuildingBody => '首周先累计可解释样本，趋势区块只负责给你上下文，不会抢走首页主判断。';

  @override
  String get todayTrendReadyBody => '这条折线已经开始消费你的最近样本，可以更快判断节奏是不是在往目标回拉。';

  @override
  String get todayFooterHint =>
      '今日页当前先消费已落地的目标作息、共享状态和账号快照；真实睡眠记录接线会在后续模块继续补齐。';

  @override
  String get todayErrorTitle => '今日快照暂时没恢复出来';

  @override
  String get todayErrorBody => '你仍然可以继续使用主壳；稍后再次进入今日页时，Rhythm 会重新拉起这份首页聚合快照。';

  @override
  String get bedtimeTitle => '睡前';

  @override
  String get bedtimeBody => '睡前专注流程已完成脚手架初始化，等待模块实现阶段接线。';

  @override
  String get bedtimeEntryFromToday => '今日页进入';

  @override
  String get bedtimeEntryFromNotification => '通知进入';

  @override
  String get bedtimeEntryFromWidget => '小组件进入';

  @override
  String bedtimeBeforeTargetHeadline(Object minutes) {
    return '距离目标还有 $minutes 分钟';
  }

  @override
  String bedtimeAfterTargetHeadline(Object minutes) {
    return '已经晚于目标 $minutes 分钟';
  }

  @override
  String get bedtimeCompletedHeadline => '今晚已经完成收尾';

  @override
  String bedtimeBeforeTargetBody(Object bedtime) {
    return '把注意力收回到今晚的单一决定上，目标入睡时间是 $bedtime。';
  }

  @override
  String bedtimeDelayBody(Object wakeTime) {
    return '今晚优先止损，明早目标仍保持在 $wakeTime。';
  }

  @override
  String bedtimeCompletedBody(Object wakeTime) {
    return '保持明早 $wakeTime 起床，不需要再继续叠加更多动作。';
  }

  @override
  String get bedtimeTargetBedtimeLabel => '目标入睡';

  @override
  String get bedtimeTargetWakeLabel => '目标起床';

  @override
  String get bedtimeChoiceSectionTitle => '今晚先做哪一种判断？';

  @override
  String get bedtimeChoiceReadyTitle => '准备睡了';

  @override
  String get bedtimeChoiceReadyBody => '不再扩展任务，直接进入最小收尾动作。';

  @override
  String get bedtimeChoiceWindDownTitle => '还要一点收尾';

  @override
  String get bedtimeChoiceWindDownBody => '留给自己一个短缓冲，但不要再打开新的刺激源。';

  @override
  String get bedtimeChoiceDelayTitle => '今晚大概率会晚睡';

  @override
  String get bedtimeChoiceDelayBody => '承认会偏移，但先把明早和接下来的恢复损失降到最小。';

  @override
  String get bedtimeActionSectionTitle => '今晚动作';

  @override
  String get bedtimeActionStartWindDownTitle => '开始 10 分钟收尾';

  @override
  String get bedtimeActionStartWindDownBody => '现在最重要的是把刺激源停下来，给自己一个短而清晰的收尾窗口。';

  @override
  String get bedtimeActionPutPhoneAwayTitle => '先放下手机 10 分钟';

  @override
  String get bedtimeActionPutPhoneAwayBody =>
      '先把屏幕和待办往后推 10 分钟，给身体一个真正开始放松的信号。';

  @override
  String get bedtimeActionProtectWakeTitle => '先保住明早起床时间';

  @override
  String get bedtimeActionProtectWakeBody => '今晚先止损，不追求补完一切；把明早起床时间守住，比继续拖更重要。';

  @override
  String get bedtimeActionCompletedTitle => '今晚动作已完成';

  @override
  String get bedtimeActionCompletedBody => '明早回来时，Rhythm 会优先用昨晚结果继续解释你的节奏。';

  @override
  String bedtimeReminderEnabledBody(Object bedtime) {
    return '提醒已开启，今晚目标会继续围绕 $bedtime 提醒你收尾。';
  }

  @override
  String get bedtimePrimaryActionLabel => '执行这一步';

  @override
  String get bedtimePrimaryActionCompleted => '已完成今晚动作';

  @override
  String get calendarTitle => '日历';

  @override
  String get calendarBody => '热力图与单日详情将在共享数据契约落地后接入真实查询。';

  @override
  String get insightsTitle => '洞察';

  @override
  String get insightsBody => '周报、稳定度与付费洞察区块已预留，但尚未进入真实实现。';

  @override
  String get profileTitle => '我的';

  @override
  String get profileBody => '账户、会员、同步、提醒与隐私设置会在初始化完成后继续实现。';

  @override
  String get profileAccountAnonymousTitle => '当前使用本地优先模式';

  @override
  String get profileAccountAnonymousBody => '今晚的数据会先保留在这台设备里，你可以稍后再连接账号和同步。';

  @override
  String profileAccountConnectedTitle(Object provider) {
    return '已连接 $provider 账号';
  }

  @override
  String get profileAccountConnectedBody =>
      '你的账号快照已经保存在当前设备，后续可以继续接入同步、会员和隐私设置。';

  @override
  String get profileAccountLoadFallbackBody =>
      '账号状态暂时没有成功恢复，当前仍会按本地优先模式展示设置入口。';

  @override
  String get accountProviderAppleLabel => 'Apple';

  @override
  String get accountProviderGoogleLabel => 'Google';

  @override
  String get globalFeedbackDismiss => '稍后处理';

  @override
  String get globalFeedbackSyncFailedTitle => '同步已切回本地暂存';

  @override
  String get globalFeedbackSyncFailedBody => '你最近的更新仍安全保存在当前设备中，可以稍后再检查同步设置。';

  @override
  String get globalFeedbackTimezoneShiftTitle => '需要确认当前时区';

  @override
  String get globalFeedbackTimezoneShiftBody =>
      'Rhythm 会先暂停按普通规则解释睡眠结果，直到你确认当前时区上下文。';
}
