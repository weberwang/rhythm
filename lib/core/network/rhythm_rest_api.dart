import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'network_client_provider.dart';

part 'rhythm_rest_api.g.dart';

/// 预留统一 REST 契约宿主，在后端字段未冻结前不提前发明业务接口。
@RestApi()
abstract class RhythmRestApi {
  /// 创建统一 REST 客户端。
  factory RhythmRestApi(Dio dio, {String baseUrl}) = _RhythmRestApi;
}

/// 暴露统一 REST 客户端提供者，让后续 feature 只复用同一网络宿主。
@riverpod
RhythmRestApi rhythmRestApi(Ref ref) {
  final client = ref.watch(networkClientProvider);
  return RhythmRestApi(client);
}
