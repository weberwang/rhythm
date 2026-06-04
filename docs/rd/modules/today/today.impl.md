# today 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/today/today.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 聚合昨晚结果
  - 展示今晚目标与提醒状态
  - 展示恢复建议与快捷记录入口
  - 展示 7 日趋势摘要
- 不负责：
  - 热力图长期历史
  - 完整周报详情

## 继承的全局包栈

- `hooks_riverpod`
- `fl_chart`
- `intl`

## 领域模型与应用状态

- `TodaySnapshot`
- `LastNightSummary`
- `TonightGoalSummary`
- `RecoveryHintSummary`
- `TrendPoint`

## 数据/服务/插件边界

- 从 `sleep-data-core` 读取记录、目标与可信度
- 从通知设置读取提醒状态
- 从恢复引擎读取近两天建议

## 导航契约与交互规则

- 点击目标卡可进入睡前页或目标设置
- 点击快捷记录进入手动补录
- 点击恢复建议可进入洞察或付费恢复详情

## 埋点、安全、监控

- 埋点：
  - `today_viewed`
  - `quick_record_clicked`
  - `recovery_plan_viewed`
- 对会员锁定只记录入口来源，不记录敏感购买状态细节

## 测试范围

- 状态分支测试
- 趋势摘要映射测试
- 恢复建议优先级测试

## 设计冻结消费规则

- 不得把趋势区块上提为页面首焦点。
- 恢复建议卡必须在明显晚睡时出现于主路径。

## 实施顺序

1. 定义 TodaySnapshot 聚合用例。
2. 落首页状态 provider。
3. 落结果/目标/恢复/记录/趋势五块显示层。
4. 接入真实导航与付费锁定态。
