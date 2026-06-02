import 'package:flutter/material.dart';

/// 提供应用内统一的低强调次按钮，保证辅助动作样式稳定。
class RhythmSecondaryButton extends StatelessWidget {
  /// 创建次按钮实例。
  const RhythmSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.child,
  });

  /// 按钮文案。
  final String label;

  /// 点击回调。
  final VoidCallback? onPressed;

  /// 允许页面承载图标、加载态或自定义内容，避免为扩展展示绕开共享按钮。
  final Widget? child;

  /// 构建次按钮。
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontFamily: 'Geist',
            fontWeight: FontWeight.w600,
          ),
        ),
        child: _buildChild(),
      ),
    );
  }

  /// 优先渲染页面传入的自定义内容，未传入时回退到默认文案。
  Widget _buildChild() {
    return child ?? Text(label);
  }
}
