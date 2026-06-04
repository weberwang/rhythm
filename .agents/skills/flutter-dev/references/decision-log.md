# Decision Log

## Base Decisions

| Area | Decision | Reason | Impact |
| --- | --- | --- | --- |
| State | `统一使用 flutter_riverpod + riverpod_annotation + hooks_riverpod` | `保持状态组织、依赖注入与显示层生命周期写法一致，减少并行风格` | `后续 Provider、局部状态和副作用都应优先走注解 + Hook 方案` |
| Routing | `go_router 承担 launch -> onboarding | tab-shell 的根路由职责` | `Rhythm 存在首启、回访、提醒进入和小组件入口，必须先统一入口分流` | `业务模块只声明页面与子路径，不自行维护平行导航状态机` |
| Network | `当前初始化阶段只接入 supabase_flutter 启动基线，不额外新增独立 REST API 主链` | `全局 RD 决策是 local-first + optional cloud sync，当前没有额外 REST 契约需要 scaffold` | `后续如出现明确 REST 契约，再补充 dio/retrofit 及对应 owner` |
| Storage | `drift 负责结构化业务数据，flutter_secure_storage 负责敏感数据，shared_preferences 负责轻量偏好` | `需要同时满足本地优先、可修正数据和匿名绑定等多种持久化边界` | `任何模块接入存储时都要先判断数据敏感级别与结构化程度` |

## Change Records

Append new rows when the project deliberately changes or extends the initialized baseline.
