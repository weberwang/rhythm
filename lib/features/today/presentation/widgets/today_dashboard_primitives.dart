import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'today_dashboard_style.dart';

/// 承接全页卡片的统一材质，避免多个区块各自定义阴影和描边。
class TodaySurfaceCard extends StatelessWidget {
  /// 创建统一材质卡片。
  const TodaySurfaceCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.fromLTRB(22, 22, 22, 20),
    this.color,
  });

  /// 卡片内容。
  final Widget child;

  /// 卡片内边距。
  final EdgeInsets padding;

  /// 可选卡片底色。
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: TodayDashboardStyle.cardRadius,
        border: Border.all(color: TodayDashboardStyle.cardStroke),
        boxShadow: TodayDashboardStyle.cardShadow,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

/// 页面内所有小节标题复用同一标签样式，保证首屏扫描路径稳定。
class TodaySectionLabel extends StatelessWidget {
  /// 创建小节标题。
  const TodaySectionLabel(this.label, {super.key});

  /// 标签文案。
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TodayDashboardStyle.sectionLabel(context),
    );
  }
}

/// 头部右上角的个人入口，保留效果图里的细描边圆按钮气质。
class TodayProfileButton extends StatelessWidget {
  /// 创建个人入口按钮。
  const TodayProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        border: Border.all(color: TodayDashboardStyle.cardStroke),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A102E37),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Icon(Icons.person_outline_rounded, color: TodayDashboardStyle.ink),
    );
  }
}

/// 品牌字标沿用矢量绘制，避免为了一个简单 Logo 再引入位图依赖。
class TodayWordmark extends StatelessWidget {
  /// 创建品牌字标。
  const TodayWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 44,
          height: 44,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5AB9BC), Color(0xFF1F6E73)],
              ),
            ),
            child: CustomPaint(painter: _WaveMarkPainter()),
          ),
        ),
        const SizedBox(width: 12),
        Text('Rhythm', style: TodayDashboardStyle.brandWordmark(context)),
      ],
    );
  }
}

/// 顶部太阳提示沿用系统图标，但通过自定义容器补足效果图的轻装饰感。
class TodaySunBadge extends StatelessWidget {
  /// 创建太阳提示。
  const TodaySunBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Color(0x14FFAF8E), Color(0x00FFAF8E)],
        ),
      ),
      child: const Icon(
        Icons.wb_sunny_rounded,
        size: 38,
        color: Color(0xFFFF8B6C),
      ),
    );
  }
}

/// 昨晚结果的主分数环通过手绘弧线来贴近效果图的开口圆环。
class TodayScoreRing extends StatelessWidget {
  /// 创建主分数环。
  const TodayScoreRing({required this.label, super.key, this.score = 82});

  /// 环内短标签。
  final String label;

  /// 环内分值。
  final int score;

  @override
  Widget build(BuildContext context) {
    final hasScore = label != '等待首晚';
    final theme = Theme.of(context);

    return SizedBox(
      width: 128,
      height: 128,
      child: CustomPaint(
        painter: _ScoreRingPainter(
          color: theme.colorScheme.primary,
          trackColor: theme.colorScheme.primary.withValues(alpha: 0.14),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hasScore ? '$score' : '--',
                style: TodayDashboardStyle.scoreValue(context),
              ),
              const SizedBox(height: 6),
              Text(
                hasScore ? 'Good' : label,
                textAlign: TextAlign.center,
                style: TodayDashboardStyle.scoreLabel(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 统一封装位图插画展示，确保生成资产在页面里以同一密度呈现。
class TodayIllustrationAsset extends StatelessWidget {
  /// 创建插画资产容器。
  const TodayIllustrationAsset({
    required this.assetName,
    required this.size,
    super.key,
  });

  /// 资源路径。
  final String assetName;

  /// 目标尺寸。
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Image.asset(assetName, filterQuality: FilterQuality.high),
    );
  }
}

/// 结果卡底部的单列指标保持统一结构，避免三列信息节奏不齐。
class TodayMetricColumn extends StatelessWidget {
  /// 创建单列指标。
  const TodayMetricColumn({
    required this.icon,
    required this.value,
    required this.label,
    super.key,
  });

  /// 指标图标。
  final IconData icon;

  /// 指标值。
  final String value;

  /// 指标标签。
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 19, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                value,
                style: TodayDashboardStyle.metricValue(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 29),
          child: Text(label, style: TodayDashboardStyle.metricLabel(context)),
        ),
      ],
    );
  }
}

/// 指标之间只保留轻分隔，避免卡片底部视觉过重。
class TodayMetricDivider extends StatelessWidget {
  /// 创建指标分隔线。
  const TodayMetricDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: TodayDashboardStyle.cardStroke,
    );
  }
}

/// 通用右箭头，显式表达恢复建议和快捷记录仍可继续深入。
class TodayActionChevron extends StatelessWidget {
  /// 创建通用箭头。
  const TodayActionChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right_rounded,
      size: 34,
      color: TodayDashboardStyle.ink.withValues(alpha: 0.62),
    );
  }
}

/// 统一卡片内的细竖分隔，承接今晚目标卡的左右内容切分。
class TodayVerticalDivider extends StatelessWidget {
  /// 创建竖分隔线。
  const TodayVerticalDivider({required this.height, super.key});

  /// 分隔线高度。
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: height,
      color: TodayDashboardStyle.cardStroke,
    );
  }
}

/// 波浪形品牌标识使用简单路径即可稳定复刻，不必退化成位图。
class _WaveMarkPainter extends CustomPainter {
  const _WaveMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.94);
    final topWave = Path()
      ..moveTo(6, size.height * 0.45)
      ..cubicTo(
        size.width * 0.28,
        size.height * 0.18,
        size.width * 0.62,
        size.height * 0.26,
        size.width - 6,
        size.height * 0.12,
      )
      ..lineTo(size.width - 6, size.height * 0.36)
      ..cubicTo(
        size.width * 0.7,
        size.height * 0.47,
        size.width * 0.36,
        size.height * 0.38,
        6,
        size.height * 0.62,
      )
      ..close();
    final bottomWave = Path()
      ..moveTo(6, size.height * 0.64)
      ..cubicTo(
        size.width * 0.32,
        size.height * 0.44,
        size.width * 0.66,
        size.height * 0.56,
        size.width - 6,
        size.height * 0.42,
      )
      ..lineTo(size.width - 6, size.height * 0.82)
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.9,
        size.width * 0.34,
        size.height * 0.82,
        6,
        size.height * 0.9,
      )
      ..close();

    canvas.drawPath(topWave, paint);
    canvas.drawPath(bottomWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 自定义分数环只画一次静态结果，避免引入不必要的进度动画干扰首页判断。
class _ScoreRingPainter extends CustomPainter {
  const _ScoreRingPainter({required this.color, required this.trackColor});

  /// 主弧线颜色。
  final Color color;

  /// 背景弧线颜色。
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 7.5;
    final rect = Rect.fromLTWH(
      strokeWidth,
      strokeWidth,
      size.width - strokeWidth * 2,
      size.height - strokeWidth * 2,
    );
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withValues(alpha: 0.72), color],
      ).createShader(rect);

    const startAngle = math.pi * 0.9;
    const sweepAngle = math.pi * 1.78;

    canvas.drawArc(rect, startAngle, sweepAngle, false, trackPaint);
    canvas.drawArc(rect, startAngle, sweepAngle * 0.82, false, activePaint);
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.trackColor != trackColor;
  }
}
