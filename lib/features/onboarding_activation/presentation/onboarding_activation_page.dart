import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/onboarding_activation/application/onboarding_activation_controller.dart';
import 'package:rhythm/features/onboarding_activation/domain/onboarding_activation_models.dart';
import 'package:rhythm/l10n/app_localizations.dart';

const _bedtimeOptions = <int>[21, 22, 23, 0, 1];
const _wakeOptions = <int>[5, 6, 7, 8, 9];
const _reminderLeadOptions = <int>[15, 30, 60];

/// 首次激活页面，负责承接最小 onboarding 完成动作并进入主链路。
class OnboardingActivationPage extends HookConsumerWidget {
  /// 创建首次激活页面。
  const OnboardingActivationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final activationState = ref.watch(onboardingActivationControllerProvider);

    return activationState.when(
      data: (state) => _OnboardingScaffold(
        state: state,
        onContinue: () => _handleContinue(context, ref, state),
        onBack: state.currentStep == OnboardingActivationStep.welcome
            ? null
            : () => ref
                .read(onboardingActivationControllerProvider.notifier)
                .goBack(),
      ),
      loading: () => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(),
                const SizedBox(height: RhythmSpacing.m),
                Text(
                  l10n.onboardingLoadingMessage,
                  style: RhythmTextStyles.body,
                ),
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(RhythmSpacing.l),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.onboardingLoadFailedTitle,
                  style: RhythmTextStyles.cardTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: RhythmSpacing.s),
                Text(
                  l10n.onboardingLoadFailedBody,
                  style: RhythmTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: RhythmSpacing.l),
                FilledButton(
                  onPressed: () => ref.invalidate(
                    onboardingActivationControllerProvider,
                  ),
                  child: Text(l10n.appShellRetry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 提交当前步骤动作，只有完成后才进入 today 主链路。
  Future<void> _handleContinue(
    BuildContext context,
    WidgetRef ref,
    OnboardingActivationState state,
  ) async {
    final notifier = ref.read(onboardingActivationControllerProvider.notifier);
    final completed = await notifier.continueFlow();
    if (!context.mounted ||
        !completed ||
        state.currentStep != OnboardingActivationStep.reminders) {
      return;
    }

    context.go('/today');
  }
}

class _OnboardingScaffold extends ConsumerWidget {
  const _OnboardingScaffold({
    required this.state,
    required this.onContinue,
    required this.onBack,
  });

  final OnboardingActivationState state;
  final Future<void> Function() onContinue;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingActivationControllerProvider.notifier);
    final canContinue = controller.canContinue(state) && !state.isSubmitting;
    final errorMessage = state.submissionErrorMessage == null
        ? null
        : _resolveCopy(l10n, state.submissionErrorMessage!);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ActivationStepHeader(step: state.currentStep),
                    const SizedBox(height: RhythmSpacing.l),
                    ..._buildStepContent(context, ref, state),
                  ],
                ),
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: RhythmColors.surfaceElevated,
                border: Border(
                  top: BorderSide(color: RhythmColors.borderSubtle),
                ),
              ),
              child: SafeArea(
                top: false,
                minimum: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (errorMessage != null) ...[
                      Text(
                        errorMessage,
                        style: RhythmTextStyles.body.copyWith(
                          color: RhythmColors.error,
                        ),
                      ),
                      const SizedBox(height: RhythmSpacing.s),
                    ],
                    Row(
                      children: [
                        if (onBack != null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: state.isSubmitting ? null : onBack,
                              child: Text(l10n.onboardingBackAction),
                            ),
                          ),
                        if (onBack != null) const SizedBox(width: RhythmSpacing.m),
                        Expanded(
                          child: FilledButton(
                            onPressed: canContinue ? onContinue : null,
                            child: state.isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(_continueLabel(l10n, state.currentStep)),
                          ),
                        ),
                      ],
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

  List<Widget> _buildStepContent(
    BuildContext context,
    WidgetRef ref,
    OnboardingActivationState state,
  ) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(onboardingActivationControllerProvider.notifier);

    switch (state.currentStep) {
      case OnboardingActivationStep.welcome:
        return [
          Text(l10n.onboardingWelcomeTitle, style: RhythmTextStyles.pageTitle),
          const SizedBox(height: RhythmSpacing.s),
          Text(l10n.onboardingWelcomeBody, style: RhythmTextStyles.body),
          const SizedBox(height: RhythmSpacing.xl),
          _ChoiceCard(
            title: l10n.onboardingAnonymousTitle,
            body: l10n.onboardingAnonymousBody,
            selected: state.entryMode == OnboardingEntryMode.anonymous,
            onTap: () => notifier.selectEntryMode(OnboardingEntryMode.anonymous),
          ),
          const SizedBox(height: RhythmSpacing.m),
          _ChoiceCard(
            title: l10n.onboardingConnectLaterTitle,
            body: l10n.onboardingConnectLaterBody,
            selected: state.entryMode == OnboardingEntryMode.connectLater,
            onTap: () => notifier.selectEntryMode(
              OnboardingEntryMode.connectLater,
            ),
          ),
        ];
      case OnboardingActivationStep.healthAccess:
        return [
          Text(
            l10n.onboardingHealthAccessTitle,
            style: RhythmTextStyles.pageTitle,
          ),
          const SizedBox(height: RhythmSpacing.s),
          Text(
            l10n.onboardingHealthAccessBody,
            style: RhythmTextStyles.body,
          ),
          const SizedBox(height: RhythmSpacing.xl),
          _ChoiceCard(
            title: l10n.onboardingHealthConnectTitle,
            body: l10n.onboardingHealthConnectBody,
            selected: state.healthChoice == OnboardingHealthChoice.connectHealth,
            onTap: () => notifier.selectHealthChoice(
              OnboardingHealthChoice.connectHealth,
            ),
          ),
          const SizedBox(height: RhythmSpacing.m),
          _ChoiceCard(
            title: l10n.onboardingHealthManualTitle,
            body: l10n.onboardingHealthManualBody,
            selected: state.healthChoice == OnboardingHealthChoice.manualOnly,
            onTap: () => notifier.selectHealthChoice(
              OnboardingHealthChoice.manualOnly,
            ),
          ),
        ];
      case OnboardingActivationStep.sleepWindow:
        return [
          Text(
            l10n.onboardingSleepWindowTitle,
            style: RhythmTextStyles.pageTitle,
          ),
          const SizedBox(height: RhythmSpacing.s),
          Text(
            l10n.onboardingSleepWindowBody,
            style: RhythmTextStyles.body,
          ),
          const SizedBox(height: RhythmSpacing.xl),
          _SelectionCard(
            title: l10n.onboardingBedtimeLabel,
            child: DropdownButtonFormField<int>(
              initialValue: state.bedtimeHour,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _bedtimeOptions
                  .map(
                    (hour) => DropdownMenuItem<int>(
                      value: hour,
                      child: Text(_formatHour(hour)),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value != null) {
                  notifier.setBedtimeHour(value);
                }
              },
            ),
          ),
          const SizedBox(height: RhythmSpacing.m),
          _SelectionCard(
            title: l10n.onboardingWakeTimeLabel,
            child: DropdownButtonFormField<int>(
              initialValue: state.wakeHour,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _wakeOptions
                  .map(
                    (hour) => DropdownMenuItem<int>(
                      value: hour,
                      child: Text(_formatHour(hour)),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value != null) {
                  notifier.setWakeHour(value);
                }
              },
            ),
          ),
          const SizedBox(height: RhythmSpacing.s),
          Text(
            l10n.onboardingSleepWindowHint,
            style: RhythmTextStyles.pageMeta,
          ),
        ];
      case OnboardingActivationStep.reminders:
        return [
          Text(
            l10n.onboardingReminderTitle,
            style: RhythmTextStyles.pageTitle,
          ),
          const SizedBox(height: RhythmSpacing.s),
          Text(l10n.onboardingReminderBody, style: RhythmTextStyles.body),
          const SizedBox(height: RhythmSpacing.xl),
          _ChoiceCard(
            title: l10n.onboardingReminderEnabledTitle,
            body: l10n.onboardingReminderEnabledBody,
            selected:
                state.reminderChoice == OnboardingReminderChoice.enabled,
            onTap: () => notifier.setReminderChoice(
              OnboardingReminderChoice.enabled,
            ),
          ),
          const SizedBox(height: RhythmSpacing.m),
          _ChoiceCard(
            title: l10n.onboardingReminderDisabledTitle,
            body: l10n.onboardingReminderDisabledBody,
            selected:
                state.reminderChoice == OnboardingReminderChoice.disabled,
            onTap: () => notifier.setReminderChoice(
              OnboardingReminderChoice.disabled,
            ),
          ),
          if (state.reminderChoice == OnboardingReminderChoice.enabled) ...[
            const SizedBox(height: RhythmSpacing.m),
            _SelectionCard(
              title: l10n.onboardingReminderLeadLabel,
              child: Wrap(
                spacing: RhythmSpacing.s,
                runSpacing: RhythmSpacing.s,
                children: _reminderLeadOptions
                    .map(
                      (minutes) => ChoiceChip(
                        label: Text(
                          l10n.onboardingReminderLeadOption(minutes),
                        ),
                        selected: state.reminderLeadMinutes == minutes,
                        onSelected: (_) => notifier.setReminderLeadMinutes(
                          minutes,
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ],
        ];
    }
  }
}

class _ActivationStepHeader extends StatelessWidget {
  const _ActivationStepHeader({required this.step});

  final OnboardingActivationStep step;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final steps = OnboardingActivationStep.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingStepCounter(step.index + 1, steps.length),
          style: RhythmTextStyles.pageMeta,
        ),
        const SizedBox(height: RhythmSpacing.m),
        Row(
          children: steps
              .map(
                (item) => Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(
                      right: item == steps.last ? 0 : RhythmSpacing.s,
                    ),
                    decoration: BoxDecoration(
                      color: item.index <= step.index
                          ? RhythmColors.brandPrimary
                          : RhythmColors.borderSubtle,
                      borderRadius: BorderRadius.circular(RhythmRadius.pill),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RhythmRadius.card),
        side: BorderSide(
          color: selected
              ? RhythmColors.brandPrimary
              : RhythmColors.borderSubtle,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(RhythmRadius.card),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(RhythmSpacing.l),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: RhythmTextStyles.cardTitle),
                    const SizedBox(height: RhythmSpacing.s),
                    Text(body, style: RhythmTextStyles.body),
                  ],
                ),
              ),
              const SizedBox(width: RhythmSpacing.m),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected
                    ? RhythmColors.brandPrimary
                    : RhythmColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(RhythmSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: RhythmTextStyles.cardTitle),
            const SizedBox(height: RhythmSpacing.m),
            child,
          ],
        ),
      ),
    );
  }
}

String _continueLabel(
  AppLocalizations l10n,
  OnboardingActivationStep step,
) {
  if (step == OnboardingActivationStep.reminders) {
    return l10n.onboardingFinishAction;
  }

  return l10n.onboardingContinueAction;
}

String _resolveCopy(AppLocalizations l10n, String key) {
  switch (key) {
    case 'onboardingCompletionFailedMessage':
      return l10n.onboardingCompletionFailedMessage;
    case 'onboardingHealthDeferredMessage':
      return l10n.onboardingHealthDeferredMessage;
    case 'onboardingReminderDeferredMessage':
      return l10n.onboardingReminderDeferredMessage;
    default:
      return key;
  }
}

String _formatHour(int hour) {
  final normalized = hour % 24;
  final suffix = normalized >= 12 ? 'PM' : 'AM';
  final twelveHour = normalized % 12 == 0 ? 12 : normalized % 12;
  return '$twelveHour:00 $suffix';
}
