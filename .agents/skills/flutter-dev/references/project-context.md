# Project Context

## Product Summary

- Project name: `Rhythm`
- Goal: `帮助长期晚睡但有调整意愿的用户，以本地优先方式完成“睡前收尾 - 次日理解偏移 - 持续恢复节奏”的闭环`
- Target users: `20-35 岁长期晚睡用户、远程办公人群、跨时区用户与轮班用户`
- Package id: `com.example.rhythm`
- Supported platforms: `Android, iOS, Web, macOS, Windows, Linux`

## Delivery Scope

- First release scope: `app-shell, sleep-data-core, onboarding-activation, today, bedtime, calendar, profile-settings, insights 的初始化与后续分模块实现`
- Out of scope: `医学诊断、社区打卡、硬件联动、首发 AI 聊天教练`
- Key integrations: `Supabase, Health, Flutter Local Notifications, Timezone, Home Widget, Purchases, Google Sign-In, Sign in with Apple`

## Environments

- Environments: `default`
- Flavor or config strategy: `初始化阶段先采用单环境基线；如后续引入多环境，必须在 app/bootstrap 与 core/config 统一扩展`
- Secrets handling: `敏感凭据走 FlutterSecureStorage；远端密钥与平台配置保留在原生配置层，不在页面或 Provider 中硬编码`

## Commands

- Fetch dependencies: `flutter pub get`
- Generate code: `flutter gen-l10n && dart run build_runner build --delete-conflicting-outputs`
- Analyze: `flutter analyze`
- Test: `flutter test`
- Run app: `flutter run`
