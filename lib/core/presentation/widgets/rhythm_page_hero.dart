import 'package:flutter/material.dart';

/// 统一主流程页面顶部 Hero 的眉标、标题和说明样式。
class RhythmPageHero extends StatelessWidget {
  /// 创建共享 Hero 组件。
  const RhythmPageHero({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    this.eyebrowBackground = const Color(0xFFE3EEE0),
    this.eyebrowForeground = const Color(0xFF4A6B52),
    this.titleColor = const Color(0xFF1B3A28),
    this.descriptionColor = const Color(0xFF4A6B52),
    this.trailing,
  });

  /// 眉标文案。
  final String eyebrow;

  /// 主标题文案。
  final String title;

  /// 说明文案。
  final String description;

  /// 眉标背景色。
  final Color eyebrowBackground;

  /// 眉标前景色。
  final Color eyebrowForeground;

  /// 标题颜色。
  final Color titleColor;

  /// 说明颜色。
  final Color descriptionColor;

  /// 可选的补充内容区域。
  final Widget? trailing;

  /// 构建共享 Hero。
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: eyebrowBackground,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            eyebrow,
            style: textTheme.labelLarge?.copyWith(
              fontFamily: 'Geist',
              fontWeight: FontWeight.w600,
              color: eyebrowForeground,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: textTheme.headlineMedium?.copyWith(
            fontFamily: 'Funnel Sans',
            fontWeight: FontWeight.w700,
            height: 1.08,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: textTheme.bodyLarge?.copyWith(
            fontFamily: 'Geist',
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: descriptionColor,
          ),
        ),
        if (trailing != null) ...[const SizedBox(height: 12), trailing!],
      ],
    );
  }
}
