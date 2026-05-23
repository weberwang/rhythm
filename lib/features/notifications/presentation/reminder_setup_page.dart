import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/notifications/presentation/widgets/reminder_strategy_form_section.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../app/router/app_router.dart';

/// 提醒策略设置页，完成首启闭环并进入今日页。
class ReminderSetupPage extends HookConsumerWidget {
  /// 创建提醒策略设置页。
  const ReminderSetupPage({
    super.key,
    required this.launchStateRepository,
  });

  /// 首启状态仓储。
  final LaunchStateRepository launchStateRepository;

  Future<void> _completeOnboarding(BuildContext context) async {
    await launchStateRepository.markOnboardingCompleted();
    if (context.mounted) {
      context.go(RhythmTab.today.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
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
                      const _HeaderPill(text: '把提醒调到刚刚好'),
                      const SizedBox(height: 8),
                      Text(
                        '默认只开柔性提醒，不做连续轰炸式打断。',
                        style: textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Funnel Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.08,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '你可以先开轻提醒，后续再决定是否需要到点提醒。',
                        style: textTheme.bodyLarge?.copyWith(
                          fontFamily: 'Geist',
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const ReminderStrategyFormSection(),
                      const SizedBox(height: 12),
                      const _LeadTimeHintCard(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              RhythmPrimaryButton(
                label: l10n.reminderSetupCompleteButton,
                onPressed: () => _completeOnboarding(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 顶部胶囊。
class _HeaderPill extends StatelessWidget {
  /// 创建胶囊。
  const _HeaderPill({required this.text});

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

/// 提前量建议卡。
class _LeadTimeHintCard extends StatelessWidget {
  const _LeadTimeHintCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('提前量建议', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Chip(text: '15 分钟'),
              _Chip(text: '30 分钟'),
              _Chip(text: '45 分钟'),
            ],
          ),
        ],
      ),
    );
  }
}

/// 标签。
class _Chip extends StatelessWidget {
  const _Chip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
