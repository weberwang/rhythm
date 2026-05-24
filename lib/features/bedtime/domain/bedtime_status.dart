/// 今晚睡前模式中的用户自评状态。
enum BedtimeStatus {
  /// 用户已经准备睡觉，优先给低干预动作。
  readyToSleep,

  /// 用户还想拖一会儿，优先给短延迟和收尾动作。
  wantsMoreTime,

  /// 用户判断今晚大概率晚睡，优先给补救和明早恢复动作。
  likelyLate,
}
