// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rhythm/app/entry/rhythm_bootstrap_app.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('应用可完成 bootstrap 并进入 today 路由', (tester) async {
    SharedPreferences.setMockInitialValues({
      AppShellLaunchStateStore.onboardingCompletedKey: true,
    });
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform({
      'session_access_token': 'token',
    });

    await tester.pumpWidget(const RhythmBootstrapApp());
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsWidgets);
    expect(find.text('Today feature bootstrap placeholder.'), findsOneWidget);
  });
}
