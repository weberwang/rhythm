import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rhythm_app.dart';
import 'launch_state_provider.dart';

/// 启动 Rhythm App，并集中放置后续初始化依赖的入口。
Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // 启动阶段先注入持久化依赖，避免在路由分发时重复异步获取实例。
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const RhythmApp(),
    ),
  );
}
