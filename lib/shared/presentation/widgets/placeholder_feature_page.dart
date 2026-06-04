import 'package:flutter/material.dart';

/// 统一承接初始化阶段的模块占位展示，避免每个页面重复搭脚手架。
class PlaceholderFeaturePage extends StatelessWidget {
  /// 创建模块占位页面。
  const PlaceholderFeaturePage({
    super.key,
    required this.title,
    required this.status,
    required this.description,
    this.action,
  });

  /// 页面标题。
  final String title;

  /// 状态标签。
  final String status;

  /// 描述文案。
  final String description;

  /// 可选动作按钮，供初始化阶段保留最小交互入口。
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status, style: theme.textTheme.labelLarge),
                  const SizedBox(height: 12),
                  Text(title, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Text(description, style: theme.textTheme.bodyLarge),
                  if (action != null) ...[
                    const SizedBox(height: 24),
                    action!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
