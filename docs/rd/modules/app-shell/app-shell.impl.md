# app-shell 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`app-shell`
> 文档成熟度：`implementation_final_candidate`
> 日期：`2026-06-08`
> 适用阶段：`module_impl_docs_ready` 候选

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/app-shell/app-shell.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`
- 共享设计冻结：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/light-theme-freeze.yaml`
  - `docs/rd/dark-theme-freeze.yaml`
  - `docs/rd/pencil-design-source-packet.md`
  - `docs/rd/modules/app-shell/app-shell.pencil-design-source-packet.md`

## 2. 业务能力与边界上下文

`app-shell` 的职责边界是：

- 决定进入哪里
- 决定顶层壳层如何承载
- 决定全局级提示如何挂载

它不负责：

- 业务卡片内容计算
- 睡眠记录口径定义
- 会员细节计算
- feature 内部错误页

## 3. 继承的全局包栈与模块用法

- `go_router`
  - 根路由
  - 启动重定向
  - 顶层壳层路由宿主
- `hooks_riverpod` / `riverpod_annotation`
  - 壳层状态
  - 启动分发状态
  - 全局提示状态
- `shared_preferences`
  - 首用完成标记
  - 轻量壳层偏好
- `flutter_local_notifications` / `home_widget`
  - 仅消费入口参数
  - 不在该模块做业务数据持久化

## 4. 领域模型、状态所有权与协调关系

### 4.1 领域模型

- `AppEntryTarget`
- `RootDestination`
- `ShellLaunchContext`
- `GlobalBannerMessage`

### 4.2 应用状态所有权

- 是否需要 onboarding
- 当前顶层目的地
- 冷启动/恢复/降级状态
- 当前来源上下文
- 全局提示当前项或队列

### 4.3 协调关系

- 从会话层读取“是否已有可恢复身份”
- 从 `sleep-data-core` 读取“目标作息是否已具备最低可用条件”
- 从通知/小组件桥接层读取来源参数

## 5. 屏幕级状态与详细行为

### 5.1 启动等待阶段

- `loading`
  - 条件：读取首用标记、会话、入口参数
  - 行为：展示等待态，不展示顶层导航
- `error`
  - 条件：恢复失败或入口解析失败
  - 行为：记录错误，显示轻说明，并继续进入本地可用路径

### 5.2 根级分发阶段

- `need_onboarding`
  - 条件：未完成首用、最低可用条件缺失
  - 行为：跳转到 `onboarding-activation`
- `ready_for_shell`
  - 条件：已具备进入主应用条件
  - 行为：进入五 tab 共享壳层
- `source_redirect`
  - 条件：来源目标存在且合法
  - 行为：进入对应顶层页并保留来源上下文
- `source_fallback`
  - 条件：来源目标失效或依赖未满足
  - 行为：回退到对应 tab 首页或 `Today`

### 5.3 壳层阶段

- `normal`
  - 行为：展示当前顶层页面与共享导航
- `global_banner_present`
  - 行为：顶部挂载提示横幅，但不遮挡页面主内容
- `destination_switching`
  - 行为：切换顶层目的地，不重置无关全局状态

## 6. 导航契约、进入条件与返回行为

### 6.1 进入条件

- `onboarding-activation`
  - 当且仅当首用必要条件未满足
- 顶层五 tab
  - 当用户已具备最低可用状态

### 6.2 返回行为

- onboarding 完成后，默认返回 `Today`
- 来源进入若需要结束，应回到对应顶层宿主，而不是退出应用到未知位置

### 6.3 深链/来源契约

- 允许来源目标：
  - `today`
  - `bedtime`
  - `calendar`
  - `insights`
  - `profile`
- 不允许来源直接越权进入未具备前置条件的次级深页面

## 7. Repository / Service / Gateway 责任

### 7.1 Repository / Query

- 读取首用完成标记
- 读取会话存在性或会话摘要
- 读取最低可用配置是否已完成

### 7.2 Service / Coordinator

- `AppLaunchCoordinator`
  - 统筹启动分发
- `ShellDestinationResolver`
  - 将来源参数映射到顶层目的地
- `GlobalBannerCoordinator`
  - 统一全局横幅状态

### 7.3 Gateway

- `NotificationEntryGateway`
  - 解析通知入口
- `HomeWidgetEntryGateway`
  - 解析小组件入口

## 8. 模块级组件实现说明

- 壳层脚手架必须直接消费共享设计源里的公共壳层规则，不允许各 feature 自建导航。
- 顶层目的地切换器由壳层唯一拥有实现权，feature 只能消费其结果。
- 全局横幅只承载跨模块问题，不接管 feature 私有错误。

## 9. 详细失败、空态、权限与降级行为

### 9.1 启动恢复失败

- 记录监控事件
- 显示轻说明
- 继续进入本地路径

### 9.2 来源解析失败

- 记录失败来源
- 不停留在死路
- 降级进入 `Today`

### 9.3 前置条件不完整

- 若是首用条件缺失，跳 onboarding
- 若是业务能力缺失但不阻断壳层，进入主应用并挂提示横幅

## 10. 数据、安全、埋点、监控、测试范围

### 10.1 数据

- 仅维护壳层级进入上下文与状态
- 不拥有睡眠业务核心数据

### 10.2 安全

- 不暴露深链参数中的敏感信息
- 不在日志里直接打印原始入口 payload

### 10.3 埋点

- `app_open`
- `onboarding_started`
- `root_redirect_completed`
- `top_destination_switched`

### 10.4 监控

- 启动恢复失败
- 深链解析失败
- 入口降级次数

### 10.5 测试范围

- 根路由重定向测试
- 启动到 onboarding / Today 的装配测试
- 通知/小组件入口降级测试
- 全局横幅不遮挡主内容的 widget 测试

## 11. 模块特定实现约束

- 不得改写已冻结的五个顶层目的地顺序与主语义。
- 不得把 feature 级业务逻辑塞回壳层。
- 不得在该模块内偷偷落地业务页面视觉恢复。
- 不得让壳层承担复杂会员承接或营销职责。

## 12. 冻结设计源消费说明

- 共享底部导航属于 `preserve_faithfully`
- 启动等待态属于 `flutterize`
- 全局横幅层级与留白关系属于 `preserve_faithfully`
- 来源标记条属于 `flutterize`

实现时必须优先消费：

- `docs/rd/pencil-design-source-packet.md` 中的共享壳层规则
- `docs/rd/global-design-guidelines.md` 中的全局导航、CTA 与信息层级约束
- `docs/rd/modules/app-shell/app-shell.pencil-design-source-packet.md` 中的模块级壳层状态、横幅层级与来源降级约束

## 13. 显示层决策说明

- 锁定不变的显示层意图：
  - 底部导航是壳层，不是页面主角
  - 全局横幅只是一层提示，不是主内容
- 可 Flutter 化的区域：
  - 启动等待态轻动画
  - 来源标记显隐

## 14. 实现顺序与依赖说明

- 该模块必须先于所有顶层 feature 模块
- 与 `sleep-data-core` 同属基础阶段
- 解锁：
  - `onboarding-activation`
  - `today`
  - `bedtime`
  - `calendar`
  - `insights`
  - `profile-settings`

## 15. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_date`: `2026-06-08`
- `superpowers_refinement_notes`: `当前文档已被人工细化到 implementation-final 候选粒度，但尚未经过真实 @superpowers 执行链路确认，因此不能标记为 verified_executed`

## 16. 开放问题

- 匿名入口与正式登录入口的优先级仍待最终业务冻结。
- onboarding 完成后是否需要回到来源目标，仍待最终策略确认。
