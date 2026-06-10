# Module Map

## Primary Modules

- `app-shell`: `root shell、go_router 分发、底部 tab 宿主、全局 overlay`
- `onboarding-activation`: `首启激活路径与初始配置`
- `sleep-data-core`: `睡眠核心数据域`
- `today`: `主任务首页模块`
- `bedtime`: `晚间执行模块`
- `calendar`: `历史趋势浏览模块`
- `insights`: `洞察与周报模块`
- `profile-settings`: `账户与系统设置模块`

## Ownership Rules

- `presentation` owns pages, widgets, and UI interaction only
- `application` owns use cases, orchestration, and provider exposure
- `infrastructure` owns DTOs, data sources, repository implementations, and external SDK integration
- `domain` owns entities, value objects, and repository contracts

## Extension Rules

- Prefer extending an existing module when the new task shares the same business language and lifecycle.
- Create a new bounded module when the task introduces a distinct business capability, ownership boundary, or dependency cluster.
- Document cross-module collaboration explicitly instead of creating hidden imports.
