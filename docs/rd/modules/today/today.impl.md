# today 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`today`
> 文档成熟度：`implementation_final_candidate`
> 日期：`2026-06-09`
> 适用阶段：`module_impl_docs_ready` 候选

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/today/today.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`
- 共享设计冻结：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/light-theme-freeze.yaml`
  - `docs/rd/dark-theme-freeze.yaml`
  - `docs/rd/pencil-design-source-packet.md`

## 2. 业务能力与边界上下文

`today` 负责把多个基础数据口径收敛成“今日可行动的结果页”。  
它不拥有原始睡眠数据，也不拥有睡前行为写入逻辑，只负责日级聚合展示、首屏层级组织和入口暴露。

在当前共享冻结下，`today` 的实现边界包含一个不可变约束：页面必须先组织“昨晚结果解释”，再组织“今晚目标时间”和“下一步动作”，而不是退回行动面板式首页。

## 3. 继承的全局包栈与模块用法

- `hooks_riverpod` / `riverpod_annotation`
  - Today ViewState
  - 聚合 provider 装配
- `go_router`
  - 跳转到 Bedtime
  - 跳转到 Calendar 详情
  - 跳转到 Profile 设置
- `collection`
  - 聚合与缺口判断辅助
- `intl`
  - 时间、偏移与简短说明文案格式化

## 4. 领域模型、状态所有权与协调关系

### 4.1 领域模型

- `TodayViewState`
- `LastNightSummary`
- `TonightGoalSummary`
- `NextActionSummary`
- `RecoveryPreview`
- `TodayTrendPreview`

### 4.2 应用状态所有权

- 页面加载状态
- 首屏结果卡状态
- 今晚目标卡状态
- 下一步动作卡状态
- 快捷补录入口状态
- 恢复建议锁定状态

### 4.3 协调关系

- 从 `sleep-data-core` 读取日级记录、目标与恢复基础结果
- 从 `bedtime` 读取或消费进入入口
- 从 `app-shell` 消费页面入口上下文，不反向拥有壳层路由逻辑

## 5. 屏幕级状态与详细行为

### 5.1 结果主卡

- `ideal`
  - 条件：存在完整记录
  - 行为：展示偏移分钟数、结果主陈述、一句辅助说明，以及睡眠窗口 / rhythm 判断两列支持信息
- `partial_data`
  - 条件：记录存在但不完整
  - 行为：明确告诉用户当前判断不完整
- `empty`
  - 条件：无记录或首日使用
  - 行为：解释暂无结果，但今晚仍可开始

### 5.2 今晚目标卡

- `ideal`
  - 条件：目标作息完整
  - 行为：展示目标时间、低刺激状态 chip 与 wind-down 边界
- `soft_recovery`
  - 条件：昨晚明显晚睡
  - 行为：在目标卡内附加轻恢复说明
- `partial_goal`
  - 条件：目标数据不完整
  - 行为：提示缺口，但不阻断首页使用

### 5.3 下一步动作卡

- `default`
  - 条件：今晚可直接收尾
  - 行为：以左文案右按钮的低压构图展示主 CTA
- `disabled`
  - 条件：入口暂不可用
  - 行为：说明原因，不伪装为可点击
- `completed_hint`
  - 条件：用户已执行某个轻动作
  - 行为：弱化 CTA，但不隐藏

### 5.4 页级异常与恢复

- `sync_error`
  - 行为：页内说明 + 本地可继续路径
- `permission_missing`
  - 行为：说明授权价值 + 手动路径
- `locked`
  - 行为：恢复详情或历史更深内容锁定，但不抢首屏主任务

## 6. 导航契约、进入条件与返回行为

### 6.1 进入条件

- 用户已进入主应用壳层
- `today` 可作为默认首页，即使权限、同步或历史数据不完整

### 6.2 返回行为

- 从 Bedtime 返回时，回到 Today
- 从 Calendar 单日详情返回时，回到 Today 或 Calendar 宿主，不重建 Today 路由逻辑

### 6.3 深链 / 来源契约

- Today 是无效来源或来源条件不足时的安全降级首页
- Today 不负责解析来源，只负责消费壳层已解析完成的上下文

## 7. Repository / Service / Gateway 责任

### 7.1 Repository / Query

