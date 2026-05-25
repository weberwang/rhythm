import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../goal_schedule/domain/goal_schedule.dart';
import '../application/manual_sleep_record_controller.dart';

/// 手动补录页，在没有健康数据时为用户提供最小可用记录能力。
class ManualSleepRecordPage extends ConsumerStatefulWidget {
  const ManualSleepRecordPage({super.key});

  @override
  ConsumerState<ManualSleepRecordPage> createState() =>
      _ManualSleepRecordPageState();
}

class _ManualSleepRecordPageState extends ConsumerState<ManualSleepRecordPage> {
  final _fellAsleepController = TextEditingController();
  final _wokeUpController = TextEditingController();

  @override
  void dispose() {
    _fellAsleepController.dispose();
    _wokeUpController.dispose();
    super.dispose();
  }

  /// 解析 `HH:mm` 形式的输入，当前先满足测试和手动录入的最小场景。
  DateTime _parseTime(String value, DateTime baseDate) {
    final parts = value.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(baseDate.year, baseDate.month, baseDate.day, hour, minute);
  }

  /// 保存手动记录，并立即回到上一页让今日页读取最新摘要。
  void _saveRecord() {
    final now = DateTime(2026, 5, 22);
    final schedule = const GoalSchedule(
      id: 'default-goal',
      targetBedtimeMinutes: 23 * 60,
      targetWakeMinutes: 7 * 60,
      lateThresholdMinutes: 30,
      dayStartMinutes: 4 * 60,
    );
    final fellAsleepAt = _parseTime(_fellAsleepController.text, now);
    final wakeBaseDate = _parseTime(_wokeUpController.text, now);
    final wokeUpAt = wakeBaseDate.isBefore(fellAsleepAt)
        ? wakeBaseDate.add(const Duration(days: 1))
        : wakeBaseDate;

    ref.read(sleepRecordStoreProvider).saveManualRecord(
      id: 'manual-record-1',
      schedule: schedule,
      fellAsleepAt: fellAsleepAt,
      wokeUpAt: wokeUpAt,
      timezone: 'Asia/Shanghai',
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('手动补录')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('补一条睡眠记录'),
            const SizedBox(height: 24),
            TextField(
              key: const Key('fellAsleepField'),
              controller: _fellAsleepController,
              decoration: const InputDecoration(labelText: '入睡时间'),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('wokeUpField'),
              controller: _wokeUpController,
              decoration: const InputDecoration(labelText: '起床时间'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saveRecord,
                child: const Text('保存记录'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
