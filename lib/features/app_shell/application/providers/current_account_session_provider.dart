import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/account_session.dart';
import 'account_session_repository_provider.dart';

part 'current_account_session_provider.g.dart';

/// 读取当前共享账号快照，供设置页和后续同步状态聚合消费。
@riverpod
Future<AppAccountSession?> currentAccountSession(Ref ref) async {
  final repository = ref.watch(accountSessionRepositoryProvider);
  return repository.read();
}
