import 'package:flutter/material.dart';

/// 统一主流程页面的显示层骨架，约束滚动内容区和固定底部动作区。
class RhythmPageScaffold extends StatelessWidget {
  /// 创建共享页面骨架。
  const RhythmPageScaffold({
    super.key,
    required this.hero,
    required this.body,
    required this.primaryAction,
    required this.backgroundColor,
    this.secondaryAction,
    this.footer,
    this.padding = const EdgeInsets.fromLTRB(20, 16, 20, 24),
  });

  /// 顶部 Hero 区域。
  final Widget hero;

  /// 页面正文内容。
  final Widget body;

  /// 固定在底部的主操作。
  final Widget primaryAction;

  /// 固定在主操作上方的次操作。
  final Widget? secondaryAction;

  /// 固定在动作区上方的补充内容。
  final Widget? footer;

  /// 页面背景色。
  final Color backgroundColor;

  /// 页面安全区内边距。
  final EdgeInsets padding;

  /// 构建共享页面骨架。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [hero, const SizedBox(height: 18), body],
                  ),
                ),
              ),
              ..._buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  /// 统一拼装固定底部动作区，避免各页面重复处理间距规则。
  List<Widget> _buildBottomActions() {
    final widgets = <Widget>[const SizedBox(height: 12)];

    if (footer != null) {
      widgets.add(footer!);
      widgets.add(const SizedBox(height: 12));
    }

    if (secondaryAction != null) {
      widgets.add(secondaryAction!);
      widgets.add(const SizedBox(height: 12));
    }

    widgets.add(primaryAction);
    return widgets;
  }
}
