import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/features/goal_schedule/presentation/goal_schedule_settings_page.dart';
import 'package:rhythm/features/goal_schedule/presentation/goal_setup_page.dart';
import 'package:rhythm/features/goal_schedule/presentation/timezone_mode_page.dart';
import 'package:rhythm/features/insights/presentation/insights_page.dart';
import 'package:rhythm/features/insights/presentation/report_history_page.dart';
import 'package:rhythm/features/insights/presentation/weekly_report_detail_page.dart';
import 'package:rhythm/features/membership/presentation/membership_page.dart';
import 'package:rhythm/features/membership/presentation/paywall_page.dart';
import 'package:rhythm/features/notifications/presentation/notification_settings_page.dart';
import 'package:rhythm/features/notifications/presentation/reminder_setup_page.dart';
import 'package:rhythm/features/onboarding/presentation/onboarding_flow_page.dart';
import 'package:rhythm/features/bedtime/presentation/bedtime_page.dart';
import 'package:rhythm/features/calendar/presentation/calendar_page.dart';
import 'package:rhythm/features/profile/presentation/data_access_page.dart';
import 'package:rhythm/features/profile/presentation/privacy_data_page.dart';
import 'package:rhythm/features/profile/presentation/profile_page.dart';
import 'package:rhythm/features/sleep_records/presentation/manual_sleep_record_page.dart';
import 'package:rhythm/features/sleep_records/presentation/sleep_records_hub_page.dart';
import 'package:rhythm/features/sync/presentation/account_sync_page.dart';
import 'package:rhythm/features/today/presentation/today_page.dart';
import 'package:rhythm/features/widget_bridge/presentation/widget_guide_page.dart';
import 'package:rhythm/features/widget_bridge/presentation/widget_theme_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../bootstrap/launch_gate.dart';

/// 首次引导欢迎页路由路径。
const String onboardingWelcomePath = '/onboarding/welcome';

/// 目标设置页路由路径。
const String onboardingGoalSetupPath = '/onboarding/goal-setup';

/// 提醒策略设置页路由路径。
const String onboardingReminderSetupPath = '/onboarding/reminder-setup';

/// 小组件引导页路由路径。
const String onboardingWidgetGuidePath = '/onboarding/widget-guide';

/// 阶段三睡眠记录管理页路由路径。
const String sleepRecordsHubPath = '/sleep-records/manage';

/// 阶段三手动补录页路由路径。
const String manualSleepRecordPath = '/sleep-records/manual';

/// 睡前模式页路由路径，供底部导航、通知和小组件统一进入。
const String bedtimeModePath = '/bedtime';

/// 本周周报详情页路由路径。
const String weeklyReportDetailPath = '/insights/weekly-report';

/// 历史洞察页路由路径。
const String insightsHistoryPath = '/insights/history';

/// 轻量付费墙页路由路径。
const String membershipPaywallPath = '/membership/paywall';

/// 会员中心页路由路径。
const String membershipCenterPath = '/membership/center';

/// 账号与同步页路由路径。
const String profileAccountSyncPath = '/profile/account-sync';

/// 数据接入与权限页路由路径。
const String profileDataAccessPath = '/profile/data-access';

/// 隐私与数据页路由路径。
const String profilePrivacyDataPath = '/profile/privacy';

/// 目标作息编辑页路由路径。
const String profileGoalSchedulePath = '/profile/goal-schedule';

/// 提醒设置页路由路径。
const String profileNotificationSettingsPath = '/profile/notifications';

/// 时区与特殊模式页路由路径。
const String profileTimezoneModePath = '/profile/timezone-mode';

/// 小组件与主题页路由路径。
const String profileWidgetThemePath = '/profile/widget-theme';

/// 生成阶段三编辑睡眠记录页路由路径。
String manualSleepRecordEditPath(String recordId) {
  return '$manualSleepRecordPath?recordId=$recordId';
}

/// 一级模块与占位页可复用的文案键。
enum AppCopyKey {
  goalSetupTitle,
  goalSetupDescription,
  calendarTitle,
  calendarDescription,
  bedtimeTitle,
  bedtimeDescription,
  insightsTitle,
  insightsDescription,
  profileTitle,
  profileDescription,
}

/// 根据文案键读取当前语言对应的展示文案。
String appCopy(AppLocalizations l10n, AppCopyKey key) {
  switch (key) {
    case AppCopyKey.goalSetupTitle:
      return l10n.goalSetupTitle;
    case AppCopyKey.goalSetupDescription:
      return l10n.goalSetupDescription;
    case AppCopyKey.calendarTitle:
      return l10n.calendarTitle;
    case AppCopyKey.calendarDescription:
      return l10n.calendarDescription;
    case AppCopyKey.bedtimeTitle:
      return l10n.bedtimeTitle;
    case AppCopyKey.bedtimeDescription:
      return l10n.bedtimeDescription;
    case AppCopyKey.insightsTitle:
      return l10n.insightsTitle;
    case AppCopyKey.insightsDescription:
      return l10n.insightsDescription;
    case AppCopyKey.profileTitle:
      return l10n.profileTitle;
    case AppCopyKey.profileDescription:
      return l10n.profileDescription;
  }
}

/// Rhythm 的一级模块定义。
enum RhythmTab {
  today(Icons.nights_stay_outlined, '/'),
  calendar(Icons.calendar_month_outlined, '/calendar'),
  bedtime(Icons.bedtime_outlined, bedtimeModePath),
  insights(Icons.insights_outlined, '/insights'),
  profile(Icons.person_outline, '/profile');

  const RhythmTab(this.icon, this.path);

  final IconData icon;
  final String path;

