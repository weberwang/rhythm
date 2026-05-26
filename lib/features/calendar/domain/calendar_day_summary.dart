import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';

/// 表示日历页中某一天的汇总结果，供热力图和详情弹层复用。
class CalendarDaySummary {
  /// 创建单日摘要实例。
  const CalendarDaySummary({
    required this.date,
    required this.record,
    required this.sleepOffsetMinutes,
    required this.heatLevel,
    required this.tags,
    required this.primaryMood,
    required this.hasSecondaryMood,
  });

  /// 业务归属日。
  final DateTime date;

  /// 当天最终展示的有效记录；无记录时为空。
  final EffectiveSleepRecord? record;

  /// 相对目标入睡时间的偏差分钟数；正数表示更晚。
  final int? sleepOffsetMinutes;

  /// 热力等级。
  final CalendarHeatLevel heatLevel;

  /// 当天已保存的原因标签。
  final List<String> tags;

  /// 首页情绪纸片使用的主情绪，未识别标签时为空。
  final CalendarDayMood? primaryMood;

  /// 是否存在第二种已识别情绪，用于显示弱叠层纸边。
  final bool hasSecondaryMood;

  /// 是否存在有效记录。
  bool get hasRecord => record != null;

  /// 是否已超过晚睡阈值。
  bool get isLate =>
      sleepOffsetMinutes != null &&
      heatLevel.index >= CalendarHeatLevel.late.index;
}
