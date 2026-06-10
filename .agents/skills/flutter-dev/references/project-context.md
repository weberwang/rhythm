# Project Context

## Product Summary

- Project name: `Rhythm`
- Goal: `构建本地优先、行为闭环导向的作息管理 Flutter 应用，帮助长期晚睡用户完成“今晚提醒 -> 睡前收尾 -> 次日反馈 -> 恢复建议 -> 周复盘”链路。`
- Target users: `长期晚睡但愿意主动调整节律的移动端用户，首发以 iOS 真机用户为主。`
- Package id: `com.example.rhythm`
- Supported platforms: `Android, iOS, macOS, Linux, Windows, Web`

## Delivery Scope

- First release scope: `app-shell, onboarding-activation, sleep-data-core, today, bedtime, calendar, insights, profile-settings 的目录级与后续 bootstrap-ready 骨架。`
- Out of scope: `当前初始化阶段不实现真实 app shell、启动 wiring、业务页面、状态机和 feature 行为。`
- Key integrations: `health, flutter_local_notifications, home_widget, flutter_secure_storage, shared_preferences, drift, Supabase, purchases_flutter`

## Environments

- Environments: `单环境 baseline`
- Flavor or config strategy: `初始化阶段先采用单环境基线；如后续引入多环境，必须在 app/bootstrap 与 core/config 统一扩展`
- Secrets handling: `敏感信息不入仓库；运行时 secrets 通过本地环境或平台配置注入`

## Commands

- Fetch dependencies: `flutter pub get`
- Generate code: `dart run build_runner build --delete-conflicting-outputs`
- Analyze: `flutter analyze`
- Test: `flutter test`
- Run app: `flutter run`
