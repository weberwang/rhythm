import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/app_provider_observer.dart';
import '../rhythm_app.dart';

/// 执行应用初始化装配，并挂载全局 Riverpod 作用域。
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: const [AppProviderObserver()],
      child: const RhythmApp(),
    ),
  );
}
