# today Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[today.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/today/today.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

`today` 拥有今日落点的聚合展示，不拥有底层睡眠记录，但负责把昨晚结果、今晚窗口、晚间任务和本周摘要编排成可执行首页。

## 包栈与模块说明

- `hooks_riverpod`：聚合 today view state
- `go_router`：进入 recovery、insights、calendar 详情
- 依赖 `sleep-data-core` repository 获取记录、目标、偏离和摘要

## 分层边界

- domain：today 页面消费的聚合值对象
- application：today 首页状态聚合、CTA 路由决策
- data：调用 sleep-data-core / settings / subscription 只读接口
- presentation：首页长页、骨架、卡片与列表组合

## 模块级组件实现备注

- `sleep-window-card` 必须支持完整、partial、warning 三态
- `wind-down-item-row` 必须能表达当前步骤与未来步骤
- `weekly-status-strip` 不能自己重算统计，应消费已聚合结果

## 依赖与协作

- 依赖 `app-shell` 提供 tab 壳层
- 强依赖 `sleep-data-core` 的记录、目标、偏离与周摘要接口
- 弱依赖 `profile-settings` 的通知配置状态

## 埋点与测试

- 埋点：`today_viewed`、`recovery_cta_tapped`、`wind_down_item_opened`
- 测试：
  - today 首页聚合状态
  - partial data fallback
  - recovery CTA 展示逻辑
  - weekly strip 状态映射

## 模块约束

- today 不能重新定义 sleep window 业务规则
- 不能把 calendar / insights 的详情逻辑塞回 today
- 必须严格遵守共享冻结卡片顺序与主层级

## 风险与开放问题

- recovery CTA 的导航形式会影响 today 与 bedtime 的协作边界
- 周视图卡与 insights 的职责需要避免重复统计逻辑
