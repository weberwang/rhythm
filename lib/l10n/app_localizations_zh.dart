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
  String get bedtimeTitle => '睡前';

  @override
  String get bedtimeBody => '睡前专注流程已完成脚手架初始化，等待模块实现阶段接线。';

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
}
