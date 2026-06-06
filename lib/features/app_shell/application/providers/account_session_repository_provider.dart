import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/secure_storage_provider.dart';
import '../../domain/repositories/account_session_repository.dart';
import '../../infrastructure/repositories/local_account_session_repository.dart';

part 'account_session_repository_provider.g.dart';

/// 暴露共享账号快照仓储，让引导、设置和启动层只依赖稳定边界。
@Riverpod(keepAlive: true)
AccountSessionRepository accountSessionRepository(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return LocalAccountSessionRepository(storage);
}
