# sleep-data-core UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结所有共享数据可信度、同步状态、来源标识、手动修正与时区上下文的可视表达。
- 目标用户：查看自动记录、修正记录、处理同步失败、处理时区变化的用户。

## 页面范围与导航入口

- 无独立 tab 页面
- 暴露于：
  - 今日页来源标签
  - 日历单日详情
  - 我的页同步状态
  - 手动补录 / 修正 sheet
  - 时区变更提示条

## 核心用户路径

1. 自动记录到达后，用户看到来源与可信度。
2. 若数据缺失或不可信，用户进入手动修正。
3. 若同步失败，用户看到轻提示并重试。
4. 若时区切换，系统暂停普通判断并请求确认。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| source_trusted | 展示来源标识 |
| source_partial | 展示部分数据说明 |
| manual_adjusted | 明确修正来源 |
| sync_failed | 页内提示 + 重试 |
| timezone_shift | 暂停普通判断 + 确认入口 |

## 结构语义

- `scroll_model`: mixed
- `list_model`: grouped list
- `overlay_model`: modal layer
- `layout_model`: mixed
- `sticky_model`: none
- `component_repeatability`:
  - 来源 badge
  - 同步状态 tile
  - 手动修正 sheet
  - 时区提示条

## 模块级组件骨架

- `SleepSourceBadge`
- `ConfidenceTag`
- `ManualCorrectionSheet`
- `SyncFailureBanner`
- `TimezoneContextNotice`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 本模块无独立视觉证据；数据可信度与错误表达由共享冻结和本文冻结。
- 本模块冻结包：本文 + `sleep-data-core.impl.md` + 共享冻结产物

## 设计冻结卡

- 已冻结：
  - “来源可信但可修正”的信息表达
  - 同步失败使用页内轻提示，不阻断本地闭环
  - 时区变化单独提示，不把结果强行按普通规则解释
- 允许工程调整：
  - 修正 sheet 的字段布局
  - banner 与 tile 的具体容器样式

## 验收门槛

- 所有共享页面都必须能看见数据来源或可信度说明。
- 手动修正后的记录必须有可见标识。
- 同步失败与时区变化不能被埋进 debug 信息里。
