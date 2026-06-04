# Feature Map

## Primary Features

- `app-shell`: `负责启动分发、根路由、五标签主壳层、通知或小组件入口的统一落点`
- `sleep-data-core`: `负责作息目标、睡眠记录、同步队列、恢复计划与共享数据语义的最小业务内核`
- `onboarding-activation`: `负责首次激活漏斗，包括登录、授权、目标设置、提醒设置和桌面入口引导`
- `today`: `负责今日首页、昨晚结果、今晚目标、恢复建议与快捷记录`
- `bedtime`: `负责睡前模式、提醒进入后的聚焦体验和轻收尾动作`
- `calendar`: `负责热力图、筛选、单日详情与历史回顾`
- `insights`: `负责周报、稳定度解释、原因分布、恢复效果与高意图转化入口`
- `profile-settings`: `负责账号、会员、同步、目标、提醒、主题、隐私与数据入口`

## Ownership Rules

- `presentation` owns pages, widgets, and UI interaction only
- `application` owns use cases, orchestration, and provider exposure
- `infrastructure` owns DTOs, data sources, repository implementations, and external SDK integration
- `domain` owns entities, value objects, and repository contracts

## Extension Rules

- Prefer extending an existing feature when the new task shares the same business language and lifecycle.
- Create a new bounded feature when the task introduces a distinct business capability, ownership boundary, or dependency cluster.
- Document cross-feature collaboration explicitly instead of creating hidden imports.
