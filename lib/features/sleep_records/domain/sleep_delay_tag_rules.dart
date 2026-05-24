import 'sleep_delay_tag.dart';
import 'sleep_delay_tag_validation_error.dart';

/// 表示晚睡原因标签校验失败，供显示层映射为本地化提示。
class SleepDelayTagValidationException implements Exception {
  /// 创建标签校验异常。
  const SleepDelayTagValidationException(this.error);

  /// 当前校验失败类型。
  final SleepDelayTagValidationError error;
}

/// 统一承接阶段六原因标签默认值和自定义校验规则。
class SleepDelayTagRules {
  const SleepDelayTagRules._();

  /// 默认标签集合，保持轻量且可快速点选。
  static const List<SleepDelayTag> defaultTags = <SleepDelayTag>[
    SleepDelayTag(id: 'phone', name: '刷手机', isDefault: true),
    SleepDelayTag(id: 'overtime', name: '加班', isDefault: true),
    SleepDelayTag(id: 'game', name: '游戏', isDefault: true),
    SleepDelayTag(id: 'show', name: '追剧', isDefault: true),
    SleepDelayTag(id: 'emotion', name: '情绪', isDefault: true),
    SleepDelayTag(id: 'party', name: '聚会', isDefault: true),
    SleepDelayTag(id: 'jetlag', name: '时差', isDefault: true),
    SleepDelayTag(id: 'other', name: '其他', isDefault: true),
  ];

  /// 规范化并校验自定义标签，避免自由文本长期失控。
  static String validateCustomTag(String input) {
    final normalized = input.trim();
    if (normalized.isEmpty) {
      throw const SleepDelayTagValidationException(
        SleepDelayTagValidationError.empty,
      );
    }
    if (normalized.length > 12) {
      throw const SleepDelayTagValidationException(
        SleepDelayTagValidationError.tooLong,
      );
    }
    final duplicate = defaultTags.any((tag) => tag.name == normalized);
    if (duplicate) {
      throw const SleepDelayTagValidationException(
        SleepDelayTagValidationError.duplicateDefault,
      );
    }
    return normalized;
  }
}
