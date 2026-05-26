import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示时区与特殊情况说明页，帮助用户理解记录归属规则和特殊作息处理方式。
class TimezoneModePage extends HookConsumerWidget {
  /// 创建时区与特殊情况说明页。
  const TimezoneModePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeContext = ref.watch(timeContextProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondaryPageHeader(
                  title: l10n.timezoneModePageTitle,
                  fallbackLocation: RhythmTab.profile.path,
                  titleStyle: textTheme.headlineSmall?.copyWith(
                    fontFamily: 'Funnel Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.timezoneModePageDescription,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                _Card(
                  title: l10n.timezoneModeCurrentTimezoneTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeContext.timezoneName,
                        style: textTheme.headlineSmall?.copyWith(
                          fontFamily: 'IBM Plex Mono',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.timezoneModeCurrentTimezoneDescription,
                        style: textTheme.bodyMedium?.copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _Card(
                  title: l10n.timezoneModeSpecialModeTitle,
                  backgroundColor: const Color(0xFFF4E8CF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 将特殊情况拆成独立段落，便于后续逐项替换为真实能力说明。
                      Text(l10n.timezoneModeCrossTimezoneDescription),
                      const SizedBox(height: 8),
                      Text(l10n.timezoneModeShiftWorkDescription),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 渲染时区页中的信息卡，保持页面层只负责组织层级，不重复拼装卡片样式。
class _Card extends StatelessWidget {
  /// 创建时区信息卡。
  const _Card({required this.title, required this.child, this.backgroundColor});

  /// 卡片标题。
  final String title;

  /// 卡片内容。
  final Widget child;

  /// 可选背景色。
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
