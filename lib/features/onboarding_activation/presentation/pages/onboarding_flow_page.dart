import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../../app/startup/launch_state_provider.dart';
import '../../../app_shell/application/providers/current_entry_intent_provider.dart';
import '../../../app_shell/domain/entities/shell_tab.dart';
import '../../../../shared/presentation/widgets/placeholder_feature_page.dart';

/// 激活引导页仅承接初始化阶段的最小路由入口，不提前实现完整漏斗。
class OnboardingFlowPage extends HookConsumerWidget {
  /// 创建引导页面。
  const OnboardingFlowPage({super.key});

  /// 引导页面路由路径。
  static const String routePath = '/onboarding';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);

    return PlaceholderFeaturePage(
      title: localization.onboardingTitle,
      status: localization.placeholderStatus,
      description: localization.onboardingBody,
      action: FilledButton(
        onPressed: () async {
          await ref.read(completeOnboardingProvider.future);
          if (context.mounted) {
            final entryIntent = ref.read(currentEntryIntentProvider);
            context.go(ShellTab.fromEntryIntent(entryIntent).location);
          }
        },
        child: Text(localization.onboardingContinue),
      ),
    );
  }
}
