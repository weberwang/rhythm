# Project Context

## Product Summary

- Project name: `Rhythm`
- Goal: `构建一个本地优先的作息行为管理应用，用稳定的日常闭环帮助用户更早入睡、理解偏移原因并逐步恢复节奏`
- Target users: `20-35 岁长期晚睡、需要低负担行为反馈的用户，包括远程办公、跨时区与轮班人群`
- Package id: `rhythm`
- Supported platforms: `iOS, Android, Web, macOS, Windows, Linux`

## Delivery Scope

- First release scope: `app-shell、sleep-data-core、onboarding-activation、today、bedtime、calendar、insights、profile-settings 八个模块按阶段落地`
- Out of scope: `医疗诊断、社区打卡、硬件联动、首发 AI 聊天教练`
- Key integrations: `Supabase、HealthKit/Health Connect、flutter_local_notifications、timezone、flutter_secure_storage、shared_preferences、home_widget、purchases_flutter`

## Environments

- Environments: `local, staging, production`
- Flavor or config strategy: `先用编译期环境变量承接 Supabase 等远端配置，后续如有多 flavor 需求再扩展 native 配置层`
- Secrets handling: `敏感密钥不入仓，统一通过 --dart-define 或平台安全配置注入`

## Commands

- Fetch dependencies: `flutter pub get`
- Generate code: `dart run build_runner build --delete-conflicting-outputs && flutter gen-l10n`
- Analyze: `flutter analyze`
- Test: `flutter test`
- Run app: `flutter run`
