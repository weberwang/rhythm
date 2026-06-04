import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../../shared/presentation/widgets/placeholder_feature_page.dart';

/// 洞察页占位骨架，后续会接入周报、稳定度和恢复效果区块。
class InsightsPage extends HookConsumerWidget {
  /// 创建洞察页。
  const InsightsPage({super.key});

  /// 洞察页路由路径。
  static const String routePath = '/insights';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    return PlaceholderFeaturePage(
      title: localization.insightsTitle,
      status: localization.placeholderStatus,
      description: localization.insightsBody,
    );
  }
}
