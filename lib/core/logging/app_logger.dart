import 'package:logger/logger.dart';

/// 统一包装日志入口，避免各模块直接分散创建第三方 logger 实例。
class AppLogger {
  /// 创建日志适配器。
  AppLogger() : _logger = Logger();

  final Logger _logger;

  /// 记录信息日志。
  void info(String message) {
    _logger.i(message);
  }

  /// 记录错误日志。
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
