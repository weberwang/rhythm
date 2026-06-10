# Decision Log

## Base Decisions

| Area | Decision | Reason | Impact |
| --- | --- | --- | --- |
| State | `flutter_riverpod + hooks_riverpod + riverpod_annotation` | `仓库与工作流都已强约束 hooks + Riverpod 作为唯一状态基线。` | `后续 provider、视图状态与依赖注入统一走注解生成，不引入第二套状态系统。` |
| Routing | `go_router root shell + feature branch ownership` | `app-shell 已冻结为根导航宿主，适合管理 tab、redirect 与 deep link。` | `后续 feature 只能暴露 branch，不再自建根级导航真相源。` |
| Network | `dio + retrofit baseline, Supabase SDK for auth/sync` | `既满足自定义远端契约，也保留 Supabase 账号与同步能力。` | `后续 remote contract 统一进 infrastructure adapter，不在页面层直接接 SDK。` |
| Storage | `drift + flutter_secure_storage + shared_preferences` | `匹配结构化业务数据、敏感凭据与轻量偏好的分层规则。` | `后续 feature 按边界消费对应存储，不混用 key-value 充当主数据库。` |

## Change Records

Append new rows when the project deliberately changes or extends the initialized baseline.
