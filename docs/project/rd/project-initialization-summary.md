# Rhythm Project Initialization Summary

## 初始化范围

本次仅完成 `flutter-init` 边界内的目录与技能骨架初始化，不包含：

- 真实 `main.dart`
- 真实 root router
- 真实 app shell 运行时实现
- 真实 provider/bootstrap wiring
- 任何 feature 页面或业务状态实现

## 已初始化内容

- 新建 `lib/` 目录骨架：
  - `lib/app`
  - `lib/core`
  - `lib/shared`
  - `lib/features`
- 按 DDD-by-feature 建立首批 feature 目录：
  - `app_shell`
  - `onboarding_activation`
  - `sleep_data_core`
  - `today`
  - `bedtime`
  - `calendar`
  - `insights`
  - `profile_settings`
- 生成项目级 [flutter-dev](/E:/Projects/flutter/rhythm/skills/flutter-dev/SKILL.md) 技能与 references
- 在 [pubspec.yaml](/E:/Projects/flutter/rhythm/pubspec.yaml) 补齐 `flutter_screenutil: ^5.9.3`

## 插件与依赖处理

- 本次未传 `--force`
- 当前平台工程、依赖声明和基础插件配置已存在，因此未重复覆盖 native/plugin 配置
- 本次只对依赖基线做最小补充，不新增运行时 wiring
- `flutter_screenutil: ^5.9.3` 已补入 [pubspec.yaml](/E:/Projects/flutter/rhythm/pubspec.yaml)

## 验证结果

- `flutter pub get`：通过
- `flutter analyze`：通过
- `flutter test`：通过（当前仅执行初始化骨架占位测试）

## 当前哪些内容只是骨架

- `lib/app/**`
- `lib/core/**`
- `lib/shared/**`
- `lib/features/**`

这些目录当前只用于锁定职责边界与后续文件落点，不承载可运行产品行为。

## 留给后续阶段的内容

- `bootstrap code`：真实入口、root router、provider scope、error/logging/storage bootstrap
- `app-shell` 实现：根壳层、tab shell、overlay host、startup gate
- 各 feature 的页面、状态、仓储和平台桥接

## 仍待确认项

- 匿名升级登录后的 tab 栈恢复策略
- bedtime deep link 的 tab 高亮策略
- 全局 overlay 是否需要队列化展示策略
- 订阅权益快照与服务端校验最终策略

## 下一步优先顺序

1. `bootstrap code`
2. `app-shell`
3. `sleep-data-core`
4. `onboarding-activation`
5. `today`
