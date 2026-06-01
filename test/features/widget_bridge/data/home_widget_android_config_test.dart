import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

/// 约束 Android 小组件 Provider 的 Dart 常量、Manifest 注册与原生实现保持一致，
/// 避免再次出现 `home_widget` 反射类名时找不到 Provider 的运行时错误。
void main() {
  test('Android 小组件 Provider 配置保持一致', () async {
    final repositoryRoot = Directory.current.path;
    final gatewayFile = File(
      path.join(
        repositoryRoot,
        'lib',
        'features',
        'widget_bridge',
        'data',
        'home_widget_gateway.dart',
      ),
    );
    final manifestFile = File(
      path.join(
        repositoryRoot,
        'android',
        'app',
        'src',
        'main',
        'AndroidManifest.xml',
      ),
    );
    final providerFile = File(
      path.join(
        repositoryRoot,
        'android',
        'app',
        'src',
        'main',
        'kotlin',
        'com',
        'example',
        'rhythm',
        'RhythmHomeWidgetProvider.kt',
      ),
    );
    final providerInfoFile = File(
      path.join(
        repositoryRoot,
        'android',
        'app',
        'src',
        'main',
        'res',
        'xml',
        'rhythm_home_widget_info.xml',
      ),
    );

    expect(await gatewayFile.exists(), isTrue);
    expect(await manifestFile.exists(), isTrue);
    expect(await providerFile.exists(), isTrue);
    expect(await providerInfoFile.exists(), isTrue);

    final gatewayContent = await gatewayFile.readAsString();
    final manifestContent = await manifestFile.readAsString();
    final providerContent = await providerFile.readAsString();

    expect(
      gatewayContent,
      contains("_androidWidgetName = 'RhythmHomeWidgetProvider'"),
    );
    expect(
      manifestContent,
      contains('android:name=".RhythmHomeWidgetProvider"'),
    );
    expect(
      manifestContent,
      contains('es.antonborri.home_widget.action.LAUNCH'),
    );
    expect(
      manifestContent,
      contains('@xml/rhythm_home_widget_info'),
    );
    expect(
      providerContent,
      contains('class RhythmHomeWidgetProvider : HomeWidgetProvider()'),
    );
  });
}
