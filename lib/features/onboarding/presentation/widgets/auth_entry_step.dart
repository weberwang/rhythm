import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';

/// 展示登录方式选择步骤，当前只记录用户选择并允许匿名继续。
class AuthEntryStep extends StatelessWidget {
  /// 创建登录方式选择步骤组件实例。
  const AuthEntryStep({super.key, required this.onSelectAuthOption});

  /// 用户选择任一登录方式后的回调。
  final ValueChanged<OnboardingAuthOption> onSelectAuthOption;

  /// 渲染登录方式选择步骤。
  @override
  Widget build(BuildContext context) {
    return OnboardingStepScaffold(
      eyebrow: '第 2 步 / 3',
      title: '选择你的进入方式',
      description: '你可以先匿名体验，后续再决定是否绑定 Apple 或 Google 账号。',
      content: Column(
        children: [
          _AuthOptionCard(
            label: '使用 Apple 继续',
            description: '保留设计中的账号入口，当前版本暂不接入真实 SDK。',
            onTap: () => onSelectAuthOption(OnboardingAuthOption.apple),
          ),
          const SizedBox(height: 12),
          _AuthOptionCard(
            label: '使用 Google 继续',
            description: '先作为流程选项展示，后续任务再补充真实登录逻辑。',
            onTap: () => onSelectAuthOption(OnboardingAuthOption.google),
          ),
        ],
      ),
      secondaryAction: RhythmSecondaryButton(
        label: '匿名体验',
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.anonymous),
      ),
      primaryAction: RhythmSecondaryButton(
        label: '稍后再绑定账号',
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.anonymous),
      ),
    );
  }
}

/// 承载单个登录入口说明，保持按钮区和说明区分组明确。
class _AuthOptionCard extends StatelessWidget {
  /// 创建登录入口卡片实例。
  const _AuthOptionCard({
    required this.label,
    required this.description,
    required this.onTap,
  });

  /// 登录入口标题。
  final String label;

  /// 登录入口说明文案。
  final String description;

  /// 点击入口后的回调。
  final VoidCallback onTap;

  /// 渲染登录入口卡片。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.arrow_forward, color: colorScheme.onPrimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
