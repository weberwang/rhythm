import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../../shared/presentation/widgets/placeholder_feature_page.dart';

/// 日历页占位骨架，后续会接入月度热力图与单日详情能力。
class CalendarPage extends HookConsumerWidget {
  /// 创建日历页。
  const CalendarPage({super.key});

  /// 日历页路由路径。
  static const String routePath = '/calendar';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    return PlaceholderFeaturePage(
      title: localization.calendarTitle,
      status: localization.placeholderStatus,
      description: localization.calendarBody,
    );
  }
}
