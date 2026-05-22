import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Rhythm 应用根组件，统一挂载路由和全局主题。
class RhythmApp extends StatelessWidget {
  const RhythmApp({super.key});

  /// 构建应用根节点，保持入口文件只负责启动而不承载业务逻辑。
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 应用标题依赖 Locale，需要在本地化上下文建立后通过回调读取。
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // 语言列表保持和 ARB 文件一致，避免生成资源后运行期无法选择对应语言。
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: createAppRouter(),
    );
  }
}
