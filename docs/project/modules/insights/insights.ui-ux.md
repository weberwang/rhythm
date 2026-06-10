# insights UI/UX RD

## 文档状态

- uiux_status：`split_draft`
- 当前阶段：`modules_split`

## 模块目标与目标用户

`insights` 负责周报、稳定度、恢复趋势和高级洞察承接，面向已经形成一定使用习惯并愿意理解趋势的用户。

## 页面范围与导航入口

- 洞察首页
- 周报详情
- 稳定度说明
- 恢复趋势与付费承接区

导航入口：底部 tab、today 周视图点击、calendar 趋势深入查看。

## 核心用户路径

1. 用户进入 insights。
2. 浏览本周或近期总结。
3. 理解稳定度与恢复线索。
4. 若涉及高级洞察，看到付费承接入口。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 周报与稳定度完整展示 |
| loading | 卡片与图表骨架 |
| empty | 历史数据不足，无法生成洞察 |
| error | 聚合失败或报告不可用 |
| permission | 核心数据缺失导致洞察不足 |
| partial_data | 周报可展示但部分指标缺失 |
| disabled | 某些过滤 / 对比不可用 |
| success | 订阅恢复或周报生成成功反馈 |
| locked_or_premium | 高级洞察和解释锁定 |

## 结构语义

- scroll_model：`whole-page scroll`
- list_model：`mixed`
- overlay_model：`mixed`
- layout_model：`linear`
- sticky_model：`none`
- component_repeatability：
  - insight summary card
  - metric explanation row
  - paywall teaser section
  - week report block

## 模块级非页面组件骨架

- `insight-summary-card`
- `stability-metric-row`
- `report-highlight-block`
- `premium-teaser-card`

## 设计源

- 继承共享冻结
- 相比 today，可允许更高信息密度，但仍需维持温和、有秩序、不指责的语气
- 模块预览默认不生成

## 设计冻结卡

- 待冻结项：周报主卡层级、稳定度解释结构、付费承接位置、空数据态

## 验收门槛

- UI/UX：趋势结论与可执行建议并存，而非纯结果看板
- 模块设计冻结：高级内容与免费内容边界清晰
- 代码交接：聚合结果、订阅锁定与周报详情边界清晰

## 开放问题

- 稳定度解释是更偏科普还是更偏策略建议？
- 付费承接是否直接放在洞察流中，还是独立 paywall 页面？
