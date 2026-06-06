import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../app_shell/application/providers/current_account_session_provider.dart';
import '../../../app_shell/domain/entities/account_session.dart';

/// 设置页占位骨架，先消费共享账号快照，为后续会员与同步配置保留稳定入口。
class ProfileSettingsPage extends HookConsumerWidget {
  /// 创建设置页。
  const ProfileSettingsPage({super.key});

  /// 设置页路由路径。
  static const String routePath = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final accountSessionAsync = ref.watch(currentAccountSessionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(localization.profileTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _AccountSessionCard(accountSessionAsync: accountSessionAsync),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localization.placeholderStatus,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localization.profileTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localization.profileBody,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 在设置页顶部先暴露账号模式摘要，为后续同步、会员和隐私分组提供上游语义。
class _AccountSessionCard extends StatelessWidget {
  /// 创建账号摘要卡片。
  const _AccountSessionCard({required this.accountSessionAsync});

  /// 当前共享账号快照异步状态。
  final AsyncValue<AppAccountSession?> accountSessionAsync;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: accountSessionAsync.when(
          data: (session) {
            final title = _titleForSession(localization, session);
            final body = _bodyForSession(localization, session);
            final providerLabel = _providerLabel(localization, session?.provider);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(body, style: theme.textTheme.bodyLarge),
                if (providerLabel != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    providerLabel,
                    style: theme.textTheme.labelLarge,
                  ),
                ],
                if (session?.displayName case final displayName?) ...[
                  const SizedBox(height: 12),
                  Text(displayName, style: theme.textTheme.titleMedium),
                ],
                if (session?.email case final email?) ...[
                  const SizedBox(height: 6),
                  Text(email, style: theme.textTheme.bodyMedium),
                ],
              ],
            );
          },
          loading: () => const _AccountSessionLoadingCard(),
          error: (_, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localization.profileAccountAnonymousTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                localization.profileAccountLoadFallbackBody,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 匿名态与已连接态使用不同标题，确保设置页先把账号语义讲清楚。
  String _titleForSession(
    AppLocalizations localization,
    AppAccountSession? session,
  ) {
    if (session?.mode == AppAccountSessionMode.connected) {
      final provider = _providerLabel(localization, session?.provider);
      if (provider != null) {
        return localization.profileAccountConnectedTitle(provider);
      }
    }

    return localization.profileAccountAnonymousTitle;
  }

  /// 账号说明文案根据会话模式切换，避免后续同步入口缺少上文。
  String _bodyForSession(
    AppLocalizations localization,
    AppAccountSession? session,
  ) {
    return switch (session?.mode) {
      AppAccountSessionMode.connected =>
        localization.profileAccountConnectedBody,
      _ => localization.profileAccountAnonymousBody,
    };
  }

  /// 统一翻译账号来源标签，避免页面散落 Apple / Google 文案拼装逻辑。
  String? _providerLabel(
    AppLocalizations localization,
    AppAccountProvider? provider,
  ) {
    return switch (provider) {
      AppAccountProvider.apple => localization.accountProviderAppleLabel,
      AppAccountProvider.google => localization.accountProviderGoogleLabel,
      null => null,
    };
  }
}

/// 在账号快照读取期间保留稳定骨架，避免设置页头部闪空。
class _AccountSessionLoadingCard extends StatelessWidget {
  /// 创建加载骨架。
  const _AccountSessionLoadingCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 180,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 16,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 220,
          height: 16,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
