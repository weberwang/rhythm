import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../../shared/presentation/widgets/placeholder_feature_page.dart';

/// 设置页占位骨架，后续会接入账号、会员、同步和提醒设置分组。
class ProfileSettingsPage extends HookConsumerWidget {
  /// 创建设置页。
  const ProfileSettingsPage({super.key});

  /// 设置页路由路径。
  static const String routePath = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    return PlaceholderFeaturePage(
      title: localization.profileTitle,
      status: localization.placeholderStatus,
      description: localization.profileBody,
    );
  }
}
