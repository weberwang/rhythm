import 'package:flutter/material.dart';

/// 定义共享卡片支持的表面语义色调。
enum RhythmSurfaceCardTone { surface, soft, warning, inverse }

/// 统一主流程页面的卡片容器，收敛圆角、阴影、内边距和默认前景约束。
class RhythmSurfaceCard extends StatelessWidget {
  /// 创建共享卡片。
  const RhythmSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.tone = RhythmSurfaceCardTone.surface,
    this.radius = 20,
  });

  /// 卡片内容。
  final Widget child;

  /// 卡片内边距。
  final EdgeInsets padding;

  /// 卡片表面色调。
  final RhythmSurfaceCardTone tone;

  /// 允许后续页面按设计稿微调圆角，避免为小差异复制新卡片组件。
  final double radius;

  /// 构建共享卡片。
  @override
  Widget build(BuildContext context) {
    final foregroundColor = _resolveForegroundColor();

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _resolveBackgroundColor(),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: foregroundColor),
        child: IconTheme.merge(
          data: IconThemeData(color: foregroundColor),
          child: child,
        ),
      ),
    );
  }

  /// 返回当前卡片色调对应的背景色。
  Color _resolveBackgroundColor() {
    switch (tone) {
      case RhythmSurfaceCardTone.surface:
        return const Color(0xFFF9FBF6);
      case RhythmSurfaceCardTone.soft:
        return const Color(0xFFEEF4EA);
      case RhythmSurfaceCardTone.warning:
        return const Color(0xFFF4E8CF);
      case RhythmSurfaceCardTone.inverse:
        return const Color(0xFF1B3A28);
    }
  }

  /// 返回当前卡片色调对应的默认前景色，保证深色卡片上的普通内容可读。
  Color _resolveForegroundColor() {
    switch (tone) {
      case RhythmSurfaceCardTone.inverse:
        return const Color(0xFFD7E7DA);
      case RhythmSurfaceCardTone.surface:
      case RhythmSurfaceCardTone.soft:
      case RhythmSurfaceCardTone.warning:
        return const Color(0xFF1B3A28);
    }
  }
}
