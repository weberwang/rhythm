import 'package:flutter/material.dart';

/// 提供应用内统一的低强调次按钮，保证 onboarding 的辅助动作风格一致。
class RhythmSecondaryButton extends StatelessWidget {
  /// 创建次按钮实例。
  const RhythmSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  /// 按钮文案。
  final String label;

  /// 点击回调。
  final VoidCallback? onPressed;

  /// 渲染次按钮。
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
