/// 统一解析睡眠记录业务归属日，避免页面和仓储重复实现跨午夜规则。
class SleepRecordDayResolver {
  /// 根据入睡时间和一天起始分钟数计算业务归属日。
  static DateTime resolveRecordDate({
    required DateTime fellAsleepAt,
    required int dayStartMinutes,
  }) {
    final startOfDay = fellAsleepAt.isUtc
        ? DateTime.utc(
            fellAsleepAt.year,
            fellAsleepAt.month,
            fellAsleepAt.day,
          )
        : DateTime(
            fellAsleepAt.year,
            fellAsleepAt.month,
            fellAsleepAt.day,
          );
    final minutesOfDay = fellAsleepAt.hour * 60 + fellAsleepAt.minute;
    if (minutesOfDay < dayStartMinutes) {
      return startOfDay.subtract(const Duration(days: 1));
    }
    return startOfDay;
  }
}
