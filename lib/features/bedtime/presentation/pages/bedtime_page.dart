import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../../shared/presentation/widgets/placeholder_feature_page.dart';

/// 睡前页占位骨架，后续会接入倒计时、状态选择和轻收尾动作。
class BedtimePage extends HookConsumerWidget {
  /// 创建睡前页。
  const BedtimePage({super.key});

  /// 睡前页路由路径。
  static const String routePath = '/bedtime';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    return PlaceholderFeaturePage(
      title: localization.bedtimeTitle,
      status: localization.placeholderStatus,
      description: localization.bedtimeBody,
    );
  }
}
