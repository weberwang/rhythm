import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_mood_rules.dart';

void main() {
  test('刷手机和聚会同时存在时优先落到空耗主情绪，并标记第二情绪', () {
    final result = CalendarMoodRules.resolve(const <String>['刷手机', '聚会']);

    expect(result.primaryMood, CalendarDayMood.drained);
    expect(result.hasSecondaryMood, isTrue);
  });

  test('加班和游戏同时存在时优先落到烦躁主情绪', () {
    final result = CalendarMoodRules.resolve(const <String>['加班', '游戏']);

    expect(result.primaryMood, CalendarDayMood.restless);
    expect(result.hasSecondaryMood, isTrue);
  });

  test('未命中的自定义标签不会生成首页情绪纸片', () {
    final result = CalendarMoodRules.resolve(const <String>['临时备注']);

    expect(result.primaryMood, isNull);
    expect(result.hasSecondaryMood, isFalse);
  });
}
