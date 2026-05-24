import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'time_context.dart';

part 'time_context_provider.g.dart';

/// 提供当前设备时间上下文，后续可无缝替换为 `flutter_timezone` 的真实时区读取。
@riverpod
TimeContext timeContext(Ref ref) {
  final now = DateTime.now();
  return TimeContext(
    now: now,
    timezoneName: now.timeZoneName,
  );
}
