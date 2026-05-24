import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/bedtime/application/bedtime_controller.dart';
import 'package:rhythm/features/bedtime/application/bedtime_view_state.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'widgets/sections/bedtime_action_suggestion_section.dart';
import 'widgets/sections/bedtime_countdown_section.dart';
import 'widgets/sections/bedtime_status_section.dart';

/// 睡前模式真实页面入口，负责按聚合状态编排倒计时、状态选择和动作建议。
class BedtimePage extends HookConsumerWidget {
  /// 创建睡前模式页。
  const BedtimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(bedtimeControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: stateAsync.when(
        data: (state) => _BedtimePageBody(state: state, l10n: l10n),
        loading: () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.bedtimePageTitle),
            const SizedBox(height: 24),
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
        error: (error, stackTrace) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.bedtimePageTitle),
            const SizedBox(height: 24),
            Expanded(
              child: _BedtimeGoalMissingState(l10n: l10n),
            ),
          ],
        ),
      ),
    );
  }
}

/// 承载睡前页首屏编排，避免主页面继续堆叠状态分支和区块细节。
class _BedtimePageBody extends HookConsumerWidget {
  const _BedtimePageBody({
    required this.state,
    required this.l10n,
  });

  final BedtimeViewState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (state.status) {
      case BedtimeViewStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case BedtimeViewStatus.goalMissing:
      case BedtimeViewStatus.notificationPermissionMissing:
        return _BedtimeGoalMissingState(l10n: l10n);
      case BedtimeViewStatus.ready:
        final controller = ref.read(bedtimeControllerProvider.notifier);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.bedtimePageTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 倒计时、状态选择和建议拆成独立区块，避免睡前页主文件再次膨胀。
                    BedtimeCountdownSection(
                      now: state.now!,
                      targetBedtime: state.targetBedtime!,
                      minutesUntilTarget: state.minutesUntilTarget,
                      progress: state.progress,
                    ),
                    const SizedBox(height: 12),
                    BedtimeStatusSection(
                      selectedStatus:
                          state.selectedStatus ?? state.recommendedStatus,
                      onSelected: controller.selectStatus,
                    ),
                    const SizedBox(height: 12),
                    BedtimeActionSuggestionSection(actions: state.actions),
                  ],
                ),
              ),
            ),
          ],
        );
    }
  }
}

/// 渲染睡前模式缺少目标时的统一空态，避免页面层散落多套提示。
class _BedtimeGoalMissingState extends StatelessWidget {
  const _BedtimeGoalMissingState({
    required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.bedtimeGoalMissingTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.bedtimeGoalMissingDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            RhythmPrimaryButton(
              label: l10n.bedtimeGoalMissingButton,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
