import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_logger.g.dart';

/// 应用级日志门面，统一后续日志入口。
class AppLogger {
  /// 创建日志门面。
  AppLogger() : _logger = Logger();

  final Logger _logger;

  /// 记录信息日志。
  void info(String message) {
    _logger.i(message);
  }

  /// 记录错误日志。
  void error(String message, Object error, [StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

/// 提供全局日志实例。
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) {
  return AppLogger();
}
