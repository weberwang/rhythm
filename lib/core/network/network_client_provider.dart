import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_environment.dart';

part 'network_client_provider.g.dart';

/// 统一创建 Dio 客户端，为后续真实远端契约保留单一入口。
@riverpod
Dio networkClient(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppEnvironment.placeholderBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
}
