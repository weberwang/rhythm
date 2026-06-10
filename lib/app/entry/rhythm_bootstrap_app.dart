import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 包裹 ProviderScope 与 ScreenUtil 的根应用。
class RhythmBootstrapApp extends StatelessWidget {
  /// 创建根应用。
  const RhythmBootstrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: const _RhythmAppView(),
    );
  }
}

/// 真正消费 provider 的应用视图。
class _RhythmAppView extends ConsumerWidget {
  /// 创建应用视图。
  const _RhythmAppView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (screenContext, screenChild) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: buildRhythmLightTheme(),
          darkTheme: buildRhythmDarkTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        );
      },
    );
  }
}
