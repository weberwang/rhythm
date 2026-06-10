import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_storage_providers.g.dart';

/// 提供共享偏好存储实例。
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferencesInstance(Ref ref) {
  return SharedPreferences.getInstance();
}

/// 提供敏感信息存储实例。
@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}
