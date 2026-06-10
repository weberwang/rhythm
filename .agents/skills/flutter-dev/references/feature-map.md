# Feature Map

## Primary Features

- `app_shell`: `应用入口、底部导航、启动分发、深链与全局 overlay`
- `sleep_data_core`: `睡眠记录、来源标记、补录修正、同步桥与基础聚合`
- `today`: `今日首页、睡眠窗口、wind-down、recovery 与周摘要`
- `bedtime`: `睡前模式、步骤执行、状态提交与提醒承接`
- `calendar`: `热力图、单日详情、趋势浏览`
- `insights`: `周报、稳定度、恢复趋势、付费承接`
- `onboarding_activation`: `首启引导、授权、目标设置、提醒设置`
- `profile_settings`: `账户、同步、隐私、通知、小组件、订阅设置`

## Ownership Rules

- `presentation` owns pages, widgets, and UI interaction only
- `application` owns use cases, orchestration, and provider exposure
- `infrastructure` owns DTOs, data sources, repository implementations, and external SDK integration
- `domain` owns entities, value objects, and repository contracts

## Extension Rules

- Prefer extending an existing feature when the new task shares the same business language and lifecycle.
- Create a new bounded feature when the task introduces a distinct business capability, ownership boundary, or dependency cluster.
- Document cross-feature collaboration explicitly instead of creating hidden imports.
