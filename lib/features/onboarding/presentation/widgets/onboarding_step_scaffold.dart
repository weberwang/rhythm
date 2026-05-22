import 'package:flutter/material.dart';

/// 为首次引导步骤提供统一的安全区、留白和底部操作布局。
class OnboardingStepScaffold extends StatelessWidget {
  /// 创建引导步骤通用壳组件实例。
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

  /// 顶部弱提示标题。
  final String eyebrow;

  /// 主标题文案。
  final String title;

  /// 辅助说明文案。
  final String description;

  /// 步骤主体内容。
  final Widget content;

  /// 主操作按钮。
  final Widget primaryAction;

  /// 次操作按钮。
  final Widget? secondaryAction;

  /// 底部补充信息。
  final Widget? footer;

  /// 渲染统一风格的引导步骤页面。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(title, style: textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(
                description,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(child: content),
              if (footer != null) ...[
                footer!,
                const SizedBox(height: 16),
              ],
              if (secondaryAction != null) ...[
                secondaryAction!,
                const SizedBox(height: 12),
              ],
              primaryAction,
            ],
          ),
        ),
      ),
    );
  }
}
