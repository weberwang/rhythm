import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/account_session.dart';
import '../../domain/repositories/account_session_repository.dart';

const _accountSessionStorageKey = 'app_account_session';

/// 用安全存储承接最小账号快照，先提供本地会话语义，再衔接后续云端同步。
class LocalAccountSessionRepository implements AccountSessionRepository {
  /// 创建本地账号快照仓储。
  const LocalAccountSessionRepository(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> clear() async {
    await _storage.delete(key: _accountSessionStorageKey);
  }

  @override
  Future<AppAccountSession?> read() async {
    final rawValue = await _storage.read(key: _accountSessionStorageKey);
    if (rawValue == null || rawValue.isEmpty) {
      return null;
    }

    final json = jsonDecode(rawValue) as Map<String, dynamic>;
    return AppAccountSession.fromJson(json);
  }

  @override
  Future<void> save(AppAccountSession session) async {
    await _storage.write(
      key: _accountSessionStorageKey,
      value: jsonEncode(session.toJson()),
    );
  }
}
