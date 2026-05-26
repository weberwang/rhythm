import 'package:flutter/material.dart';

/// 阶段三补录摘要字段行。
class SleepRecordSummaryRow extends StatelessWidget {
  /// 创建摘要字段行实例。
  const SleepRecordSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
  });

  /// 字段标签。
  final String label;

  /// 字段值。
  final String value;

  /// 点击整行时触发的回调，供说明类字段打开附加弹层。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: textTheme.titleSmall),
            Text(
              value,
              style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
