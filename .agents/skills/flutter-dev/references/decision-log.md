# Decision Log

## Base Decisions

| Area | Decision | Reason | Impact |
| --- | --- | --- | --- |
| State | `hooks_riverpod + riverpod_annotation + riverpod_generator` | `项目已冻结为 Riverpod 3 Hook 路线，并要求显示层优先用 hooks 组织生命周期与局部状态。` | `后续 Provider、页面状态与副作用都必须走注解 + hooks，避免平行样板风格。` |
| Routing | `GoRouter root gate + StatefulShellRoute indexed stack` | `Rhythm 存在引导、回访、通知/小组件入口与五标签主壳，需要统一根路由裁决。` | `所有根入口、标签切换与后续深链都必须挂到同一路由树。` |
| Network | `Dio + Retrofit baseline, business endpoints deferred until contract freeze` | `当前远端能力主要依赖 Supabase SDK，初始化阶段不能虚构 REST 字段，但仍需保留统一网络宿主。` | `feature 需要新增 REST 契约时必须复用 core/network，而不是各自创建客户端。` |
| Storage | `Drift + SharedPreferences + FlutterSecureStorage` | `项目已冻结为 local-first，既要结构化本地数据，又要隔离轻量标记与敏感信息。` | `页面与应用层不得直接持有三方存储插件实例。` |

## Change Records

| Date | Area | Change | Reason | Impact |
| --- | --- | --- | --- | --- |
| 2026-06-04 | Initialization | `flutter-init` 完成根路由、主题、本地化、数据与技能基线装配 | 工作流记录已推进到 `architecture_ready`，需要进入 `project_initialized` 前置骨架阶段 | 后续模块实现可在统一工程基线上继续推进 |
