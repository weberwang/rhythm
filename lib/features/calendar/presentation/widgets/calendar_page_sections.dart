import 'package:flutter/material.dart';

import 'calendar_page_style.dart';

/// 统一承接页面里的柔光背景，不让主文件塞满装饰细节。
class CalendarDecorativeBackground extends StatelessWidget {
  /// 创建背景层。
  const CalendarDecorativeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned(
          top: -92,
          left: -52,
          child: _BackdropGlow(
            size: 240,
            color: CalendarPageStyle.headerGlow,
          ),
        ),
        Positioned(
          top: 180,
          right: -74,
          child: _BackdropGlow(
            size: 240,
            color: CalendarPageStyle.secondaryGlow,
          ),
        ),
      ],
    );
  }
}

/// 统一卡片材质，保证摘要卡、热力图卡和详情卡具有同一视觉系统。
class CalendarSurfaceCard extends StatelessWidget {
  /// 创建卡片容器。
  const CalendarSurfaceCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.fromLTRB(24, 24, 24, 24),
    this.color,
  });

  /// 卡片内容。
  final Widget child;

  /// 卡片内边距。
  final EdgeInsets padding;

  /// 可选底色。
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: CalendarPageStyle.cardRadius,
        border: Border.all(color: CalendarPageStyle.stroke),
        boxShadow: CalendarPageStyle.cardShadow,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

/// 品牌字标延续 today 页的波纹语义，但局部封装在 calendar 模块里。
class CalendarWordmark extends StatelessWidget {
  /// 创建品牌头。
  const CalendarWordmark({super.key});

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
        Text('Rhythm', style: CalendarPageStyle.brandWordmark(context)),
      ],
    );
  }
}

/// 顶部更多按钮使用圆形轻描边容器，保持冻结图里的轻量感。
class CalendarHeaderActionButton extends StatelessWidget {
  /// 创建头部动作按钮。
  const CalendarHeaderActionButton({required this.onPressed, super.key});

  /// 点击回调。
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        border: Border.all(color: CalendarPageStyle.stroke),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A102E37),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.more_horiz_rounded),
        color: CalendarPageStyle.ink,
      ),
    );
  }
}

/// 单个摘要指标统一使用图标圆底 + 值 + 标签的三层结构。
class CalendarSummaryMetricTile extends StatelessWidget {
  /// 创建摘要指标。
  const CalendarSummaryMetricTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.tint,
    super.key,
  });

  /// 指标图标。
  final IconData icon;

  /// 指标值。
  final String value;

  /// 指标标签。
  final String label;

  /// 图标承载底色。
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: tint,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 14),
        Text(value, style: CalendarPageStyle.metricValue(context)),
        const SizedBox(height: 6),
        Text(label, style: CalendarPageStyle.metricLabel(context)),
      ],
    );
  }
}

/// 筛选条使用更轻的 segmented 控件感，而不是普通 ChoiceChip 质感。
class CalendarFilterPill extends StatelessWidget {
  /// 创建筛选 pill。
  const CalendarFilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  /// 显示文案。
  final String label;

  /// 是否选中。
  final bool selected;

  /// 点击回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.secondary : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? theme.colorScheme.secondary : CalendarPageStyle.ink,
            width: selected ? 0 : 1.4,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Icon(
                Icons.check_rounded,
                size: 18,
                color: theme.colorScheme.onSecondary,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: CalendarPageStyle.ink,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 热力图星期标题单独封装，避免主文件里塞进小样式细节。
class CalendarWeekdayLabel extends StatelessWidget {
  /// 创建星期标题。
  const CalendarWeekdayLabel(this.label, {super.key});

  /// 显示文案。
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: CalendarPageStyle.weekdayLabel(context)),
    );
  }
}

/// 统一承接热力图格子渲染，保证 42 个格子具有稳定尺寸和选中态语义。
class CalendarHeatmapTile extends StatelessWidget {
  /// 创建热力图格子。
  const CalendarHeatmapTile({
    required this.dayLabel,
    required this.offsetLabel,
    required this.active,
    required this.currentMonth,
    required this.fillColor,
    super.key,
    this.onTap,
  });

  /// 日期文案。
  final String dayLabel;

  /// 偏移文案。
  final String? offsetLabel;

  /// 当前是否为选中态。
  final bool active;

  /// 是否属于当前月份。
  final bool currentMonth;

  /// 格子底色。
  final Color fillColor;

