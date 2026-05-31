import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 统一保存成功、同步失败等轻反馈横幅的基础外观。
class RhythmFeedbackBanner extends StatelessWidget {
  /// 创建轻反馈横幅。
  const RhythmFeedbackBanner({
    super.key,
    required this.title,
    this.message,
    this.leading,
    this.actionLabel,
    this.onAction,
    this.tone = RhythmFeedbackTone.info,
  });

  /// 标题文案。
  final String title;

  /// 可选说明文案。
  final String? message;

  /// 前置图标。
  final Widget? leading;

  /// 右侧操作文案。
  final String? actionLabel;

  /// 右侧操作回调。
  final VoidCallback? onAction;

  /// 横幅语义类型。
  final RhythmFeedbackTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = _resolveToneColors(context, tone);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: colors.foreground),
              child: leading!,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    color: colors.foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    message!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.foreground.withValues(alpha: 0.78),
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(width: 12),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: colors.foreground,
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }

  /// 根据语义类型解析横幅配色，确保轻反馈始终复用同一套状态 token。
  _RhythmFeedbackColors _resolveToneColors(
    BuildContext context,
    RhythmFeedbackTone tone,
  ) {
    final theme = Theme.of(context);
    final statusTokens = theme.extension<RhythmStatusThemeExtension>();
    final overlayTokens = theme.extension<RhythmOverlayThemeExtension>();
    final fallbackSurface =
        overlayTokens?.bannerColor ?? theme.colorScheme.surface;

    return switch (tone) {
      RhythmFeedbackTone.success => _RhythmFeedbackColors(
        surface: statusTokens?.successSurface ?? fallbackSurface,
        border:
            statusTokens?.success.withValues(alpha: 0.32) ??
            theme.colorScheme.secondary.withValues(alpha: 0.24),
        foreground: statusTokens?.success ?? theme.colorScheme.secondary,
      ),
      RhythmFeedbackTone.warning => _RhythmFeedbackColors(
        surface: statusTokens?.warningSurface ?? fallbackSurface,
        border:
            statusTokens?.warning.withValues(alpha: 0.32) ??
            theme.colorScheme.tertiary.withValues(alpha: 0.24),
        foreground: statusTokens?.warning ?? theme.colorScheme.tertiary,
      ),
      RhythmFeedbackTone.danger => _RhythmFeedbackColors(
        surface: statusTokens?.dangerSurface ?? fallbackSurface,
        border:
            statusTokens?.danger.withValues(alpha: 0.32) ??
            theme.colorScheme.error.withValues(alpha: 0.24),
        foreground: statusTokens?.danger ?? theme.colorScheme.error,
      ),
      RhythmFeedbackTone.info => _RhythmFeedbackColors(
        surface: statusTokens?.infoSurface ?? fallbackSurface,
        border:
            statusTokens?.info.withValues(alpha: 0.32) ??
            theme.colorScheme.primary.withValues(alpha: 0.24),
        foreground: statusTokens?.info ?? theme.colorScheme.primary,
      ),
    };
  }
}

/// 横幅支持的语义类型。
enum RhythmFeedbackTone {
  /// 信息提示。
  info,

  /// 成功提示。
  success,

  /// 警告提示。
  warning,

  /// 风险提示。
  danger,
}

/// 内部承载横幅三元配色，避免 build 方法里堆叠条件分支。
class _RhythmFeedbackColors {
  /// 创建横幅内部配色。
  const _RhythmFeedbackColors({
    required this.surface,
    required this.border,
    required this.foreground,
  });

  /// 背景色。
  final Color surface;

  /// 描边色。
  final Color border;

  /// 前景色。
  final Color foreground;
}
