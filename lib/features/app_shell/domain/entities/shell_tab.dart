import 'entry_intent.dart';

/// 统一定义五标签主壳的导航顺序与路由归属。
enum ShellTab {
  /// 今日首页。
  today('/today'),

  /// 历史日历。
  calendar('/calendar'),

  /// 睡前模式。
  bedtime('/bedtime'),

  /// 洞察与报告。
  insights('/insights'),

  /// 我的与设置。
  profile('/profile');

  /// 创建标签定义。
  const ShellTab(this.location);

  /// 该标签对应的主路由。
  final String location;

  /// 把入口意图转换为最终落点，统一通知、小组件与普通启动的主壳分发规则。
  static ShellTab fromEntryIntent(EntryIntent intent) {
    return switch (intent) {
      AppOpenEntryIntent() => ShellTab.today,
      NotificationEntryIntent(target: final target) => fromTarget(target),
      HomeWidgetEntryIntent(target: final target) => fromTarget(target),
    };
  }

  /// 把外部目标字符串收敛到受控标签集合，避免路由层散落字符串判断。
  static ShellTab fromTarget(String target) {
    return switch (target) {
      'calendar' => ShellTab.calendar,
      'bedtime' => ShellTab.bedtime,
      'insights' => ShellTab.insights,
      'profile' => ShellTab.profile,
      _ => ShellTab.today,
    };
  }
}