  /// 点击回调。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = active
        ? CalendarPageStyle.selectedForeground
        : currentMonth
        ? CalendarPageStyle.ink
        : CalendarPageStyle.body.withValues(alpha: 0.42);
    final borderColor = active
        ? CalendarPageStyle.selectedFill.withValues(alpha: 0.86)
        : currentMonth
        ? CalendarPageStyle.stroke
        : CalendarPageStyle.stroke.withValues(alpha: 0.76);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: active ? CalendarPageStyle.selectedFill : fillColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: active ? 2 : 1),
            boxShadow: active
                ? const [
                    BoxShadow(
                      color: Color(0x223F63D6),
                      blurRadius: 18,
                      offset: Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact =
                  constraints.maxWidth < 40 || constraints.maxHeight < 52;
              final tiny =
                  constraints.maxWidth < 30 || constraints.maxHeight < 40;
              final dayStyle = CalendarPageStyle.heatmapDay(
                context,
                color: foreground,
              ).copyWith(fontSize: tiny ? 13 : compact ? 15 : 19);
              final offsetStyle = CalendarPageStyle.heatmapOffset(
                context,
                color: active
                    ? CalendarPageStyle.selectedForeground.withValues(alpha: 0.94)
                    : foreground.withValues(alpha: 0.92),
              ).copyWith(fontSize: tiny ? 0 : compact ? 10 : 12.5);

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  tiny ? 3 : compact ? 5 : 10,
                  tiny ? 3 : compact ? 5 : 10,
                  tiny ? 3 : compact ? 5 : 10,
                  tiny ? 3 : compact ? 4 : 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: tiny
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dayLabel, style: dayStyle, maxLines: 1),
                    if (!tiny && offsetLabel != null)
                      FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(offsetLabel!, style: offsetStyle),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 页面内底部详情卡承接选中单日的解释，不再默认走 modal。
class CalendarSelectedDayCard extends StatelessWidget {
  /// 创建详情卡。
  const CalendarSelectedDayCard({
    required this.dateLabel,
    required this.offsetLabel,
    required this.bedtimeTitle,
    required this.wakeTimeTitle,
    required this.totalSleepTitle,
    required this.bedtimeLabel,
    required this.wakeTimeLabel,
    required this.durationLabel,
    required this.sourceLabel,
    required this.adjustmentLabel,
    required this.confidenceLabel,
    super.key,
    this.note,
  });

  /// 日期标题。
  final String dateLabel;

  /// 偏移解释。
  final String offsetLabel;

  /// 入睡时间。
  final String bedtimeTitle;

  /// 起床时间标题。
  final String wakeTimeTitle;

  /// 睡眠时长标题。
  final String totalSleepTitle;

  /// 入睡时间值。
  final String bedtimeLabel;

  /// 起床时间。
  final String wakeTimeLabel;

  /// 睡眠时长。
  final String durationLabel;

  /// 来源标签。
  final String sourceLabel;

  /// 修正状态标签。
  final String adjustmentLabel;

  /// 数据完整度标签。
  final String confidenceLabel;

  /// 可选备注。
  final String? note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CalendarSurfaceCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateLabel,
                      style: CalendarPageStyle.detailTitle(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      offsetLabel,
                      style: CalendarPageStyle.detailAccent(context),
                    ),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.72),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bedtime_rounded,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Divider(height: 1),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _DetailMetricColumn(
                  icon: Icons.hotel_rounded,
                  label: bedtimeTitle,
                  value: bedtimeLabel,
                ),
              ),
              Expanded(
                child: _DetailMetricColumn(
                  icon: Icons.wb_sunny_outlined,
                  label: wakeTimeTitle,
                  value: wakeTimeLabel,
                ),
              ),
              Expanded(
                child: _DetailMetricColumn(
                  icon: Icons.track_changes_rounded,
                  label: totalSleepTitle,
                  value: durationLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _MetadataChip(
                icon: Icons.layers_outlined,
                label: sourceLabel,
              ),
              _MetadataChip(
                icon: Icons.draw_rounded,
                label: adjustmentLabel,
              ),
              _MetadataChip(
                icon: Icons.shield_outlined,
                label: confidenceLabel,
              ),
            ],
          ),
          if (note?.isNotEmpty == true) ...[
            const SizedBox(height: 18),
            Text(
              note!,
              style: CalendarPageStyle.summaryBody(context),
            ),
          ],
        ],
      ),
    );
  }
}

/// 详情卡三列指标维持统一版式，避免信息层级杂乱。
class _DetailMetricColumn extends StatelessWidget {
  /// 创建详情指标列。
  const _DetailMetricColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  /// 指标图标。
  final IconData icon;

  /// 指标标签。
  final String label;

  /// 指标值。
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 10),
        Text(label, style: CalendarPageStyle.detailLabel(context)),
        const SizedBox(height: 6),
        Text(value, style: CalendarPageStyle.detailValue(context)),
      ],
    );
  }
}

/// 来源、修正和完整度使用统一轻徽标容器承接。
class _MetadataChip extends StatelessWidget {
  /// 创建元数据徽标。
  const _MetadataChip({required this.icon, required this.label});

  /// 图标。
  final IconData icon;

  /// 文案。
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: CalendarPageStyle.stroke),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CalendarPageStyle.ink,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 柔光背景只作为氛围层，不承担信息语义。
class _BackdropGlow extends StatelessWidget {
  /// 创建背景光斑。
  const _BackdropGlow({required this.size, required this.color});

  /// 光斑尺寸。
  final double size;

  /// 光斑颜色。
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

/// 波纹标识继续使用矢量绘制，避免为了简单品牌头再引入位图依赖。
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
