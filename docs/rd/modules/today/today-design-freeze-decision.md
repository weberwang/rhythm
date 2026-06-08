# today 模块设计冻结决议

> 产物类型：`module_design_freeze_decision`
> 模块：`today`
> 日期：`2026-06-09`
> 评审目标：`module_impl_prep`
> 上游输入：
> - `docs/rd/modules/today/today.ui-ux.md`
> - `docs/rd/modules/today/today.impl.md`
> - `docs/rd/modules/today/today.pencil-design-source-packet.md`
> - `docs/rd/modules/today/pencil-exports/MCgNV.png`
> - `docs/rd/modules/today/today-module-preview.png`
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`
> - `2026-06-09 preview feedback rollback`

## 1. 冻结结论

- `freeze_decision`: `frozen_module_for_architecture`
- `high_fidelity_freeze_status`: `passed`
- `review_requirement_status`: `passed`
- `next_skill`: `flutter-uiux-to-architecture`

本次评审结论为：原 `today` 模块冻结已通过，在用户要求“按效果图优化 today 设计稿”后，模块级 Pencil 真源完成了一次受控回灌修订。  
用户已继续授权推进，因此修订后的高保真合同正式恢复为可进入架构映射阶段的冻结输入。

## 2. 评审依据

### 2.1 模块合同完整性

已具备：

- 活动模块名：`today`
- 配对 UI/UX RD：`docs/rd/modules/today/today.ui-ux.md`
- 配对实现 RD：`docs/rd/modules/today/today.impl.md`
- 模块级 Pencil 设计源包：`docs/rd/modules/today/today.pencil-design-source-packet.md`

### 2.2 共享冻结继承

已继承：

- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`
- `docs/rd/shared-design-freeze-decision.md`

### 2.3 页面层级与任务引导

已明确：

- Today 首屏第一任务是“读懂昨晚结果”
- 今晚目标卡必须位于结果卡之后
- 下一步动作卡必须位于目标卡之后
- 趋势区、付费入口、历史摘要不得抢占首屏主层级
- 模块级效果图只能回灌信息组织、版式张力与 CTA 姿态，不得回灌漂移导航语义

### 2.4 高保真视觉合同

本轮优先通过并锁定了以下高保真区域：

- 结果主卡
- 今晚目标卡
- 下一步动作卡
- 底部导航相对主内容的低刺激姿态

评估结果：

- `preserve_faithfully`
  - 结果主卡的首屏位置、排版重心与层级
  - 结果卡 headline 与第二层支持信息的主次关系
  - 目标卡相对结果卡的位置与语义承接
  - 动作卡的 CTA 对比姿态、右置按钮与层级
- `flutterize`
  - 趋势摘要块的 weekday 状态点阵 / legend 绘制方式
  - 极浅阴影与表面层次的性能化实现
- `simplify`
  - `none`

### 2.5 模块私有组件冻结

已具备模块级组件冻结候选：

- 昨晚结果主卡
- 今晚目标卡
- 下一步动作卡
- 快捷补录入口行
- 7 天趋势摘要块

这些组件已明确：

- 用途范围
- 状态 / 变体
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
- `locked`

说明：

- `today` 的缺失、权限、部分数据、锁定态均已有明确承载位
- 状态覆盖满足进入架构准备前的设计冻结要求

### 2.7 视觉证据与结构校验

已具备：

- Pencil 页面证据：
  - `docs/rd/modules/today/pencil-exports/MCgNV.png`
- 模块级效果图：
  - `docs/rd/modules/today/today-module-preview.png`

校验结果：

- `snapshot_layout(parentId=MCgNV, problemsOnly=true)`：`No layout problems.`
- Pencil 页面证据结构清晰，无塌布局、无裁切
- 修订后的 Pencil 页面已经吸收效果图中对结果卡、目标卡、动作卡和趋势块的信息组织提升
- 模块级效果图的首屏层级基本成立，但底部导航文案存在模型漂移

结论：

- `today-module-preview.png` 仅作为 `supplemental_only` 视觉证据
- 冻结真源仍以 Pencil 设计源包与模块页面导出图为准

## 3. missing_items

- `none`

## 4. required_artifacts

- `docs/rd/modules/today/today.ui-ux.md`
- `docs/rd/modules/today/today.impl.md`
- `docs/rd/modules/today/today.pencil-design-source-packet.md`
- `docs/rd/modules/today/pencil-exports/MCgNV.png`
- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`

## 5. immutable_items

- 结果主卡必须是首屏第一视觉重心
- 目标卡必须位于结果卡之后、动作卡之前
- CTA 必须保持安静邀请型，不得压过结果主卡
- 趋势区、付费入口、历史摘要不得压过结果卡
- Today 不得退回行动优先首页
- Today 不得退回结果报告仪表盘

## 6. allowed_engineering_adjustments

- 趋势摘要块的 weekday 点阵、legend 与低强调状态表达可 Flutter 化
- 极浅阴影、表面层次和轻质感可在不破坏层级前提下弱化
- 字体可映射到同气质系统字体栈，但不能破坏结果卡与正文之间的阅读反差

## 7. approval_record

- 用户确认记录：
  - `确认 today 模块文档`
  - `确认 today 模块设计源包`
  - `继续推进`
- 确认日期：
  - `2026-06-09`
- 结论：
  - `today` 模块文档、修订后的模块级 Pencil 设计源已获显式继续推进授权

## 8. 进入下一阶段的边界

本次修订后授予：

- 保持 `today` 的 `module_design_frozen` 主阶段不变
- 将 `today.design_source_status` 维持在 `frozen` 可消费状态
- 将 `today.impl_status` 维持在 `landed` 可消费状态
- 重新执行 `flutter-uiux-to-architecture`

本次修订后暂不授予：

- 直接进入代码实现
- 绕过新的架构重跑
- 在实现阶段重新解释结果优先层级、CTA 姿态或趋势区权重
