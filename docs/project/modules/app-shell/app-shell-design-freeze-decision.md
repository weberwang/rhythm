# app-shell Design Freeze Decision

## 决策信息

- freeze_target：`module_impl_prep`
- module_name：`app-shell`
- freeze_decision：`frozen_module_for_architecture`
- high_fidelity_freeze_status：`passed`
- review_requirement_status：`explicit_user_approval_recorded`
- approval_basis：
  - 用户已明确确认共享设计主线与最终效果图
  - 当前模块已在显式 `--preview` 下生成模块级静态预览证据

## 审核依据

- [app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md)
- [app-shell.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.impl.md)
- [app-shell.design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.design-source-packet.md)
- [app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
- [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)
- [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)

## 通过项

- 页面范围、导航入口、启动分发、tab shell 与深链承接都已明确。
- `app-shell` 的 scroll/list/overlay/layout/sticky 语义已明确，不再依赖截图猜测。
- 全局共享组件与模块内冻结组件边界已明确。
- 已有模块级静态预览证据，且能支持高保真关键区域判断。
- fidelity-critical regions 与 region classification 已落在模块设计源包中。
- 根路由契约、redirect 决策表、状态拥有权与测试范围已明确到架构可消费粒度。

## immutable_items

- 全局 bottom tab bar 是唯一 root-shell 导航宿主。
- startup gate 必须保持单焦点 loading/error/retry 结构。
- deep-link handoff 必须保持 resolving / blocked 回退语义。
- 全局 overlay host 的优先级顺序不可被 feature 模块私自改写。

## allowed_engineering_adjustments

- loading 指示器动画实现方式
- overlay 进入/退出时长
- 图标库与具体 icon glyph
- 极轻环境光感和柔光退化

## next_skill

- `flutter-uiux-to-architecture`

## approval_record

- shared/global freeze 已通过
- app-shell 模块 freeze 已通过，可进入架构映射阶段
