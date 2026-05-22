import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Rhythm 应用根组件，统一挂载路由和全局主题。
class RhythmApp extends StatelessWidget {
  const RhythmApp({super.key});

  /// 构建应用根节点，保持入口文件只负责启动而不承载业务逻辑。
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rhythm',
      theme: AppTheme.light(),
      routerConfig: createAppRouter(),
    );
  }
}
