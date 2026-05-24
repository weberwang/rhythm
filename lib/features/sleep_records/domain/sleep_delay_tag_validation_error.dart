/// 定义晚睡原因标签的校验错误类型，避免展示层依赖裸字符串判断。
enum SleepDelayTagValidationError {
  /// 输入为空白，无法形成有效标签。
  empty,

  /// 输入超过约束长度，避免标签失控增长。
  tooLong,

  /// 输入与默认标签重复，避免产生重复选项。
  duplicateDefault,
}
