import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/entry_intent.dart';

part 'current_entry_intent_provider.g.dart';

/// 暴露当前统一入口意图，并允许在首启完成后重置一次性外部入口。
@Riverpod(keepAlive: true)
class CurrentEntryIntent extends _$CurrentEntryIntent {
  /// 默认按普通应用启动处理；通知与小组件入口后续可在这里统一写入。
  @override
  EntryIntent build() {
    return const EntryIntent.appOpen();
  }

  /// 写入当前会话的外部入口意图，避免路由层散落状态修改。
  void setIntent(EntryIntent intent) {
    state = intent;
  }

  /// onboarding 完成后重置为普通启动，避免首启前的一次性外部目标劫持首个落地页。
  void resetToAppOpen() {
    state = const EntryIntent.appOpen();
  }
}
