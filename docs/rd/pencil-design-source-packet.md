# Rhythm Pencil 设计源包

> 产物类型：`pencil_design_source_packet`
> 日期：`2026-06-08`
> 上游方向：`DESIGN.md`
> 共享方向包：`docs/rd/global-design-guidelines.md`
> 适配器：`pencil`
> Pencil 源引用：`docs/rd/app.pen`

## 1. 设计源摘要

本包将已确认的 `DESIGN.md`、共享视觉方向和公共壳层规则，落成一份可进入共享冻结评审的 Pencil 结构化设计源。

当前设计源遵守以下四个全局一致性合同：

- 单一共享风格方向
- 单一共享主题系统
- 单一共享公共壳层
- 单一共享公共组件家族

## 2. 冻结源引用

- `pencil_source_ref`：`docs/rd/app.pen`
- `shared_design_master_packet_id`：`s3gcd`
- `shared_design_master_packet_name`：`Rhythm Shared Design Master`
- `pencil_source_status`：`frozen_for_review`

说明：

- 当前 `.pen` 文件已不再是空文档。
- 已包含共享组件母版与 6 个页面级屏幕。
- 当前源引用已明确，不再处于 `pencil_source_ref` 缺失状态。

## 3. 上游约束继承

当前 Pencil 包明确继承以下上游事实：

- 首发验证面：`ios_device`
- 设计基线：`iOS HIG`
- 方向气质：冷静、编辑感、低压迫、恢复优先
- 公共壳层：`Today / Calendar / Bedtime / Insights / Profile`
- 首页第一任务：今晚行动优先于结果、趋势和商业承接
- 产品语气：非医疗、非惩罚、非打卡

## 4. 共享组件与主题

### 4.1 共享组件

- `Status Bar Component`：`qs9oz`
- `Primary Action Card`：`w4XXe`
- `Summary Card`：`ZjgOl`
- `Recovery Card`：`K3o0m`
- `Shared Tab Bar`：`OkwbA`

### 4.2 主题变量

当前 `.pen` 文件内已冻结的核心变量包括：

- 色彩：
  - `color-primary`
  - `color-on-primary`
  - `color-secondary`
  - `color-surface`
  - `color-surface-container`
  - `color-on-surface`
  - `color-outline`
  - `color-warning`
  - `color-error`
  - `color-success`
- 尺寸：
  - `spacing-xs / sm / md / lg / xl / xxl`
  - `radius-sm / md / lg / full`
- 字体：
  - `font-display`
  - `font-body`
  - `font-caption`
  - `font-data`

### 4.3 本轮高端化优化

本轮基于 `high-end-visual-design` 的高端审美规则，对共享组件做了收敛式优化，但没有偏离 Rhythm 的低压迫、恢复优先和任务清晰原则。

已落地的共享级优化包括：

- 字体从普通中性系统感提升为 `Geist` 主字体系，并用 `IBM Plex Mono / Geist Mono` 承担更精确的标签与数据角色。
- 去掉状态栏容器的廉价描边卡片感，让顶部更像真实系统壳层而不是额外组件。
- 主行动卡、摘要卡、恢复卡统一改为更克制的中大圆角与更轻的高级阴影，不再依赖厚边框支撑层级。
- 底部导航从更软的胶囊感收紧为更克制的悬浮壳层，保留产品感，但减少喧宾夺主。
- 卡片文字层级被重新拉开，增强“看一眼就知道今晚做什么”的首屏任务清晰度。

## 5. 页面清单与页级回执

当前 in-scope 页面共 6 个：

| 页面 | Pencil 节点 ID | 导出 PNG |
| --- | --- | --- |
| `Today Screen` | `MCgNV` | `docs/rd/pencil-exports/MCgNV.png` |
| `Calendar Screen` | `SvlPW` | `docs/rd/pencil-exports/SvlPW.png` |
| `Bedtime Screen` | `N3lMk` | `docs/rd/pencil-exports/N3lMk.png` |
| `Insights Screen` | `OSwll` | `docs/rd/pencil-exports/OSwll.png` |
| `Profile Screen` | `BwvXZ` | `docs/rd/pencil-exports/BwvXZ.png` |
| `Onboarding Screen` | `dMZS3` | `docs/rd/pencil-exports/dMZS3.png` |

### 5.1 Today 页

- 主任务：今晚行动
- 共享组件使用：
  - `Status Bar Component`
  - `Primary Action Card`
  - `Summary Card`
  - `Recovery Card`
  - `Shared Tab Bar`
