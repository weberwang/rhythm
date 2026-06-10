/// 将底层异常映射为可展示文案的共享错误转换器。
class AppErrorMapper {
  /// 创建错误映射器。
  const AppErrorMapper();

  /// 输出可展示的错误文案。
  String toDisplayMessage(Object error) {
    return 'Unable to finish startup. Please try again.';
  }
}
