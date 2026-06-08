# today Pencil 设计源包

> 产物类型：`module_pencil_design_source_packet`
> 模块：`today`
> 日期：`2026-06-09`
> 上游合同：
> - `docs/rd/modules/today/today.ui-ux.md`
> - `docs/rd/modules/today/today.impl.md`
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`
> - `docs/rd/pencil-design-source-packet.md`
> 当前状态：`confirmed_after_preview_feedback_revision`

## 1. 包结论

本包用于把 `today` 的模块级设计源从“共享冻结”进一步收敛到“可进入模块冻结评审”的粒度。  
它不是重新设计 Today，而是把当前已确认的 `结果优先首页` 合同落成一份实现前可消费的模块源包。  
本轮还吸收了模块级效果图里可验证的正向信息组织提升，但没有接纳底部导航与漂移文案。

本轮处理结果：

- 已确认共享 `.pen` 文档中 `Today Screen` 结构稳定
- 已将 Today 页导出为模块级证据图：
  - `docs/rd/modules/today/pencil-exports/MCgNV.png`
- 已按显式 `--perviewer` 生成模块级效果图：
  - `docs/rd/modules/today/today-module-preview.png`
- 已按效果图反馈回灌并刷新 `Today Screen` 的模块级 Pencil 真源：
  - 结果卡增加日期与双列支持信息
  - 目标卡增加低刺激状态 chip
  - 动作卡调整为左文案右按钮
  - 趋势块改为 weekday 状态点阵 + 紧凑 legend
- 已校验模块目标页无布局问题：
  - `snapshot_layout(parentId=MCgNV, problemsOnly=true) = No layout problems.`

## 2. 冻结源引用

- `pencil_source_ref`: `docs/rd/app.pen`
- `shared_design_master_packet_id`: `s3gcd`
- `shared_design_master_packet_name`: `Rhythm Shared Design Master`
- `module_page_node_id`: `MCgNV`
- `pencil_source_status`: `frozen_shared_today_page_ready_for_review`

## 3. in-scope 页面与节点

### 3.1 模块主页面

- `MCgNV`: `Today Screen`

### 3.2 页面关键结构节点

- `SkdDW`: `Today Screen Content`
- `FjkfP`: `Today Feedback Row`
- `a5uZ4e`: `Last Night Summary`
- `tfIGS`: `Tonight Recovery`
- `Uwqnk`: `Tonight Action Card`
- `OQtIR`: `Trend Preview`
- `NnWMB`: `Today Screen Tab Bar`

这些节点共同证明：

- 首屏第一重心是昨晚结果主卡
- 今晚目标卡位于结果卡之后
- 下一步动作卡位于目标卡之后
- 趋势区被稳定压到第四层级

## 4. 主题变量与 Today 相关 token

### 4.1 色彩

- `color-primary`: `#718C74`
- `color-secondary`: `#7F8983`
- `color-warning`: `#C99A61`
- `color-error`: `#D48672`
- `color-surface`: `#F6F2EA`
- `color-surface-container`: `#FCF9F3`
- `color-on-surface`: `#1F2622`
- `color-outline`: `#E5DDD0`

### 4.2 字体

- `font-display`: `Playfair Display`
- `font-body`: `Inter`
- `font-caption`: `IBM Plex Mono`
- `font-data`: `IBM Plex Mono`

### 4.3 间距与圆角

- `spacing-md`: `16`
- `spacing-lg`: `24`
- `spacing-xl`: `40`
- `radius-md`: `18`
- `radius-lg`: `28`
- `radius-full`: `9999`

## 5. 首屏结构语义

### 5.1 结果主卡

节点：`a5uZ4e`

显式承载：

- `Last night` 眉题
- 结果日期
- 偏移分钟数主陈述
- 一句辅助说明
- 睡眠窗口支持信息
- rhythm 判断支持信息

语义要求：

- 必须先于目标、动作、趋势被用户读到
- 必须像“阅读结果”而不是“看报表”
- 支持信息只能作为第二层解释，不得升级成仪表盘
- 不承载复杂交互

### 5.2 今晚目标卡

节点：`tfIGS`

显式承载：

- `Tonight's target`
- 目标时间
- 轻恢复状态 chip
- wind-down / 恢复边界说明

语义要求：

- 必须承接结果卡，而不是和 CTA 合并
- 允许轻恢复语义
- chip 只能表达今晚姿态，不能替代目标时间本体
- 不得退化成设置列表样式

