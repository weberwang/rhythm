import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示健康数据接入与权限页，统一承接平台状态、重新授权入口和手动模式说明。
class DataAccessPage extends HookConsumerWidget {
  /// 创建数据接入与权限页。
  const DataAccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final platformStateAsync = ref.watch(healthPlatformStateProvider);
    final recordsAsync = ref.watch(recentEffectiveSleepRecordsProvider);
    final l10n = AppLocalizations.of(context);

    final platformState = platformStateAsync.maybeWhen(
      data: (value) => value,
      orElse: () => null,
    );
    final records = recordsAsync.maybeWhen(
      data: (value) => value,
      orElse: () => const [],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondaryPageHeader(
                  title: l10n.dataAccessPageTitle,
                  fallbackLocation: RhythmTab.profile.path,
                  titleStyle: textTheme.headlineSmall?.copyWith(
                    fontFamily: 'Funnel Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.dataAccessPageDescription,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                _StatusCard(
                  title: _statusTitle(l10n, platformState),
                  description: _statusDescription(
                    l10n,
                    platformState,
                    records.length,
                  ),
                  dark: platformState?.canReadData ?? false,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final gateway = ref.read(
                            healthPermissionGatewayProvider,
                          );
                          if (platformState?.canInstallProvider ?? false) {
                            await gateway.openHealthProviderInstallation();
                            return;
                          }
                          if (platformState?.canRequestAccess ?? false) {
                            await gateway.requestAccess();
                          }
                        },
                        child: Text(l10n.dataAccessReauthorizeButton),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.tonal(
                        onPressed: () =>
                            context.pushSecondary(sleepRecordsHubPath),
                        child: Text(l10n.dataAccessManualModeButton),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _InfoCard(
                  title: l10n.sleepRecordsHubSourceTitle,
                  descriptionLines: [
                    l10n.sleepRecordsHubSourceBulletOriginal,
                    l10n.sleepRecordsHubSourceBulletManual,
                    l10n.sleepRecordsHubSourceBulletFallback,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusTitle(AppLocalizations l10n, HealthPlatformState? state) {
    switch (state?.platformCode) {
      case 'ios_available':
        return l10n.dataAccessStatusHealthKitConnected;
      case 'android_available':
        return l10n.dataAccessStatusHealthConnectConnected;
      case 'android_install_required':
        return l10n.dataAccessStatusInstallRequired;
      case 'ios_permission_required':
      case 'android_permission_required':
        return l10n.dataAccessStatusPermissionRequired;
      default:
        return l10n.dataAccessStatusManualFallback;
    }
  }

  /// 统一生成接入状态摘要，避免页面层散落平台差异和记录数量文案。
  String _statusDescription(
    AppLocalizations l10n,
    HealthPlatformState? state,
    int recordCount,
  ) {
    switch (state?.platformCode) {
      case 'ios_available':
      case 'android_available':
        return l10n.dataAccessStatusConnectedDescription(recordCount);
      case 'android_install_required':
        return l10n.dataAccessStatusInstallRequiredDescription;
      case 'ios_permission_required':
      case 'android_permission_required':
        return l10n.dataAccessStatusPermissionRequiredDescription;
      default:
        return l10n.dataAccessStatusManualFallbackDescription;
    }
  }
}

/// 渲染数据接入状态卡，统一复用暗色成功卡和浅色降级卡的层级结构。
class _StatusCard extends StatelessWidget {
  /// 创建状态卡。
  const _StatusCard({
    required this.title,
    required this.description,
    required this.dark,
  });

  /// 状态标题。
  final String title;

  /// 状态说明。
  final String description;

  /// 是否使用深色强调样式。
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1B3A28) : const Color(0xFFF9FBF6),
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
            style: textTheme.titleMedium?.copyWith(
              color: dark ? Colors.white : const Color(0xFF1B3A28),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: dark ? const Color(0xFFD7E7DA) : const Color(0xFF4A6B52),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// 渲染来源与可信度说明卡，避免页面层重复拼装多条说明文案。
class _InfoCard extends StatelessWidget {
  /// 创建说明卡。
  const _InfoCard({required this.title, required this.descriptionLines});

  /// 卡片标题。
  final String title;

  /// 说明行列表。
  final List<String> descriptionLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
          for (var index = 0; index < descriptionLines.length; index++) ...[
            Text(descriptionLines[index]),
            if (index != descriptionLines.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}
