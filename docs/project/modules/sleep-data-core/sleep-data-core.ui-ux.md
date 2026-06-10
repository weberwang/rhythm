# sleep-data-core UI/UX RD

## 文档状态

- uiux_status：`split_draft`
- 当前阶段：`modules_split`

## 模块目标与目标用户

为所有睡眠相关页面提供统一的数据来源、记录修正、来源标记、同步桥和节律基础指标，不直接面向单一页面，但支撑所有用户的核心睡眠闭环。

## 页面范围与导航入口

- 手动补录入口
- 记录来源说明与修正入口
- 数据状态提示层

导航入口：today、calendar、profile-settings 内部跳转到相关详情或补录动作。

## 核心用户路径

1. 读取系统健康数据或本地记录。
2. 归一化成内部睡眠记录。
3. 当自动数据缺失或冲突时，允许用户补录或修正。
4. 输出可被 today / calendar / insights 消费的统一结果。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 自动记录正常可读 |
| loading | 拉取健康数据、同步中 |
| empty | 当前没有有效睡眠记录 |
| error | 读取失败、写入失败、同步失败 |
| permission | 健康授权缺失 |
| partial_data | 只拿到部分字段或当天记录不完整 |
| disabled | 某些修正入口不可用 |
| success | 补录或同步成功 |
| locked_or_premium | 不适用 |

## 结构语义

- scroll_model：`mixed`
- list_model：`grouped list`
- overlay_model：`modal layer`
- layout_model：`mixed`
- sticky_model：`none`
- component_repeatability：
  - 数据来源标签
  - 补录字段行
  - 冲突说明卡
  - 同步状态条

## 模块级非页面组件骨架

- `source-badge`
- `record-edit-row`
- `sync-status-banner`
- `partial-data-explainer`

## 设计源

- 继承共享设计冻结
- 视觉上应维持说明型、工具型，不抢 today 主路径视觉中心
- 未来模块视觉证据待补；默认不生成模块预览

## 设计冻结卡

- 待冻结项：补录表单结构、来源标记语义、冲突说明方式、同步状态呈现

## 验收门槛

- UI/UX：用户能理解来源、缺失、修正与同步关系
- 模块设计冻结：补录和冲突处理结构清晰
- 代码交接：记录模型、来源标记、修正链路和同步入口清晰

## 开放问题

- 手动补录是否允许覆盖自动记录，还是始终保留并行来源展示？
- 部分数据状态在 today 首页展示多少细节、在详情页展示多少细节？
