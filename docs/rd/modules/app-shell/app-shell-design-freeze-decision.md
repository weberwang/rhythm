# app-shell 模块设计冻结决议

> 产物类型：`module_design_freeze_decision`
> 模块：`app-shell`
> 日期：`2026-06-08`
> 评审目标：`module_impl_prep`
> 上游输入：
> - `docs/rd/modules/app-shell/app-shell.ui-ux.md`
> - `docs/rd/modules/app-shell/app-shell.impl.md`
> - `docs/rd/modules/app-shell/app-shell.pencil-design-source-packet.md`
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`

## 1. 冻结结论

- `freeze_decision`: `frozen_module_for_architecture`
- `high_fidelity_freeze_status`: `passed`
- `review_requirement_status`: `passed`
- `next_skill`: `flutter-uiux-to-architecture`

本次评审结论为：`app-shell` 的模块设计源包已经达到模块冻结条件，可以在确认后进入架构映射阶段。

## 2. 评审依据

### 2.1 模块合同完整性

已具备：

- 活动模块名：`app-shell`
- 配对 UI/UX RD：`docs/rd/modules/app-shell/app-shell.ui-ux.md`
- 配对实现 RD：`docs/rd/modules/app-shell/app-shell.impl.md`
- 模块级 Pencil 设计源包：`docs/rd/modules/app-shell/app-shell.pencil-design-source-packet.md`

### 2.2 共享冻结继承

已继承：

- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`
- `docs/rd/shared-design-freeze-decision.md`

### 2.3 页面层级与任务引导

已明确：

- 壳层的首要任务是“正确进入目的地并稳定承载顶层壳层”
- 底部导航属于共享壳层，不是页面主 CTA
- 全局横幅只处理跨模块问题，不可压过 feature 主任务
- 启动恢复态与来源降级路径都已显式化，不再依赖文字猜测

### 2.4 高保真视觉合同

本轮优先通过并锁定了以下高保真区域：

- 共享底部导航
- 状态栏与安全区关系
- 壳层激活态中“状态栏 -> 全局横幅 -> 内容宿主 -> 底部导航”的垂直层级
- 启动恢复态的信息结构与恢复路径

评估结果：

- `preserve_faithfully`
  - 底部导航结构、层级、激活态语义
  - 状态栏与安全区关系
  - 横幅与主内容的优先级关系
- `flutterize`
  - 启动恢复态轻动画
  - 来源标记显隐
  - 横幅关闭反馈
- `simplify`
  - `none`

### 2.5 模块私有组件冻结

已具备模块级组件冻结候选：

- 壳层脚手架
- 顶层目的地切换器
- 全局状态横幅
- 启动等待层
- 来源标记条

这些组件已明确：

- 用途范围
- 状态/变体
- 复用边界
- 是否必须冻结

### 2.6 状态矩阵

已覆盖：

- `ideal`
- `loading`
- `empty`
- `error`
- `permission`
- `partial_data`
- `disabled`
- `success`

说明：

- `app-shell` 不承载 `premium_locked` 作为主状态
- 模块级状态覆盖已满足壳层实现准备要求

### 2.7 视觉证据与结构校验

已具备：

- 模块草图页：`VRrsM`
- 模块导出图：
  - `docs/rd/modules/app-shell/pencil-exports/VRrsM.png`
  - `docs/rd/modules/app-shell/pencil-exports/OkwbA.png`
  - `docs/rd/modules/app-shell/pencil-exports/qs9oz.png`

校验结果：

- `snapshot_layout(problemsOnly=true)`：`No layout problems.`
- 模块级草图页截图可读，无塌布局、无可见裁切

## 3. missing_items

- `none`

## 4. required_artifacts

- `docs/rd/modules/app-shell/app-shell.ui-ux.md`
- `docs/rd/modules/app-shell/app-shell.impl.md`
- `docs/rd/modules/app-shell/app-shell.pencil-design-source-packet.md`
- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`

## 5. immutable_items

- 五个顶层 tab 的顺序、名称和主语义不可改
- 底部导航属于壳层，不是页面主角
- 全局横幅不可压过 feature 主任务
- 启动恢复与来源降级必须给用户一条安全继续路径
- feature 内容宿主与壳层责任边界不可在实现阶段被重新解释

## 6. allowed_engineering_adjustments

- 启动恢复态轻动画可在 Flutter 中工程化实现
- 来源标记显隐与横幅关闭反馈可做轻交互化处理
- 轻投影与材质感可在不破坏层级关系前提下适度弱化

## 7. approval_record

- 用户确认记录：
  - `确认`
  - `确认并推进`
- 确认日期：
  - `2026-06-08`
- 结论：
  - `app-shell` 模块文档与模块级 Pencil 设计源已获显式继续推进授权

## 8. 进入下一阶段的边界

本次冻结授予：

- 进入 `flutter-uiux-to-architecture`
- 将 `app-shell` 标记为 `module_design_frozen` 候选
- 将 `app-shell.design_source_status` 提升为 `frozen` 候选
- 由于 `app-shell.impl.md` 已显式引用冻结后的模块级设计源包，也允许将 `app-shell.impl_status` 提升为 `landed` 候选

本次冻结不授予：

- 直接进入代码实现
- 绕过架构映射阶段
- 在实现阶段重新解释导航语义、横幅层级或来源降级规则
