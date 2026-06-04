import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../../shared/presentation/widgets/placeholder_feature_page.dart';

/// 今日页占位骨架，后续会接入结果卡、目标卡和恢复建议区块。
class TodayPage extends HookConsumerWidget {
  /// 创建今日页。
  const TodayPage({super.key});

  /// 今日页路由路径。
  static const String routePath = '/today';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    return PlaceholderFeaturePage(
      title: localization.todayTitle,
      status: localization.placeholderStatus,
      description: localization.todayBody,
    );
  }
}
