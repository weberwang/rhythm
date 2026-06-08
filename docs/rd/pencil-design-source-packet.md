# Rhythm Pencil 设计源包

> 产物类型：`pencil_design_source_packet`
> 日期：`2026-06-08`
> 上游方向：`DESIGN.md`
> 视觉目标：`docs/rd/rhythm-direction-jingye-order.png`
> 适配器：`pencil`
> Pencil 源引用：`docs/rd/app.pen`

## 1. 设计源摘要

本包记录已按 `静夜秩序` 方向刷新的共享 Pencil 结构化设计源。

当前源包的核心变化不是简单换色，而是共享任务层级切换：

1. 先读懂昨晚结果
2. 再理解今晚目标
3. 再进入下一步动作
4. 最后才看轻趋势与次级信息

因此，本包不再沿用旧版“今晚行动优先于结果摘要”的共享首页规则。旧共享冻结链路下的相关模块草案仅保留为历史痕迹，不得继续作为当前路线输入。

## 2. 冻结源引用

- `pencil_source_ref`：`docs/rd/app.pen`
- `shared_design_master_packet_id`：`s3gcd`
- `shared_design_master_packet_name`：`Rhythm Shared Design Master`
- `pencil_source_status`：`refreshed_for_review`

说明：

- 当前 `.pen` 文件已按新版根级 `DESIGN.md` 更新关键共享变量与 Today 主屏层级。
- 当前 Pencil 源引用明确存在，不处于 `pencil_source_ref` 缺失状态。
- 当前源包处于“共享设计源刷新完成，等待确认后进入共享指南重建”的状态。

## 3. 上游约束继承

当前 Pencil 包明确继承以下上游事实：

- 首发验证面：`ios_device`
- 设计基线：`iOS HIG`
- 最终视觉目标：`静夜秩序`
- 产品气质：温和、克制、有秩序、低压迫、非医疗化
- 公共壳层：`Today / Calendar / Bedtime / Insights / Profile`
- 首页首屏规则：`昨晚结果 -> 今晚目标 -> 下一步动作 -> 轻趋势`
- 产品语气：非医疗、非训诫、非打卡、非羞辱式反馈

## 4. 共享变量与组件

### 4.1 共享变量

当前 `.pen` 文件已刷新以下核心变量：

- 色彩：
  - `color-primary = #718C74`
  - `color-on-primary = #F8F6F1`
  - `color-secondary = #7F8983`
  - `color-surface = #F6F2EA`
  - `color-surface-container = #FCF9F3`
  - `color-on-surface = #1F2622`
  - `color-outline = #E5DDD0`
  - `color-warning = #C99A61`
  - `color-error = #D48672`
  - `color-success = #718C74`
  - `color-info = #99A4AA`
- 字体：
  - `font-display = Playfair Display`
  - `font-body = Inter`
  - `font-caption = IBM Plex Mono`
  - `font-data = IBM Plex Mono`
- 圆角：
  - `radius-md = 18`
  - `radius-lg = 28`

### 4.2 共享组件

当前共享组件仍沿用同一套公共家族，但语义和外观已向 `静夜秩序` 收束：

- `qs9oz`：`Status Bar Component`
- `w4XXe`：`Primary Action Card`
- `ZjgOl`：`Summary Card`
- `K3o0m`：`Recovery Card`
- `OkwbA`：`Shared Tab Bar`

### 4.3 当前共享组件语义

- `Summary Card`：承担结果优先的阅读角色，可承载更大字号的偏移说明
- `Recovery Card`：当前更多承载“今晚目标 / 恢复引导”类支持信息
- `Primary Action Card`：降级为结果之后的“下一步动作”容器，而不是首页第一重心
- `Shared Tab Bar`：继续保持安静存在感，不争抢首屏层级

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

- 主任务：先读懂昨晚结果，再保护今晚节奏
- 共享变化：
  - 结果卡上移为首屏第一重心
  - 今晚目标位于结果卡之后
  - 下一步动作卡降为第三层级
  - 趋势区保持最轻量
- 页级状态：`refreshed`
- 页级证据：`docs/rd/pencil-exports/MCgNV.png`

