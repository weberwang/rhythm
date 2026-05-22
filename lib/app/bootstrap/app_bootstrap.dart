import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../rhythm_app.dart';

/// 启动 Rhythm App，并集中放置后续初始化依赖的入口。
void bootstrapApp() {
  runApp(const ProviderScope(child: RhythmApp()));
}