- 页级结论：符合“行动主卡优先”原则
- 页级状态：`generated`

### 5.2 Calendar 页

- 主任务：查看长期节奏而非被数据压迫
- 共享组件使用：
  - `Status Bar Component`
  - `Summary Card`
  - `Shared Tab Bar`
- 页级结论：以热力图为主体，但避免仪表盘化
- 页级状态：`generated`

### 5.3 Bedtime 页

- 主任务：降低进入睡前模式的阻力
- 共享组件使用：
  - `Status Bar Component`
  - `Primary Action Card`
  - `Recovery Card`
  - `Shared Tab Bar`
- 页级结论：动作驱动、状态选择轻量、单手可达
- 页级状态：`generated`

### 5.4 Insights 页

- 主任务：周报与恢复理解
- 共享组件使用：
  - `Status Bar Component`
  - `Summary Card`
  - `Recovery Card`
  - `Shared Tab Bar`
- 页级结论：保留洞察感，但控制数据密度
- 页级状态：`generated`

### 5.5 Profile 页

- 主任务：账户、权限、同步、会员管理
- 共享组件使用：
  - `Status Bar Component`
  - `Shared Tab Bar`
- 页级结论：安静可信，列表组织清晰
- 页级状态：`generated`

### 5.6 Onboarding 页

- 主任务：先解释价值，再进入权限与设置
- 共享组件使用：
  - `Status Bar Component`
  - `Primary Action Card`
- 页级结论：无底部壳层，保留价值优先的引导结构
- 页级状态：`generated`

## 6. 任务层级与 CTA 规则

当前 Pencil 包显式保留以下任务层级：

1. 今晚行动
2. 昨晚结果摘要
3. 恢复建议
4. 趋势预告
5. 次级配置与商业入口

CTA 规则：

- 主 CTA 必须是安静邀请型
- 次 CTA 不与主 CTA 抢主次
- 会员与商业化入口不能压过行为闭环入口

## 7. 共享公共壳层规则

当前 Pencil 包保留一套共享壳层，不允许页级私自改写：

- tab 顺序：
  - `Today`
  - `Calendar`
  - `Bedtime`
  - `Insights`
  - `Profile`
- 激活态表达：
  - 使用强调色与文字层级变化
  - 不使用高饱和整块高亮
- `Onboarding` 不属于该共享壳层

## 8. 状态矩阵覆盖

当前设计源已按共享方向约束以下状态语义：

- 理想态
- 空态
- 加载态
- 错误态
- 权限未授权
- 部分数据
- 禁用态
- 锁定态
- 恢复态

说明：

- 当前 Pencil 页面骨架已经给出这些状态的设计承载位置。
- 更细页级状态展开仍需在共享冻结通过后进入模块阶段细化。

## 9. 高保真区域与分类

以下区域默认属于 fidelity-critical：

- Today 首屏主行动卡
- 共享底部导航
- Bedtime 行动入口
- Insights 首屏洞察摘要
- Onboarding 首屏价值解释与主 CTA

当前区域分类：

- `preserve_faithfully`
  - Today 首屏主行动卡
  - 共享底部导航
  - Onboarding 首屏 CTA 区
- `flutterize`
  - 热力图内部栅格
  - 趋势柱状区
  - 设置列表组织
- `simplify`
  - 极浅阴影与玻璃感提示
  - 细微背景质感

## 10. 允许降级与已接受缩减

当前已接受以下工程化缩减：

- Pencil 中的浅层次视觉深度可在 Flutter 里降级为更轻阴影或描边
- 趋势区与热力图区以结构优先，不强求复杂装饰
- 字体当前统一使用 `Inter` 作为 Pencil 实现字体，后续 Flutter 可按设计系统落到系统级同气质字体栈

## 11. 校验结果

- `DESIGN.md` 已存在并作为主上游权威
- `.pen` 文件已不为空，且存在共享设计主包
- 6 个页面已生成
- 6 个页面已重新导出 PNG 证据，当前导出已与本轮高端化优化同步
- `snapshot_layout(problemsOnly=true)` 当前结果：`No layout problems.`

## 12. 未决项

- 当前尚未进行 `flutter-design-freeze-gate`
- 当前尚未形成 `global_guidelines_frozen`
- 当前尚未生成模块级 `impl.md`

## 13. 当前结论

当前 Pencil 结构化设计源已经具备进入下一道确认门的基本产物条件。

本包可作为：

- `pencil_design_source_ready` 候选产物
- 共享冻结评审输入
- 后续 `flutter-design-freeze-gate` 的 Pencil 设计源来源