### 5.2 Calendar 页

- 主任务：查看长期节奏，不被图表压迫
- 当前状态：`palette_refreshed_not_restructured`
- 页级证据：`docs/rd/pencil-exports/SvlPW.png`

### 5.3 Bedtime 页

- 主任务：降低进入睡前模式的阻力
- 当前状态：`palette_refreshed_not_restructured`
- 页级证据：`docs/rd/pencil-exports/N3lMk.png`

### 5.4 Insights 页

- 主任务：周理解与恢复判断
- 当前状态：`palette_refreshed_not_restructured`
- 页级证据：`docs/rd/pencil-exports/OSwll.png`

### 5.5 Profile 页

- 主任务：账户、权限、同步、会员管理
- 当前状态：`palette_refreshed_not_restructured`
- 页级证据：`docs/rd/pencil-exports/BwvXZ.png`

### 5.6 Onboarding 页

- 主任务：先解释价值，再进入设置和权限
- 当前状态：`palette_refreshed_not_restructured`
- 页级证据：`docs/rd/pencil-exports/dMZS3.png`

## 6. 当前共享层级规则

当前 Pencil 包显式保留以下共享任务层级：

1. `Last night result`
2. `Tonight target`
3. `Next action`
4. `Trend preview`
5. `Secondary configuration and monetization`

该层级目前已在 `Today` 页显式落地，后续共享设计指南与主题冻结需围绕这一层级重写。

## 7. 共享公共壳层规则

当前 Pencil 包继续保留一套共享壳层，不允许页级私自改写：

- tab 顺序：
  - `Today`
  - `Calendar`
  - `Bedtime`
  - `Insights`
  - `Profile`
- 激活态表达：
  - 使用主色与文字层级变化
  - 不使用高饱和整块高亮
- `Onboarding` 不属于该共享壳层

## 8. 状态矩阵承载

当前设计源继续承载以下状态语义：

- 理想态
- 空态
- 加载态
- 错误态
- 权限未授权
- 部分数据
- 禁用态
- 锁定态
- 恢复态

当前说明：

- `Today` 页已更清晰地承载“偏移但不羞辱”的结果态
- 其余页面仍需在共享指南重建与后续冻结评审中进一步核对状态表达

## 9. 高保真区域与分类

以下区域当前默认属于 fidelity-critical：

- `Today` 首屏结果卡
- `Today` 今晚目标卡
- `Today` 下一步动作卡
- 共享底部导航
- `Onboarding` 首屏价值解释与主 CTA

当前区域分类：

- `preserve_faithfully`
  - `Today` 首屏结果卡
  - `Today` 今晚目标卡
  - 共享底部导航
- `flutterize`
  - 趋势柱状区
  - 热力图区内部格子
  - 设置列表组织
- `simplify`
  - 极浅阴影
  - 轻材质背景质感

## 10. 校验结果

- `DESIGN.md` 已按 `静夜秩序` 重写
- `.pen` 文件已完成本轮共享方向刷新
- `Today` 屏截图已检查，未见 broken / collapsed / overflow 布局问题
- `snapshot_layout(problemsOnly=true)` 当前结果：`No layout problems.`
- 页面导出：
  - `MCgNV.png`
  - `SvlPW.png`
  - `N3lMk.png`
  - `OSwll.png`
  - `BwvXZ.png`
  - `dMZS3.png`

## 11. 未决项

- 当前尚未重写 `docs/rd/global-design-guidelines.md`
- 当前尚未重写 `docs/rd/light-theme-freeze.yaml`
- 当前尚未重写 `docs/rd/dark-theme-freeze.yaml`
- 当前尚未重新执行 `flutter-design-freeze-gate`
- 当前尚未重新生成模块链路产物

## 12. 当前结论

当前 Pencil 结构化设计源已完成一轮 `静夜秩序` 方向刷新，足以作为：

- `pencil_design_source_ready` 候选产物
- 后续共享设计指南重建输入
- 共享冻结评审前的结构化设计源基础

但它还不是最终共享冻结结论。确认本包后，下一正确动作是：重建 `global-design-guidelines.md` 与双主题冻结文件，然后重新进入共享冻结评审。
