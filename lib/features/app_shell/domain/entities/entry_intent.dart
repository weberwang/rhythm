import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_intent.freezed.dart';
part 'entry_intent.g.dart';

/// 把通知、小组件与普通启动统一归一成单一入口意图。
@freezed
sealed class EntryIntent with _$EntryIntent {
  /// 普通应用启动。
  const factory EntryIntent.appOpen() = AppOpenEntryIntent;

  /// 从通知进入应用。
  const factory EntryIntent.notification({required String target}) =
      NotificationEntryIntent;

  /// 从小组件进入应用。
  const factory EntryIntent.homeWidget({required String target}) =
      HomeWidgetEntryIntent;

  /// 从 JSON 恢复入口意图，便于后续深链或缓存扩展。
  factory EntryIntent.fromJson(Map<String, dynamic> json) =>
      _$EntryIntentFromJson(json);
}
