import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/providers/today_snapshot_provider.dart';
import '../widgets/today_dashboard_content.dart';
import '../widgets/today_dashboard_states.dart';
import '../widgets/today_quick_record_sheet.dart';
import '../widgets/today_dashboard_style.dart';

/// 今日页负责承接“昨晚怎么样 / 今晚做什么”的首屏判断。
class TodayPage extends HookConsumerWidget {
  /// 创建今日页。
  const TodayPage({super.key});

  /// 今日页路由路径。
  static const String routePath = '/today';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotAsync = ref.watch(todaySnapshotProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              TodayDashboardStyle.pageTopTint,
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -90,
              left: -48,
              child: _BackdropGlow(
                size: 240,
                color: TodayDashboardStyle.headerGlow,
              ),
            ),
            const Positioned(
              top: 120,
              right: -70,
              child: _BackdropGlow(
                size: 220,
                color: TodayDashboardStyle.secondaryGlow,
              ),
            ),
            SafeArea(
              child: snapshotAsync.when(
                data: (snapshot) => TodayDashboardContent(
                  snapshot: snapshot,
                  onQuickRecordTap: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    builder: (context) => TodayQuickRecordSheet(
                      tonightGoal: snapshot.tonightGoal,
                    ),
                  ),
                ),
                loading: () => const TodayDashboardLoadingState(),
                error: (_, _) => const TodayDashboardErrorState(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 轻量背景光斑只服务页面氛围，不改变卡片层级语义。
class _BackdropGlow extends StatelessWidget {
  /// 创建背景光斑。
  const _BackdropGlow({required this.size, required this.color});

  /// 光斑尺寸。
  final double size;

  /// 光斑颜色。
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
