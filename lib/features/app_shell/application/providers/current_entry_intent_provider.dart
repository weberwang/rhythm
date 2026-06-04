import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/entry_intent.dart';

part 'current_entry_intent_provider.g.dart';

/// 暴露当前统一入口意图，为后续通知与小组件路由分发保留扩展点。
@Riverpod(keepAlive: true)
EntryIntent currentEntryIntent(Ref ref) {
  return const EntryIntent.appOpen();
}
