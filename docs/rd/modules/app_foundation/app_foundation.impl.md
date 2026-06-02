# app_foundation 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/app_foundation/app_foundation.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`pen_ready`

## 1. 业务能力与边界

提供全局启动、路由、主题、国际化、共享展示组件和分析网关基础，并负责把 `pen/v3.pen` 中的基础显示层语义沉淀成 Flutter 可复用组件。不负责具体业务规则、健康数据、会员策略或同步逻辑。

## 2. 继承包栈

- `go_router`
- `hooks_riverpod` / `flutter_riverpod`
- `riverpod_annotation`
- `flutter_localizations` + `intl`
- `shared_preferences`
- `package_info_plus`

## 3. 领域与应用状态

该模块原则上不建立业务领域模型。可维护：

- 启动分发状态
- onboarding 完成轻量标记
- 应用偏好状态
- 分析事件网关接口

## 4. 基础设施边界

- `app/bootstrap` 负责全局初始化和启动协调。
- `app/router` 负责路由树和入口分发。
- `app/theme` 与 `shared/presentation` 负责视觉基础。
- 分析网关先使用可替换接口，生产 SDK 接入由 `analytics_release` 决定。

当前实现收口要求：

- 页面壳、Hero、表面卡片、按钮、反馈组件要明确唯一归属。
- 共享视觉主线优先沉淀在 `shared/presentation`，`core/presentation` 保留更偏框架级、非业务样式依赖的容器能力。
- 若现有组件职责重叠，先通过设计冻结确认主线，再做结构收口。

## 5. 数据与安全

- onboarding 完成、语言、主题等轻量偏好可用 `shared_preferences`。
- 敏感凭据不得进入本模块。
- 日志不得输出健康数据原文。

## 6. 测试范围

- 启动分发测试
- 路由守卫测试
- 国际化挂载测试
- 主题与共享组件 widget 测试
- 全局轻提示和弹层壳测试

## 7. 实现约束

- 不修改业务模块内部状态机。
- 不把业务文案写入共享组件。
- 不让共享组件直接依赖 feature。
- 不再引用 `pen/app.pen` 或 `pen/new-app.pen` 作为实现依据，本模块唯一设计源为 `pen/v3.pen`。
- 实现前如涉及既有类或方法，必须按 GitNexus 规则先做影响分析。
