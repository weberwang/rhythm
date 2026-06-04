# Module Map

## Primary Modules

- `foundation-shell`: `app-shell，优先为全局路由、启动分发、tab shell 与全局 overlay 预留宿主`
- `foundation-data`: `sleep-data-core，优先为 Drift、本地优先数据契约、同步队列与共享状态提供基线`
- `activation`: `onboarding-activation，承接匿名/登录、健康授权、目标设置与提醒策略入口`
- `daily-experience`: `today、bedtime、calendar、profile-settings，可在共享壳层与共享数据契约稳定后并行推进`
- `history-review`: `insights，依赖历史数据沉淀与恢复计划结果，适合在核心闭环稳定后接入`

## Ownership Rules

- `presentation` owns pages, widgets, and UI interaction only
- `application` owns use cases, orchestration, and provider exposure
- `infrastructure` owns DTOs, data sources, repository implementations, and external SDK integration
- `domain` owns entities, value objects, and repository contracts

## Extension Rules

- Prefer extending an existing module when the new task shares the same business language and lifecycle.
- Create a new bounded module when the task introduces a distinct business capability, ownership boundary, or dependency cluster.
- Document cross-module collaboration explicitly instead of creating hidden imports.
