import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';

/// 聚合首页纸片所需的最小情绪结果。
class CalendarMoodSelection {
  /// 创建情绪解析结果。
  const CalendarMoodSelection({
    required this.primaryMood,
    required this.hasSecondaryMood,
  });

  /// 首页用于渲染纸片的主情绪；未识别标签不生成主情绪。
  final CalendarDayMood? primaryMood;

  /// 是否存在第二种已识别情绪，用于显示弱叠层纸边。
  final bool hasSecondaryMood;
}

/// 将晚睡原因标签归并成日历首页可表达的主情绪。
class CalendarMoodRules {
  /// 规则类只暴露静态解析方法，不允许实例化保存状态。
  const CalendarMoodRules._();

  static const Map<CalendarDayMood, int> _priority = <CalendarDayMood, int>{
    CalendarDayMood.restless: 4,
    CalendarDayMood.drained: 3,
    CalendarDayMood.excited: 2,
    CalendarDayMood.calm: 1,
  };

  /// 按稳定优先级解析标签，避免首页纸片随录入顺序改变。
  static CalendarMoodSelection resolve(List<String> tags) {
    final moods = tags
        .map(_mapTagToMood)
        .whereType<CalendarDayMood>()
        .toSet()
        .toList(growable: false);
    if (moods.isEmpty) {
      return const CalendarMoodSelection(
        primaryMood: null,
        hasSecondaryMood: false,
      );
    }

    moods.sort((left, right) => _priority[right]!.compareTo(_priority[left]!));
    return CalendarMoodSelection(
      primaryMood: moods.first,
      hasSecondaryMood: moods.length > 1,
    );
  }

  /// 将单个标签映射到主情绪；未命中时保持空值，避免误判自定义文本。
  static CalendarDayMood? _mapTagToMood(String rawTag) {
    final tag = rawTag.trim();
    if (tag.isEmpty) {
      return null;
    }
    if (const <String>{'加班', '情绪', '时差', '焦虑', '压力'}.contains(tag)) {
      return CalendarDayMood.restless;
    }
    if (const <String>{'刷手机', '追剧', '发呆', '没精神'}.contains(tag)) {
      return CalendarDayMood.drained;
    }
    if (const <String>{'游戏', '聚会', '聊天', '开心'}.contains(tag)) {
      return CalendarDayMood.excited;
    }
    if (const <String>{'阅读', '放松', '收心', '按计划'}.contains(tag)) {
      return CalendarDayMood.calm;
    }
    return null;
  }
}
