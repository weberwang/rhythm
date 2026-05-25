import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/preferences/application/app_preferences_providers.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Rhythm 应用根组件，统一挂载路由和全局主题。
class RhythmApp extends HookConsumerWidget {
  const RhythmApp({super.key});

  /// 构建应用根节点，保持入口文件只负责启动而不承载业务逻辑。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final router = useMemoized(createAppRouter);

    return MaterialApp.router(
      locale: locale,
      // 应用标题依赖 Locale，需要在本地化上下文建立后通过回调读取。
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // 语言列表保持和 ARB 文件一致，避免生成资源后运行期无法选择对应语言。
      supportedLocales: AppLocalizations.supportedLocales,
      // 主题或语言切换会触发根组件重建，但路由实例必须稳定，避免当前导航栈被重置。
      routerConfig: router,
    );
  }
}
