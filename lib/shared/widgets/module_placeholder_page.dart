import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 在 bootstrap 阶段承接 feature 路由的占位页面。
class ModulePlaceholderPage extends StatelessWidget {
  /// 创建占位页面。
  const ModulePlaceholderPage({
    required this.title,
    required this.description,
    super.key,
  });

  /// 页面标题。
  final String title;

  /// 页面说明。
  final String description;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: RhythmTextStyles.pageTitle),
            const SizedBox(height: RhythmSpacing.s),
            Text(description, style: RhythmTextStyles.body),
            const SizedBox(height: RhythmSpacing.xl),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(RhythmSpacing.l),
                child: Text(
                  l10n.modulePlaceholderCardMessage,
                  style: RhythmTextStyles.body.copyWith(
                    color: RhythmColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
