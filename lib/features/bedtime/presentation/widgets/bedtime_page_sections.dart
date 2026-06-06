import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/entities/bedtime_session_draft.dart';
import 'bedtime_page_style.dart';

/// 在页面底层绘制冻结稿要求的柔和背景层，但不把装饰复杂度推高到位图级别。
class BedtimeDecorativeBackground extends StatelessWidget {
  /// 创建睡前页背景装饰层。
  const BedtimeDecorativeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: const [
            Positioned(
              left: -120,
              top: 280,
              child: _GlowBlob(
                width: 260,
                height: 220,
                color: BedtimePageStyle.mist,
              ),
            ),
            Positioned(
              right: -40,
              top: 350,
              child: _GlowBlob(
                width: 190,
                height: 170,
                color: BedtimePageStyle.blush,
              ),
            ),
            Positioned(left: -60, right: -60, bottom: 170, child: _WaveBand()),
          ],
        ),
      ),
    );
  }
}

/// 大倒计时环承接首屏主焦点，并把复杂视觉限制在一个稳定组件中。
class BedtimeHeroCard extends StatelessWidget {
  /// 创建倒计时主视觉。
  const BedtimeHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.countdownLabel,
    required this.countdownValue,
    required this.caption,
    required this.progress,
    required this.completed,
    this.compact = false,
  });

  /// 页面标题。
  final String title;

  /// 页面副标题。
  final String subtitle;

  /// 倒计时短标签。
  final String countdownLabel;

  /// 倒计时主数值。
  final String countdownValue;

  /// 环内底部短句。
  final String caption;

  /// 圆环进度。
  final double progress;

  /// 是否处于完成态。
  final bool completed;

  /// 是否使用紧凑布局。
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ringSize = compact ? 248.0 : 332.0;
    final iconSize = compact ? 30.0 : 38.0;

    return Column(
      key: Key(completed ? 'bedtime-completed-hero' : 'bedtime-hero-card'),
      children: [
        Text(title, style: BedtimePageStyle.pageTitle(context)),
        SizedBox(height: compact ? 8 : 12),
        Text(
          subtitle,
          style: BedtimePageStyle.pageSubtitle(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: compact ? 14 : 28),
        SizedBox(
          key: const Key('bedtime-countdown-ring'),
          width: ringSize,
          height: ringSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size.square(ringSize),
                painter: _RingPainter(progress: progress),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: ringSize - (compact ? 64 : 84),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        completed
                            ? Icons.check_circle_outline_rounded
                            : Icons.nights_stay_rounded,
                        color: BedtimePageStyle.accent,
                        size: iconSize,
                      ),
                      SizedBox(height: compact ? 10 : 16),
                      Text(
                        countdownLabel,
                        style: BedtimePageStyle.countdownLabel(context),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: compact ? 8 : 12),
                      Text(
                        countdownValue,
                        style: BedtimePageStyle.countdownValue(context),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: compact ? 10 : 14),
                      Text(
                        caption,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: BedtimePageStyle.body,
                          height: 1.35,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 目标时间卡把“今晚锚点”从说明文案里抽出来，保证首屏第二信息层稳定。
class BedtimeTargetCard extends StatelessWidget {
  /// 创建目标时间卡。
  const BedtimeTargetCard({
    super.key,
    required this.bedtimeLabel,
    required this.wakeTimeLabel,
    required this.targetLabel,
    required this.wakeLabel,
    this.compact = false,
  });

  /// 目标入睡时间。
  final String bedtimeLabel;

  /// 目标起床时间。
  final String wakeTimeLabel;

  /// 入睡标签。
  final String targetLabel;

  /// 起床标签。
  final String wakeLabel;

  /// 是否使用紧凑布局。
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      key: const Key('bedtime-target-card'),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BedtimePageStyle.cardRadius,
        border: Border.all(color: BedtimePageStyle.stroke),
        boxShadow: BedtimePageStyle.cardShadow,
      ),
      padding: EdgeInsets.fromLTRB(
        compact ? 16 : 20,
        compact ? 14 : 20,
        compact ? 16 : 20,
        compact ? 14 : 20,
      ),
      child: Row(
        children: [
          Container(
            width: compact ? 48 : 58,
            height: compact ? 48 : 58,
            decoration: BoxDecoration(
              color: BedtimePageStyle.mist,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.schedule_rounded,
              color: BedtimePageStyle.accent,
              size: 24,
            ),
          ),
          SizedBox(width: compact ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(targetLabel, style: BedtimePageStyle.bodyText(context)),
                SizedBox(height: compact ? 4 : 6),
                Text(
                  bedtimeLabel,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: BedtimePageStyle.accent,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: compact ? 4 : 8),
                Text(
                  '$wakeLabel $wakeTimeLabel',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: BedtimePageStyle.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 三列选择区保持“只做一个判断”的冻结要求，不回退成纵向问卷。
class BedtimeChoiceGrid extends StatelessWidget {
  /// 创建三列状态选择区。
  const BedtimeChoiceGrid({
    super.key,
    required this.sectionTitle,
    required this.selectedChoice,
    required this.onSelect,
    required this.readyTitle,
    required this.windDownTitle,
    required this.delayTitle,
    this.compact = false,
  });

  /// 分区标题。
  final String sectionTitle;

  /// 当前已选状态。
  final BedtimeStatusChoice? selectedChoice;

  /// 选择回调。
  final ValueChanged<BedtimeStatusChoice> onSelect;

  /// “准备睡了”文案。
  final String readyTitle;

  /// “还要一点收尾”文案。
  final String windDownTitle;

  /// “大概率会晚睡”文案。
  final String delayTitle;

  /// 是否使用紧凑布局。
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('bedtime-choice-grid'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sectionTitle, style: BedtimePageStyle.sectionTitle(context)),
        SizedBox(height: compact ? 12 : 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ChoiceTile(
                tileKey: const Key('bedtime-choice-ready'),
                label: readyTitle,
                icon: Icons.check_rounded,
                color: BedtimePageStyle.accent,
                selected: selectedChoice == BedtimeStatusChoice.readyToSleep,
                onTap: () => onSelect(BedtimeStatusChoice.readyToSleep),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ChoiceTile(
                tileKey: const Key('bedtime-choice-wind-down'),
                label: windDownTitle,
                icon: Icons.favorite_border_rounded,
                color: const Color(0xFFFF8C72),
                selected: selectedChoice == BedtimeStatusChoice.needWindDown,
                onTap: () => onSelect(BedtimeStatusChoice.needWindDown),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ChoiceTile(
                tileKey: const Key('bedtime-choice-delay'),
                label: delayTitle,
                icon: Icons.schedule_rounded,
                color: const Color(0xFF8A9AA6),
                selected: selectedChoice == BedtimeStatusChoice.likelyDelay,
                onTap: () => onSelect(BedtimeStatusChoice.likelyDelay),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 单动作卡把收尾动作作为唯一下一步，不再额外派生第二强 CTA。
class BedtimeActionCard extends StatelessWidget {
  /// 创建单动作卡。
  const BedtimeActionCard({
    super.key,
    required this.sectionTitle,
    required this.title,
    required this.body,
    required this.icon,
    required this.accentColor,
    required this.completed,
    this.compact = false,
  });

  /// 分区标题。
  final String sectionTitle;

  /// 动作标题。
  final String title;

  /// 动作正文。
  final String body;

  /// 动作图标。
  final IconData icon;

  /// 强调色。
  final Color accentColor;

  /// 是否完成。
  final bool completed;

  /// 是否使用紧凑布局。
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sectionTitle, style: BedtimePageStyle.sectionTitle(context)),
        SizedBox(height: compact ? 12 : 18),
        Container(
          key: const Key('bedtime-action-card'),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BedtimePageStyle.cardRadius,
            border: Border.all(color: BedtimePageStyle.stroke),
            boxShadow: BedtimePageStyle.cardShadow,
          ),
          padding: EdgeInsets.fromLTRB(
            compact ? 14 : 18,
            compact ? 14 : 18,
            compact ? 14 : 18,
            compact ? 14 : 18,
          ),
          child: Row(
            children: [
              Container(
                width: compact ? 54 : 64,
                height: compact ? 54 : 64,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: compact ? 26 : 30),
              ),
              SizedBox(width: compact ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: BedtimePageStyle.cardTitle(context)),
                    SizedBox(height: compact ? 6 : 8),
                    Text(body, style: BedtimePageStyle.bodyText(context)),
                  ],
                ),
              ),
              SizedBox(width: compact ? 8 : 12),
              Container(
                width: compact ? 46 : 54,
                height: compact ? 46 : 54,
                decoration: BoxDecoration(
                  color: completed
                      ? BedtimePageStyle.mist
                      : accentColor.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  completed ? Icons.check_rounded : Icons.arrow_forward_rounded,
                  color: completed ? BedtimePageStyle.accent : accentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 恢复提示和提醒提示共用轻量横幅样式，避免页面再出现第二层主任务。
class BedtimeInfoBanner extends StatelessWidget {
  /// 创建轻量横幅。
  const BedtimeInfoBanner({
    super.key,
    required this.bannerKey,
    required this.icon,
    required this.body,
    required this.tint,
    required this.foreground,
  });

  /// 结构 key。
  final Key bannerKey;

  /// 图标。
  final IconData icon;

  /// 文案。
  final String body;

  /// 背景色。
  final Color tint;

  /// 前景色。
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: bannerKey,
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: foreground, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              body,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: foreground, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

/// 柔和光斑用于背景氛围，不承载任何信息语义。
class _GlowBlob extends StatelessWidget {
  /// 创建背景光斑。
  const _GlowBlob({
    required this.width,
    required this.height,
    required this.color,
  });

  /// 宽度。
  final double width;

  /// 高度。
  final double height;

  /// 色值。
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0.0)]),
      ),
    );
  }
}

/// 背景波纹用原生 path 轻量近似冻结稿，不引入额外位图资产。
class _WaveBand extends StatelessWidget {
  /// 创建背景波纹。
  const _WaveBand();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: CustomPaint(painter: _WaveBandPainter()),
    );
  }
}

/// 统一选择卡的交互材质，避免三个状态区出现不同组件语言。
class _ChoiceTile extends StatelessWidget {
  /// 创建选择卡。
  const _ChoiceTile({
    required this.tileKey,
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  /// 结构 key。
  final Key tileKey;

  /// 标题。
  final String label;

  /// 图标。
  final IconData icon;

  /// 强调色。
  final Color color;

  /// 是否选中。
  final bool selected;

  /// 点击事件。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: tileKey,
      borderRadius: BorderRadius.circular(26),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: selected ? color : BedtimePageStyle.stroke,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected ? BedtimePageStyle.cardShadow : null,
        ),
        padding: const EdgeInsets.fromLTRB(14, 22, 14, 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: color.withValues(alpha: selected ? 0.18 : 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 18),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: selected ? color : BedtimePageStyle.body,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// 以可控圆弧近似冻结稿中的倒计时环，满足“忠实还原”但不硬写复杂动画。
class _RingPainter extends CustomPainter {
  /// 创建圆环画笔。
  const _RingPainter({required this.progress});

  /// 当前进度。
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const strokeWidth = 16.0;
    final radius = (size.width - strokeWidth) / 2;
    final trackPaint = Paint()
      ..color = const Color(0xFFDCECEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF4DB2B7), Color(0xFF168A92)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweep = 2 * math.pi * progress.clamp(0.08, 0.97);
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -math.pi / 2, sweep, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// 背景波纹 painter 只负责氛围层，路径保持静态可预测。
class _WaveBandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fills = <Color>[
      const Color(0x1AD9EAF1),
      const Color(0x12D3E8EE),
      const Color(0x0FE8EEF3),
    ];

    for (var index = 0; index < fills.length; index++) {
      final baseTop = 56.0 + index * 34;
      final path = Path()
        ..moveTo(0, baseTop)
        ..cubicTo(
          size.width * 0.18,
          baseTop - 36,
          size.width * 0.32,
          baseTop + 18,
          size.width * 0.5,
          baseTop - 6,
        )
        ..cubicTo(
          size.width * 0.68,
          baseTop - 28,
          size.width * 0.84,
          baseTop + 24,
          size.width,
          baseTop - 12,
        )
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(path, Paint()..color = fills[index]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