  String label(AppLocalizations l10n) {
    switch (this) {
      case RhythmTab.today:
        return l10n.tabToday;
      case RhythmTab.calendar:
        return l10n.tabCalendar;
      case RhythmTab.bedtime:
        return l10n.tabBedtime;
      case RhythmTab.insights:
        return l10n.tabInsights;
      case RhythmTab.profile:
        return l10n.tabProfile;
    }
  }
}

/// 创建 App 路由。
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/launch',
    routes: [
      GoRoute(
        path: '/launch',
        pageBuilder: (context, state) =>
            buildStaticRootPage(key: state.pageKey, child: const LaunchGate()),
      ),
      GoRoute(
        path: onboardingWelcomePath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const OnboardingFlowPage(),
        ),
      ),
      GoRoute(
        path: onboardingGoalSetupPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const GoalSetupPage(),
        ),
      ),
      GoRoute(
        path: onboardingReminderSetupPath,
        pageBuilder: (context, state) {
          final container = ProviderScope.containerOf(context, listen: false);
          return buildSecondaryPage(
            key: state.pageKey,
            child: ReminderSetupPage(
              launchStateRepository: container.read(
                launchStateRepositoryProvider,
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: onboardingWidgetGuidePath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const WidgetGuidePage(),
        ),
      ),
      GoRoute(
        path: sleepRecordsHubPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const SleepRecordsHubPage(),
        ),
      ),
      GoRoute(
        path: manualSleepRecordPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: ManualSleepRecordPage(
            editingRecordId: state.uri.queryParameters['recordId'],
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.today.path,
        pageBuilder: (context, state) => buildTabRootPage(
          key: state.pageKey,
          child: const RhythmShell(
            currentTab: RhythmTab.today,
            child: TodayPage(),
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.calendar.path,
        pageBuilder: (context, state) => buildTabRootPage(
          key: state.pageKey,
          child: const RhythmShell(
            currentTab: RhythmTab.calendar,
            child: CalendarPage(),
          ),
        ),
      ),
      GoRoute(
        path: bedtimeModePath,
        pageBuilder: (context, state) => buildTabRootPage(
          key: state.pageKey,
          child: const RhythmShell(
            currentTab: RhythmTab.bedtime,
            child: BedtimePage(),
          ),
        ),
      ),
      GoRoute(
        path: weeklyReportDetailPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const WeeklyReportDetailPage(),
        ),
      ),
      GoRoute(
        path: insightsHistoryPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const ReportHistoryPage(),
        ),
      ),
      GoRoute(
        path: membershipPaywallPath,
        pageBuilder: (context, state) =>
            buildSecondaryPage(key: state.pageKey, child: const PaywallPage()),
      ),
      GoRoute(
        path: membershipCenterPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const MembershipPage(),
        ),
      ),
      GoRoute(
        path: profileAccountSyncPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const AccountSyncPage(),
        ),
      ),
      GoRoute(
        path: profileDataAccessPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const DataAccessPage(),
        ),
      ),
      GoRoute(
        path: profilePrivacyDataPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const PrivacyDataPage(),
        ),
      ),
      GoRoute(
        path: profileGoalSchedulePath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const GoalScheduleSettingsPage(),
        ),
      ),
      GoRoute(
        path: profileNotificationSettingsPath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const NotificationSettingsPage(),
        ),
      ),
      GoRoute(
        path: profileTimezoneModePath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const TimezoneModePage(),
        ),
      ),
      GoRoute(
        path: profileWidgetThemePath,
        pageBuilder: (context, state) => buildSecondaryPage(
          key: state.pageKey,
          child: const WidgetThemePage(),
        ),
      ),
      GoRoute(
        path: RhythmTab.insights.path,
        pageBuilder: (context, state) => buildTabRootPage(
          key: state.pageKey,
          child: const RhythmShell(
            currentTab: RhythmTab.insights,
            child: InsightsPage(),
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.profile.path,
        pageBuilder: (context, state) => buildTabRootPage(
          key: state.pageKey,
          child: const RhythmShell(
            currentTab: RhythmTab.profile,
            child: ProfilePage(),
          ),
        ),
      ),
    ],
  );
}

/// 一级 tab 根页面使用无过渡切换，避免底部导航被误读为入栈跳转。
Page<void> buildTabRootPage({required LocalKey key, required Widget child}) {
  return NoTransitionPage<void>(key: key, child: child);
}

/// 应用启动入口不需要过渡动画，避免首帧和分发页出现额外闪动。
Page<void> buildStaticRootPage({required LocalKey key, required Widget child}) {
  return NoTransitionPage<void>(key: key, child: child);
}

/// 二级页统一使用 iOS 风格页面对象，保证详情和设置页仍保留推入返回语义。
Page<void> buildSecondaryPage({required LocalKey key, required Widget child}) {
  return CupertinoPage<void>(key: key, child: child);
}

/// 带底部导航的通用壳。
class RhythmShell extends StatelessWidget {
  /// 创建模块壳。
  const RhythmShell({super.key, required this.currentTab, required this.child});

  final RhythmTab currentTab;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context);

        return Scaffold(
          body: SafeArea(child: child),
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentTab.index,
            onDestinationSelected: (index) {
              context.go(RhythmTab.values[index].path);
            },
            destinations: [
              for (final tab in RhythmTab.values)
                NavigationDestination(
                  icon: Icon(tab.icon),
                  label: tab.label(l10n),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// 占位页。
class ModulePlaceholderPage extends StatelessWidget {
  /// 创建占位页。
  const ModulePlaceholderPage({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
  });

  final AppCopyKey titleKey;
  final AppCopyKey descriptionKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appCopy(l10n, titleKey), style: textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(appCopy(l10n, descriptionKey)),
            ),
          ),
        ],
      ),
    );
  }
}
