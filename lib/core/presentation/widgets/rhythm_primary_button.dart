import 'package:flutter/material.dart';

/// 提供应用内统一的高强调主按钮，避免 onboarding 自行分叉按钮样式。
class RhythmPrimaryButton extends StatelessWidget {
  /// 创建主按钮实例。
  const RhythmPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  /// 按钮文案。
  final String label;

  /// 点击回调。
  final VoidCallback? onPressed;

  /// 渲染主按钮。
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
