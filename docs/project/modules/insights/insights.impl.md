# insights Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[insights.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/insights/insights.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

`insights` 负责消费聚合结果并编排高级解释，不拥有底层记录，也不拥有购买系统，但需要读取订阅权益快照。

## 包栈与模块说明

- `hooks_riverpod`：洞察聚合、锁定态、过滤状态
- `fl_chart`：可选趋势图
- `purchases_flutter` / 权益快照 gateway：锁定态判断
- 依赖 `sleep-data-core` 聚合服务

## 分层边界

- domain：稳定度指标、洞察摘要值对象
- application：周报加载、锁定态协调、CTA 跳转
- data：读取聚合、读取订阅快照
- presentation：洞察首页、周报详情、付费承接

## 埋点与测试

- 埋点：`insights_viewed`、`weekly_report_opened`、`paywall_viewed`
- 测试：
  - 数据不足态
  - premium lock/unlock
  - 周报详情加载与错误态

## 模块约束

- 不得在 insights 里重复实现 today / calendar 的基础浏览逻辑
- 不得在未确认权益快照策略前写死付费判断
- 洞察文案必须可国际化，不允许硬编码长中文文案

## 风险与开放问题

- 稳定度算法是否完全本地计算，还是部分云端快照
- 付费洞察与免费洞察的边界如何最小返工
