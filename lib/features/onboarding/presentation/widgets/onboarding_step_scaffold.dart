import 'package:flutter/material.dart';

/// 首次引导页面骨架，统一顶部状态、标题说明和底部动作区的节奏。
class OnboardingStepScaffold extends StatelessWidget {
  /// 创建统一引导骨架。
  const OnboardingStepScaffold({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.content,
    required this.primaryAction,
    this.secondaryAction,
    this.footer,
  });

  /// 顶部提示文案。
  final String eyebrow;

  /// 主标题。
  final String title;

  /// 辅助说明。
  final String description;

  /// 中间主体内容。
  final Widget content;

  /// 主操作按钮。
  final Widget primaryAction;

  /// 次操作按钮。
  final Widget? secondaryAction;

  /// 底部补充信息或额外动作。
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 62),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Pill(text: eyebrow),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Funnel Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.08,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: textTheme.bodyLarge?.copyWith(
                          fontFamily: 'Geist',
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      content,
                    ],
                  ),
                ),
              ),
              if (footer != null) ...[
                const SizedBox(height: 12),
                footer!,
              ],
              if (secondaryAction != null) ...[
                const SizedBox(height: 12),
                secondaryAction!,
              ],
              const SizedBox(height: 12),
              primaryAction,
            ],
          ),
        ),
      ),
    );
  }
}

/// 顶部轻提示胶囊。
class _Pill extends StatelessWidget {
  /// 创建胶囊提示。
  const _Pill({required this.text});

  /// 文案。
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.primary,
          fontFamily: 'Geist',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
