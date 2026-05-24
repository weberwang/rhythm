/// 定义今日页首屏主行动类型，避免展示层用字符串分支拼装按钮逻辑。
enum TodayPrimaryAction {
  /// 进入睡前模式。
  enterBedtimeMode,

  /// 进入手动补录。
  manualRecord,

  /// 打开权限说明或重新授权入口。
  openPermissionHelp,

  /// 返回目标设置。
  openGoalSetup,

  /// 查看恢复建议。
  viewRecoveryPlan,
}
