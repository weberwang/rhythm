import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_page_hero.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_page_scaffold.dart';

/// 首次引导页面骨架，统一承接 Hero、主体内容和底部动作区。
class OnboardingStepScaffold extends StatelessWidget {
  /// 创建统一引导骨架。
  const OnboardingStepScaffold({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.content,
    required this.primaryAction,
    this.secondaryAction,
    this.footer,
  });

  /// 顶部眉标文案。
  final String eyebrow;

  /// 主标题。
  final String title;

  /// 辅助说明。
  final String description;

  /// 页面主体内容。
  final Widget content;

  /// 主操作按钮。
  final Widget primaryAction;

  /// 次操作按钮。
  final Widget? secondaryAction;

  /// 底部补充提示。
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return RhythmPageScaffold(
      backgroundColor: const Color(0xFFF5F3EE),
      hero: RhythmPageHero(
        eyebrow: eyebrow,
        title: title,
        description: description,
      ),
      body: content,
      // 保持 footer -> secondaryAction -> primaryAction 的承载顺序，避免各 step 底部层级跑偏。
      footer: footer,
      secondaryAction: secondaryAction,
      primaryAction: primaryAction,
    );
  }
}
