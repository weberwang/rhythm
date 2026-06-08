# bedtime 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`bedtime`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/bedtime/bedtime.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`

## 2. 业务能力与边界上下文

`bedtime` 负责睡前行为干预，而不是最终睡眠结果计算。  
它接收目标作息、提醒上下文和建议能力，产出睡前状态选择与行为线索。

## 3. 继承的全局包栈与模块用法

- `hooks_riverpod` / `riverpod_annotation`：页面状态与行为事件
- `go_router`：从通知、小组件与 Today 进入的路由
- `flutter_local_notifications` / `home_widget`：仅作为入口来源，不直接在页面层调度

## 4. 领域模型与应用状态

- 领域对象：
  - `BedtimeEntryContext`
  - `BedtimeStatusSelection`
  - `WindDownAction`
  - `BedtimeSession`
- 应用状态：
  - 当前入口来源
  - 倒计时/目标状态
  - 状态选择与提交状态
  - 行为建议可用性

## 5. 基础设施依赖与展示边界

- 依赖：
  - `sleep-data-core` 的目标与提醒基础能力
  - 通知/小组件入口参数
- 展示边界：
  - 页面只展示建议与触发选择
  - 行为线索持久化由 data 层完成

## 6. 模块级组件实现说明

- 状态选择组应映射到稳定的内部枚举，不允许直接把展示文案作为存储值。
- 收尾动作卡要消费统一的行动建议模型，避免 Today 和 Bedtime 两边口径漂移。

## 7. API、存储、权限与后端协作

- 无独立远端 API
- 依赖本地记录 `BedtimeSession`
- 通知权限状态只读，不在页面层发起系统请求

## 8. 数据、安全、埋点、监控、测试范围

- 埋点：
  - `bedtime_mode_entered`
  - `bedtime_status_selected`
  - `bedtime_action_clicked`
- 监控：
  - 睡前入口到达率
  - 睡前状态选择完成率
- 测试：
  - 入口来源装配测试
  - 主路径 widget 测试
  - 行为线索写入测试

## 9. 实现顺序与依赖说明

- 依赖 `app-shell`、`sleep-data-core`、`onboarding-activation`
- 与 `today`、`calendar` 同属 `stage-3`
- 对 `insights` 的原因分布与恢复解释有上游价值

## 10. 模块特定实现约束

- 不得把 Bedtime 做成复杂表单。
- 不得引入强监督、强惩罚式语气。
- 不得在该模块直接实现高级会员承接主流程。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 更复杂的延迟提醒/轮班模式是否进入后续同模块细化，仍待确认。
