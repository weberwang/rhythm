import 'package:flutter/material.dart';

/// 提醒策略页占位组件，后续用于承接首次激活中的提醒偏好配置。
class ReminderSetupPage extends StatelessWidget {
  const ReminderSetupPage({super.key});

  /// 渲染提醒设置占位内容，避免首次激活扩展时再次打散页面结构。
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('提醒策略设置待接入')));
  }
}
