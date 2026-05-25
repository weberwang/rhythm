/// 定义小组件进入 App 的来源类型，避免业务层散落 magic string。
enum WidgetEntrySource {
  /// 来自今日页快捷入口。
  todayShortcut,

  /// 来自睡前快捷入口。
  bedtimeShortcut,

  /// 无法识别的小组件来源。
  unknown,
}
