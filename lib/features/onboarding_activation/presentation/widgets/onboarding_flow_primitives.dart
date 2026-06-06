import 'package:flutter/material.dart';

/// 统一承载 onboarding 页面顶部身份信息，保证每一步都保留清晰的步骤和主题说明。
class OnboardingHeaderSection extends StatelessWidget {
  /// 创建顶部说明区。
  const OnboardingHeaderSection({
    super.key,
    required this.stepLabel,
    required this.title,
    required this.body,
    this.trailingAction,
  });

  /// 步骤文案。
  final String stepLabel;

  /// 标题文案。
  final String title;

  /// 说明文案。
  final String body;

  /// 标题区右上角操作，当前用于在引导起始页暴露跳过入口。
  final Widget? trailingAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerRowChildren = <Widget>[
      Expanded(
        child: Text(
          stepLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: const Color(0xFF2F6A43),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];

    if (trailingAction != null) {
      headerRowChildren.add(const SizedBox(width: 12));
      headerRowChildren.add(trailingAction!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: headerRowChildren,
        ),
        const SizedBox(height: 28),
        Text(
          title,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          body,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

/// 提供柔和背景光斑，避免 onboarding 再次退回平面占位背景。
class OnboardingSoftOrb extends StatelessWidget {
  /// 创建背景光斑。
  const OnboardingSoftOrb({
    super.key,
    required this.size,
    required this.color,
  });

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
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// 统一承载底部主操作，保证每一步都只有一个明确主目标。
class OnboardingBottomActionBar extends StatelessWidget {
  /// 创建底部操作区。
  const OnboardingBottomActionBar({
    super.key,
    required this.showBack,
    required this.backLabel,
    required this.primaryLabel,
    required this.onBack,
    required this.onPrimary,
    required this.isLoading,
  });

  /// 是否显示返回按钮。
  final bool showBack;

  /// 返回文案。
  final String backLabel;

  /// 主按钮文案。
  final String primaryLabel;

  /// 返回回调。
  final VoidCallback onBack;

  /// 主操作回调。
  final VoidCallback? onPrimary;

  /// 是否处于提交中。
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          children: [
            if (showBack)
              TextButton(onPressed: onBack, child: Text(backLabel))
            else
              const SizedBox(width: 88),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: isLoading ? null : onPrimary,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.4),
                      )
                    : Text(primaryLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 统一承载带柔和投影的大卡片，保持 welcome 与设置页的视觉层级一致。
class OnboardingLandscapeCard extends StatelessWidget {
  /// 创建柔和卡片。
  const OnboardingLandscapeCard({super.key, required this.child});

  /// 卡片内容。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFDDE6D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140D2E32),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(24), child: child),
    );
  }
}

/// 把 welcome 与说明区的价值点统一成一行一义，便于后续替换真实图标或插图。
class OnboardingBenefitRow extends StatelessWidget {
  /// 创建价值点行。
  const OnboardingBenefitRow({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  /// 图标。
  final IconData icon;

  /// 标题。
  final String title;

  /// 说明文案。
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.42),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 把进入方式与提醒策略统一为可选卡片，避免后续能力接入时再次重写容器结构。
class OnboardingSelectableModeCard extends StatelessWidget {
  /// 创建可选卡片。
  const OnboardingSelectableModeCard({
    super.key,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  /// 标题。
  final String title;

  /// 说明文案。
  final String body;

  /// 当前是否选中。
  final bool selected;

  /// 点击回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primary.withValues(alpha: 0.10)
                : Colors.white.withValues(alpha: 0.80),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : const Color(0xFFDDE6D6),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: selected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.48),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        body,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.72,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 统一承载作息时间选择入口，避免目标设置页退化成复杂设置列表。
class OnboardingTimeChoiceTile extends StatelessWidget {
  /// 创建时间选择项。
  const OnboardingTimeChoiceTile({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  /// 标题。
  final String title;

  /// 已选值。
  final String value;

  /// 点击回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(value, style: theme.textTheme.headlineSmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
