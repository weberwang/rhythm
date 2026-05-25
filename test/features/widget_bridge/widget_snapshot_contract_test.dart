import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';

/// 验证小组件快照契约只暴露阶段九允许输出的字段。
void main() {
  test('无目标时输出目标缺失快照且不暴露昨晚详情', () {
    final snapshot = WidgetSnapshot.goalMissing(
      entryUri: Uri.parse('rhythm://today?source=widget_today'),
    );

    expect(snapshot.state, WidgetSnapshotState.goalMissing);
    expect(snapshot.targetBedtimeLabel, isNull);
    expect(snapshot.minutesToTarget, isNull);
    expect(snapshot.lastNightStatusLabel, isNull);
    expect(
      snapshot.entryUri,
      Uri.parse('rhythm://today?source=widget_today'),
    );
  });

  test('无数据时允许保留今晚目标，但不伪造昨晚状态', () {
    final snapshot = WidgetSnapshot.noData(
      targetBedtimeLabel: '23:30',
      entryUri: Uri.parse('rhythm://today?source=widget_today'),
    );

    expect(snapshot.state, WidgetSnapshotState.noData);
    expect(snapshot.targetBedtimeLabel, '23:30');
    expect(snapshot.minutesToTarget, isNull);
    expect(snapshot.lastNightStatusLabel, isNull);
  });

  test('未授权时只输出必要状态，不携带敏感睡眠细节', () {
    final snapshot = WidgetSnapshot.permissionRequired(
      targetBedtimeLabel: '23:30',
      minutesToTarget: 52,
      entryUri: Uri.parse('rhythm://today?source=widget_today'),
    );

    expect(snapshot.state, WidgetSnapshotState.permissionRequired);
    expect(snapshot.targetBedtimeLabel, '23:30');
    expect(snapshot.minutesToTarget, 52);
    expect(snapshot.lastNightStatusLabel, isNull);
  });

  test('有完整数据时只输出今晚目标、距离目标、昨晚状态与入口参数', () {
    final snapshot = WidgetSnapshot.ready(
      targetBedtimeLabel: '23:30',
      minutesToTarget: 52,
      lastNightStatusLabel: '昨晚晚 26 分钟',
      entryUri: Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut'),
    );

    expect(snapshot.state, WidgetSnapshotState.ready);
    expect(snapshot.targetBedtimeLabel, '23:30');
    expect(snapshot.minutesToTarget, 52);
    expect(snapshot.lastNightStatusLabel, '昨晚晚 26 分钟');
    expect(
      snapshot.entryUri,
      Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut'),
    );
  });
}
