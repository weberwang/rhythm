import 'package:flutter/material.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';

/// 统一承载二级页的返回按钮与标题，确保返回语义和视觉层级保持一致。
class SecondaryPageHeader extends StatelessWidget {
  /// 创建二级页头。
  const SecondaryPageHeader({
    super.key,
    required this.title,
    required this.fallbackLocation,
    this.titleStyle,
    this.trailing,
  });

  /// 当前页标题。
  final String title;

  /// 没有返回栈时的兜底路由。
  final String fallbackLocation;

  /// 可选标题样式。
  final TextStyle? titleStyle;

  /// 可选尾部区域。
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        InkWell(
          onTap: () => context.popSecondaryOrGo(fallbackLocation),
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xFFD5DFCE)),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color(0xFF1B3A28),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style:
                titleStyle ??
                textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Funnel Sans',
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 12), trailing!],
      ],
    );
  }
}
