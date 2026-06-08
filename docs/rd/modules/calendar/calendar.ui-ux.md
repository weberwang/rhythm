# calendar UI/UX RD

> 产物类型：`module_uiux_rd`
> 模块：`calendar`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 模块目标与目标用户

`calendar` 负责提供长期节奏反馈，让用户看见模式，而不是被图表压迫。  
目标用户是希望回看近期节奏、查某一天情况、理解长期偏移的回访用户。

## 2. 页面范围与导航入口

- 页面范围：
  - Calendar 顶层页
  - 热力图区
  - 月度摘要区
  - 单日详情区
  - 筛选模式区
- 导航入口：
  - 底部导航 `Calendar`
  - Today 趋势/历史入口

## 3. 核心用户路径

1. 用户进入 Calendar，先看到月度节奏概览。
2. 用户切换筛选模式查看不同维度。
3. 用户点开某一天，查看单日结果与来源解释。
4. 若该天无数据或被锁定，系统明确说明并给出补录或升级路径。

## 4. 状态矩阵

| 状态 | 触发条件 | 承载位置 | 设计处理 |
| --- | --- | --- | --- |
| ideal | 有完整历史数据 | 热力图与详情区 | 先看模式，再看细节 |
| loading | 历史聚合中 | 热力图骨架与摘要骨架 | 保留整体框架 |
| empty | 记录过少 | 热力图区 | 说明还在积累数据 |
| error | 聚合失败 | 页内状态位 | 给重试与返回路径 |
| permission | 数据源权限不足 | 顶部说明区 | 解释影响并给手动路径 |
| partial_data | 历史存在缺口 | 热力图区/详情区 | 清楚区分未记录与部分数据 |
| disabled | 某筛选暂不可用 | 筛选区 | 说明原因 |
| success | 选中某天并成功解析 | 单日详情区 | 呈现偏移与解释 |
| locked | 历史深度被锁定 | 热力图区/详情区 | 展示免费边界和升级价值 |

## 5. 结构语义

- `scroll_model`: `whole_page_scroll`
- `list_model`: `mixed`
- `overlay_model`: `modal_layer`
- `layout_model`: `mixed`
- `sticky_model`: `sticky_tab/filter`
- `component_repeatability`: 月度摘要块、筛选切换、热力图单元、单日详情卡、锁定边界卡

## 6. 模块级非页面组件设计骨架

| 组件 | 用途范围 | 状态/变体 | 复用边界 | 后续是否进入模块设计源冻结 |
| --- | --- | --- | --- | --- |
| 月度摘要块 | 概览当月节奏 | 默认、部分数据 | Calendar 专有 | 是 |
| 筛选切换条 | 入睡时间/稳定度/晚睡次数切换 | 默认、选中、禁用 | Calendar 专有 | 是 |
| 热力图单元语义 | 单日偏移表达 | 正常、缺失、锁定 | Calendar 专有 | 是 |
| 单日详情卡 | 某日解释与入口 | 正常、缺失、可补录、锁定 | Calendar / Today 共享结果语义 | 是 |

## 7. 设计源

- 共享冻结上游：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/pencil-design-source-packet.md`
- 页面证据：
  - `docs/rd/pencil-exports/SvlPW.png`
- 设计约束：
  - 不得做成复杂仪表盘
  - 热力图优先传达相对目标偏移，而非绝对数值堆叠
- 模块阶段默认不生成新预览

## 8. 设计冻结卡

- `freeze_status`: `reserved`
- `module_component_freeze`: `reserved`
- `high_fidelity_focus`: 热力图语义、筛选区层级、单日详情入口
- `immutable_constraints`:
  - 缺失数据与锁定数据必须可区分
  - 模式理解优先于炫技图形
- `adjustable_items`:
  - 热力图绘制的具体 Flutter 化形式
  - 单日详情展开方式

## 9. 验收门

- UI/UX：
  - 用户能快速理解当月模式
  - 单日详情可解释，不只是数字
- 模块设计冻结：
  - 筛选与热力图语义稳定
  - 锁定边界清晰
- 代码交接：
  - 历史口径、热力图数据结构与单日详情边界明确

## 10. 开放问题

- 免费层可见历史长度与锁定阈值仍需商业侧最终确认。
