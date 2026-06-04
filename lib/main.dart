import 'app/bootstrap/app_bootstrap.dart';

/// 应用主入口，只负责把控制权交给初始化装配层。
Future<void> main() async {
  await bootstrap();
}