- 读取日级睡眠记录摘要
- 读取目标作息摘要
- 读取恢复计划摘要
- 读取趋势预告所需的最近 7 天数据

### 7.2 Service / Coordinator

- `TodayAggregator`
  - 聚合首屏结果、目标、动作、趋势
- `NextActionResolver`
  - 统一决定首页 CTA 应该是什么

### 7.3 Gateway

- 无额外原生 gateway
- 只消费上游模块已提供的入口与数据

## 8. 模块级组件实现说明

- 结果主卡必须消费统一内部模型，不允许页面层自己拼装偏移分钟与主陈述。
- 结果卡的日期、睡眠窗口与 rhythm 支持信息必须从同一聚合结果派生，避免页面层分散拼装。
- 今晚目标卡和下一步动作卡必须从同一聚合状态中读取，避免页面层重复判断“今晚该做什么”。
- 快捷补录入口与恢复详情入口都必须后置于主卡层级之后。
- 恢复卡若展示免费摘要，应与 `insights` 使用同一恢复计划语义。

## 9. 详细失败、空态、权限与降级行为

### 9.1 结果缺失

- 不得出现大片空白
- 必须保留今晚目标与下一步动作
- 必须给补录或修正路径

### 9.2 同步失败

- 显示页内轻说明
- 不得直接把首页变成错误页
- 本地已有内容仍应展示

### 9.3 权限缺失

- 说明为什么权限有价值
- 明示仍可继续手动路径
- 不在首页再次制造高压授权感

## 10. 数据、安全、埋点、监控、测试范围

### 10.1 数据

- 仅维护 Today 聚合展示所需的派生状态
- 不拥有睡眠业务核心数据

### 10.2 安全

- 不在日志中直接打印健康原始记录
- 不在错误态暴露原始异常细节给用户

### 10.3 埋点

- `app_open`
- `bedtime_mode_entered`
- `sleep_record_manual_created`
- `recovery_plan_viewed`

### 10.4 监控

- Today 聚合失败
- 结果卡缺失率
- 目标卡缺失率
- CTA 解析失败率

### 10.5 测试范围

- ViewState 聚合测试
- 结果优先排序测试
- 结果缺失 / 目标缺失 / 部分数据态 widget 测试
- 权限缺失 / 同步失败 / 锁定态 widget 测试

## 11. 模块特定实现约束

- 不得把 Today 做成结果报告仪表盘。
- 不得把 Today 退回行动优先首页。
- 不得让付费入口、趋势区或历史摘要压过首屏结果主卡。
- 不得自行发明新的“晚睡评分”或偏移口径。

## 12. 冻结设计源消费说明

- 结果主卡属于 `preserve_faithfully`
- 今晚目标卡属于 `preserve_faithfully`
- 下一步动作卡属于 `preserve_faithfully`
- 趋势摘要块属于 `flutterize`

实现时必须优先消费：

- `docs/rd/pencil-design-source-packet.md` 中的共享页面结构与 Today 证据图
- `docs/rd/global-design-guidelines.md` 中的结果优先层级、CTA 姿态与视觉限制
- `docs/rd/light-theme-freeze.yaml` / `docs/rd/dark-theme-freeze.yaml` 中的语义色与组件状态角色

## 13. 显示层决策说明

- 锁定不变的显示层意图：
  - 结果主卡必须是首屏第一视觉重心
  - 今晚目标卡必须承接结果，而不是和 CTA 混成一块
  - CTA 必须清晰但不能压过结果
- 可 Flutter 化的区域：
  - 趋势摘要的具体绘制方式
  - 极浅阴影和表面层级的性能化简

## 14. 实现顺序与依赖说明

- 依赖 `app-shell`、`sleep-data-core`、`onboarding-activation`
- 与 `bedtime`、`calendar` 同属主闭环阶段
- 解锁 `insights` 的更强消费场景

## 15. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_date`: `2026-06-08`
- `superpowers_refinement_notes`: `当前文档已被人工细化到 implementation-final 候选粒度，但尚未经过真实 @superpowers 执行链路确认，因此不能标记为 verified_executed`

## 16. 开放问题

- 趋势摘要块的免费边界与互动深度仍需后续模块冻结时再精细化。
- 恢复详情锁定与免费摘要的边界文案仍需商业侧最终确认。
