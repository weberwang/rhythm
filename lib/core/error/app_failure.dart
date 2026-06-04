import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

/// 统一表达跨模块可恢复失败，避免页面直接依赖插件或异常细节。
@freezed
sealed class AppFailure with _$AppFailure {
  /// 基础未知失败。
  const factory AppFailure.unknown({required String message}) = UnknownAppFailure;

  /// 持久化层失败。
  const factory AppFailure.storage({required String message}) = StorageAppFailure;

  /// 网络或远端同步失败。
  const factory AppFailure.network({required String message}) = NetworkAppFailure;
}
