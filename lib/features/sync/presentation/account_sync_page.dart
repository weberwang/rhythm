import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../core/presentation/widgets/rhythm_primary_button.dart';
import '../../../core/presentation/widgets/rhythm_secondary_button.dart';
import '../application/account_sync_controller.dart';

/// 展示阶段八的账号与同步页，统一承载身份摘要、同步状态和冲突策略说明。
class AccountSyncPage extends HookConsumerWidget {
  /// 创建账号与同步页。
  const AccountSyncPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(accountSyncControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: stateAsync.when(
            data: (state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  l10n.accountSyncPageTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Funnel Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.accountSyncPageDescription,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                _SectionCard(
                  title: l10n.accountSyncCurrentIdentityTitle,
                  description: _identityDescription(l10n, state),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _identityTitle(l10n, state),
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RhythmPrimaryButton(
                        label: _primaryActionLabel(l10n, state),
                        onPressed: state.status == AccountSyncStatus.synced
                            ? null
                            : () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: l10n.accountSyncSyncStatusTitle,
                  description: _syncDescription(l10n, state),
                  highlightColor: const Color(0xFFF4E8CF),
                  child: state.status == AccountSyncStatus.failed
                      ? RhythmSecondaryButton(
                          label: l10n.accountSyncRetryButton,
                          onPressed: () {
                            ref
                                .read(accountSyncControllerProvider.notifier)
                                .retrySync();
                          },
                        )
                      : _LastSyncedText(
                          lastSyncedAt: state.lastSyncedAt,
                          label: l10n.accountSyncLastSyncedLabel,
                        ),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: l10n.accountSyncConflictPolicyTitle,
                  description: l10n.accountSyncConflictPolicyDescription,
                  highlightColor: const Color(0xFFE8F0E1),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text(
                l10n.accountSyncUnavailableError,
                style: textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 账号页的身份卡需要根据登录态和可恢复能力切换文案，这里集中处理避免页面散落条件分支。
  String _identityTitle(AppLocalizations l10n, AccountSyncViewState state) {
    final email = state.email;
    if (email != null && email.isNotEmpty) {
      return email;
    }
    if (state.hasLinkedAccount) {
      return l10n.accountSyncIdentityLinkedFallbackTitle;
    }
    return l10n.accountSyncIdentityAnonymousTitle;
  }

  String _identityDescription(
    AppLocalizations l10n,
    AccountSyncViewState state,
  ) {
    if (state.hasLinkedAccount) {
      return state.status == AccountSyncStatus.synced
          ? l10n.accountSyncIdentityConnectedDescription
          : l10n.accountSyncIdentityLinkedDescription;
    }
    if (state.status == AccountSyncStatus.signInRequired) {
      return l10n.accountSyncIdentitySignInRequiredDescription;
    }
    return l10n.accountSyncIdentityAnonymousDescription;
  }

  String _primaryActionLabel(
    AppLocalizations l10n,
    AccountSyncViewState state,
  ) {
    return state.hasLinkedAccount
        ? l10n.accountSyncViewAccountButton
        : l10n.accountSyncBindAppleButton;
  }

  String _syncDescription(AppLocalizations l10n, AccountSyncViewState state) {
    switch (state.status) {
      case AccountSyncStatus.localOnly:
        return l10n.accountSyncLocalOnlyDescription;
      case AccountSyncStatus.signInRequired:
        return l10n.accountSyncSignInRequiredDescription;
      case AccountSyncStatus.failed:
        return l10n.accountSyncFailedDescription;
      case AccountSyncStatus.synced:
        return l10n.accountSyncSyncedDescription;
    }
  }
}

/// 统一承载阶段八设置页中的信息卡样式，避免页面层重复拼装圆角和阴影。
class _SectionCard extends StatelessWidget {
  /// 创建信息卡。
  const _SectionCard({
    required this.title,
    required this.description,
    this.child,
    this.highlightColor,
  });

  /// 信息卡标题。
  final String title;

  /// 信息卡说明。
  final String description;

  /// 附加内容。
  final Widget? child;

  /// 可选强调背景色。
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlightColor ?? colorScheme.surface,
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
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          if (child != null) ...[const SizedBox(height: 12), child!],
        ],
      ),
    );
  }
}

/// 当最近一次同步成功时间存在时，统一展示时间摘要，避免页面层散落格式化逻辑。
class _LastSyncedText extends StatelessWidget {
  /// 创建最近同步时间摘要。
  const _LastSyncedText({required this.lastSyncedAt, required this.label});

  /// 最近一次同步完成时间。
  final DateTime? lastSyncedAt;

  /// 最近同步文案前缀。
  final String label;

  @override
  Widget build(BuildContext context) {
    if (lastSyncedAt == null) {
      return const SizedBox.shrink();
    }

    final month = lastSyncedAt!.month.toString().padLeft(2, '0');
    final day = lastSyncedAt!.day.toString().padLeft(2, '0');
    final hour = lastSyncedAt!.hour.toString().padLeft(2, '0');
    final minute = lastSyncedAt!.minute.toString().padLeft(2, '0');
    return Text('$label$month-$day $hour:$minute');
  }
}
