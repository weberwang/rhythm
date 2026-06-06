import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'today_dashboard_primitives.dart';

/// 加载态保留首页主要层级，避免 today 首屏闪成空白。
class TodayDashboardLoadingState extends StatelessWidget {
  /// 创建加载态。
  const TodayDashboardLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
      children: const [
        _LoadingBlock(height: 40, widthFactor: 0.46),
        SizedBox(height: 14),
        _LoadingBlock(height: 24, widthFactor: 0.58),
        SizedBox(height: 26),
        _LoadingCard(height: 286),
        SizedBox(height: 18),
        _LoadingCard(height: 164),
        SizedBox(height: 18),
        _LoadingCard(height: 156),
        SizedBox(height: 18),
        _LoadingCard(height: 112),
        SizedBox(height: 18),
        _LoadingCard(height: 246),
      ],
    );
  }
}

/// 错误态保留最小可解释页面，不把 today 直接打回空白。
class TodayDashboardErrorState extends StatelessWidget {
  /// 创建错误态。
  const TodayDashboardErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        TodaySurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.todayErrorTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                localization.todayErrorBody,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 加载态短块复用同一规则，避免骨架宽高风格漂移。
class _LoadingBlock extends StatelessWidget {
  /// 创建加载块。
  const _LoadingBlock({required this.height, required this.widthFactor});

  /// 加载块高度。
  final double height;

  /// 宽度比例。
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}

/// 加载卡片延续真实卡片材质，避免切换时出现明显闪烁落差。
class _LoadingCard extends StatelessWidget {
  /// 创建加载卡片。
  const _LoadingCard({required this.height});

  /// 加载卡片高度。
  final double height;

  @override
  Widget build(BuildContext context) {
    return TodaySurfaceCard(
      padding: EdgeInsets.zero,
      child: SizedBox(height: height),
    );
  }
}
