# Plugin Rules

## Force Switch

- `--force` 表示：对当前任务范围内的插件接入做刷新式重配，然后再继续后续步骤
- 未传 `--force` 且插件接入缺失时：执行首轮插件配置
- 未传 `--force` 且插件接入已存在时：保持现状，不要在普通业务任务里顺手重配原生层

## Project Plugin Inventory

- 核心插件集合：`drift`、`shared_preferences`、`flutter_secure_storage`、`path_provider`、`uuid`、`intl`
- 平台敏感插件：`health`、`flutter_local_notifications`、`flutter_timezone`、`home_widget`、`google_sign_in`、`sign_in_with_apple`、`purchases_flutter`、`device_info_plus`、`package_info_plus`
- 云端或控制台依赖插件：`supabase_flutter`、`purchases_flutter`、`google_sign_in`、`sign_in_with_apple`

## Reconfigure Notes

- 重配范围：健康权限、通知、小组件、登录、订阅、Supabase 启动配置及其对应的原生入口
- 常见受影响文件：`android/app/build.gradle.kts`、`android/app/src/main/AndroidManifest.xml`、`ios/Runner/Info.plist`、`ios/Runner.xcodeproj/project.pbxproj`、`macos/Runner/Info.plist`、`macos/Runner/Configs/AppInfo.xcconfig`、`lib/app/bootstrap/app_bootstrap.dart`、`lib/app/bootstrap/supabase_bootstrap.dart`
- 重配后验证：`flutter pub get`、`flutter gen-l10n`、`dart run build_runner build --delete-conflicting-outputs`、`flutter analyze`、`flutter test`

## Usage Rules

- 插件能力只暴露一个项目内适配入口，不要让多个页面直接持有同一个三方插件实例
- 涉及权限、初始化、失败重试或降级策略时，优先集中在 bootstrap 或 feature `data/` 层处理
- 需要真机能力验证的插件改动，除了跑命令校验，还要记录至少一条设备侧验证结论
