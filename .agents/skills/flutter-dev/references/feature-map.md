# Feature Map

## Primary Features

- `app-shell`: `启动分发、根路由、五标签主壳、通知/小组件入口统一归一`
- `sleep-data-core`: `目标作息、睡眠记录、结构化存储、同步队列与共享数据契约`
- `onboarding-activation`: `首次激活漏斗、健康授权、目标设置、提醒与小组件引导`
- `today`: `昨晚结果、今晚目标、恢复建议、快捷记录与趋势入口`
- `bedtime`: `睡前模式、状态选择、轻量收尾动作与通知承接`
- `calendar`: `月历热力图、筛选、单日详情与补录解释`
- `profile-settings`: `账户、会员、同步、提醒、隐私与小组件配置`
- `insights`: `周报、稳定度、原因分布、恢复效果与高级报告入口`

## Ownership Rules

- `presentation` owns pages, widgets, and UI interaction only
- `application` owns use cases, orchestration, and provider exposure
- `infrastructure` owns DTOs, data sources, repository implementations, and external SDK integration
- `domain` owns entities, value objects, and repository contracts

## Extension Rules

- Prefer extending an existing feature when the new task shares the same business language and lifecycle.
- Create a new bounded feature when the task introduces a distinct business capability, ownership boundary, or dependency cluster.
- Document cross-feature collaboration explicitly instead of creating hidden imports.