### 5.3 下一步动作卡

节点：`Uwqnk`

显式承载：

- `Next right step`
- 主 CTA 文案
- 一句极简执行说明

语义要求：

- CTA 清晰可达，但不得压过结果主卡
- 这是首页主动作，不是首页第一视觉重心
- 默认采用“左文案 + 右按钮”的低压横向构图
- 只允许低负担操作，不允许重表单

### 5.4 趋势摘要块

节点：`OQtIR`

显式承载：

- `7-day rhythm preview`
- weekday 状态点阵
- 紧凑 legend

语义要求：

- 只承担“轻量模式感知”
- 允许比纯柱状更易读，但不得长成仪表盘
- 不得升级成首屏主重心

## 6. 任务层级与 CTA 预期

对于 `today`，当前冻结的任务层级如下：

1. 读懂昨晚结果
2. 理解今晚目标
3. 决定下一步动作
4. 轻量理解最近趋势

CTA 规则：

- CTA 必须是安静邀请型
- CTA 不可抢走结果卡的第一重心
- 付费入口、恢复详情入口、历史入口都必须后置

## 7. Fidelity-critical 区域与分类

### `preserve_faithfully`

- `a5uZ4e` 结果主卡的首屏位置、排版重心与层级
- `tfIGS` 今晚目标卡相对结果卡的位置与轻恢复气质
- `Uwqnk` 下一步动作卡的 CTA 对比姿态与层级
- `NnWMB` 共享底部导航的结构与激活态语义

### `flutterize`

- `OQtIR` 趋势摘要块的 weekday 点阵、legend 与低强调状态表达
- 极浅阴影、轻材质感和表面层次的性能化实现

### `simplify`

- 无

当前不建议简化结果卡、目标卡和动作卡之间的层级关系。

## 8. 已接受的工程化缩减

- 趋势区当前以低强调 weekday 点阵承载，不要求在模块冻结前补复杂交互。
- 页面证据当前直接复用共享 `.pen` 中的 `Today Screen`，不额外生成新的模块真机图。

说明：

- 用户已显式确认模块级 `--perviewer`
- 当前 workflow 的模块预览策略已切换为 `perviewer_opt_in: enabled`
- 因此当前已为 `today` 生成模块级效果图并回写路径
- 但该效果图只作为补充视觉证据，不替代 Pencil 设计源。原因是其底部导航文案与共享壳层存在模型漂移，不能作为冻结真源。

## 9. 视觉一致性校验结果

- `snapshot_layout(parentId=MCgNV, problemsOnly=true)` 结果：`No layout problems.`
- `MCgNV` 截图人工检查结果：
  - 未见塌布局
  - 未见裁切
  - 结果卡 / 目标卡 / 动作卡层级清晰
  - 结果卡的支持信息已后置到第二层，没有抢走 headline
  - 动作卡按钮虽然右置，但没有压过结果卡
  - 趋势区未抢占首屏主任务
- `today-module-preview.png` 人工检查结果：
  - 首屏结果优先层级成立
  - 目标卡、动作卡与趋势块的信息组织可作为回灌参考
  - 底部导航文案存在模型漂移
  - 结论：`supplemental_only`

## 10. 模块冻结前仍需保持不变的约束

- 结果主卡必须是首屏第一视觉重心
- 目标卡必须位于结果卡之后、动作卡之前
- CTA 必须保持安静邀请型
- 趋势区、付费入口与历史摘要不得压过结果卡

## 11. 待进入 `flutter-design-freeze-gate` 的重点问题

- `today` 的高保真区域是否已经足够支撑 Flutter 恢复：
  - 结果主卡
  - 今晚目标卡
  - 下一步动作卡
  - 趋势摘要块
- 缺失、权限、部分数据、锁定态是否已有清晰承载位
- 趋势区是否已被明确限制在可 Flutter 化区域，不再影响首屏层级

## 12. 当前结论

`today` 已经具备进入模块冻结评审的 Pencil 设计源候选输入：

- 有细化后的模块 UI/UX 合同
- 有细化后的模块实现合同
- 有共享 Pencil 源引用
- 有模块级页面证据图
- 有共享冻结与主题冻结上游

本轮修订版设计源已获继续推进授权。

下一步应进入 `flutter-uiux-to-architecture`，而不是直接实现。
