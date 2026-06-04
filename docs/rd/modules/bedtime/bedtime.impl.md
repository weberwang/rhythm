# bedtime 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/bedtime/bedtime.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 睡前 session 展示
  - 今晚状态记录
  - 轻收尾动作推荐
  - 延后/退出处理
- 不负责：
  - 周期性长期报告

## 继承的全局包栈

- `hooks_riverpod`
- `flutter_local_notifications`
- `timezone`

## 领域模型与应用状态

- `BedtimeSessionDraft`
- `BedtimeStatusChoice`
- `WindDownAction`
- `ReminderState`

## 数据/服务/插件边界

- 从 `GoalSchedule` 读取目标时间与阈值
- 从 `BedtimeSessionRepository` 读取/写入当晚 session
- 从通知 gateway 读取提醒状态

## 导航契约与交互规则

- 通知与小组件都转换为统一 entry intent
- 退出时保留必要草稿，不强制提交复杂表单

## 埋点、安全、监控

- 埋点：
  - `bedtime_mode_entered`
  - `bedtime_status_selected`
  - `bedtime_action_clicked`

## 测试范围

- 倒计时/目标时间计算测试
- 三状态选择测试
- 通知入口直达测试

## 设计冻结消费规则

- 不得新增第二个强主 CTA。
- 不得把睡前页扩展成多步骤复杂表单。

## 实施顺序

1. 建立 bedtime session 状态。
2. 落倒计时与状态选择。
3. 落动作推荐与退出路径。
4. 接入通知入口与结果写回。
