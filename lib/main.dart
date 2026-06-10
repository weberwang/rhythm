import 'package:flutter/widgets.dart';

import 'app/entry/rhythm_bootstrap_app.dart';

/// 应用主入口。
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RhythmBootstrapApp());
}
