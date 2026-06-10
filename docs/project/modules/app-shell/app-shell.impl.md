# app-shell Implementation RD

## 文档状态

- impl_status：`implementation_final`
- superpowers_refinement_status：`not_executed`
- superpowers_refinement_notes：`文档已由 orchestrator 手动细化并补充预览证据，但未执行真实 @superpowers refinement trace`

## 关联文档

- 配对 UI/UX：[app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

`app-shell` 负责应用级壳层，不承载 feature 业务规则本身。它拥有根导航状态、启动分发、深链入口编排、全局 overlay host 与主容器布局。

## 继承包栈与使用说明

- `go_router`：根路由树、shell route、redirect
- `hooks_riverpod` / `riverpod_annotation`：启动状态、当前 tab、根级依赖装配
- `shared_preferences`：引导完成标记、首启状态
- `flutter_secure_storage`：会话存在性检查（只读取，不解释业务）

## 分层实现边界

- domain：不承载业务领域模型，最多保留启动分发值对象
- application：启动状态聚合、tab 状态、redirect 编排
- data：本地引导标记读取、会话存在性网关、深链输入解析
- presentation：根导航容器、全局占位、重定向过渡页

## 建议文件落点

- `lib/app/router/app_router.dart`
  - 根路由树、shell route、redirect policy
- `lib/features/app_shell/application/app_shell_bootstrap_controller.dart`
  - 启动分发状态聚合
- `lib/features/app_shell/application/app_shell_tab_controller.dart`
  - 当前 tab 与 branch 切换策略
- `lib/features/app_shell/data/local/app_shell_launch_state_store.dart`
  - 引导完成标记读取
- `lib/features/app_shell/data/platform/app_shell_deep_link_gateway.dart`
  - 深链 / 通知 / widget 入口适配
- `lib/features/app_shell/presentation/root_shell_page.dart`
  - root shell 布局
- `lib/features/app_shell/presentation/startup_gate_page.dart`
  - 启动分发 loading / error / redirect 页
- `lib/features/app_shell/presentation/widgets/root_tab_bar.dart`
  - 底部 tab bar
- `lib/features/app_shell/presentation/widgets/global_overlay_host.dart`
  - 全局 overlay host

## 模块级组件实现备注

- `shell-tab-item` 应只消费壳层 provider，不直接依赖具体 feature provider。
- `startup-gate-view` 只根据聚合状态路由，不承担登录、权限或健康业务解释。
- `global-overlay-host` 应允许 feature 模块以统一接口上报 toast / banner 事件。

## 基础设施与依赖

- 依赖 `app/bootstrap` 完成全局实例初始化
- 依赖 feature 模块提供各自 route branch
- 深链与通知入口只在这里做一级分发，不在多个 feature 内重复判断

## 根路由与壳层契约

- 根路由至少包含：
  - `startup-gate`
  - `onboarding-activation`
  - `root-shell/today`
  - `root-shell/calendar`
  - `root-shell/bedtime`
  - `root-shell/insights`
  - `root-shell/profile-settings`
- `root-shell` 是唯一 bottom-tab 宿主。
- redirect 决策只能在 app-shell application 层集中完成。
- feature 模块只暴露 branch，不负责根级登录 / 引导分流。

## 启动分发决策表

| 输入 | 决策 |
| --- | --- |
| `has_completed_onboarding = false` | 跳转 onboarding |
| `has_completed_onboarding = true` 且无 deep link | 跳转 today |
| `deep_link_target = bedtime` 且 bedtime 前置满足 | 跳转 bedtime |
| `deep_link_target = today` | 跳转 today |
| `session_restored = true` | 保持当前目标路由，额外挂全局 success overlay |
| `bootstrap_failed = true` | 进入 root error shell |

## 详细输入与输出契约

### `app_shell_bootstrap_controller`

- 输入：
  - onboarding completion flag
  - secure session existence
  - incoming deep link payload
  - optional restore purchase result
- 输出：
  - `startup_loading`
  - `startup_redirect(targetRoute)`
  - `startup_error(retryableMessage)`
  - `deep_link_handoff(targetRoute, reason)`

### `app_shell_tab_controller`

- 输入：
  - selected root branch
  - current branch stack state
- 输出：
  - stable selected tab index
  - branch switch action
  - reselect behavior action

## 屏幕级状态拥有权

- `startup_gate_state`：app-shell 自有
- `current_tab_state`：app-shell 自有
- `root_redirect_state`：app-shell 自有
- `feature_page_state`：归各 feature 所有
- `global_overlay_queue`：app-shell 自有，但由 feature 通过统一接口上报事件

## 交互与失败恢复

- 启动分发 loading 超时后必须进入可恢复错误态，而不是无限转圈。
- redirect 失败必须保留一个明确“重试”主动作。
- tab 重点是保持当前 feature 栈稳定，不做点击即重建所有状态的粗暴实现。
- 深链无法满足前置条件时，应回退到 today 或 onboarding，并展示说明性 overlay。

## 非显示层契约

- bootstrap controller 不得依赖具体 feature 页面类，只输出 route target。
- deep link gateway 只解析原始 payload，不做业务规则判断。
- overlay host 消费统一的 UI 事件流，不直接拉取业务状态。
- tab controller 不负责业务 analytics 发送，只暴露切换结果事件。

## 数据、安全、埋点、测试

- 安全：禁止在壳层缓存完整业务数据
- 埋点：`app_open`、`startup_gate_resolved`、`tab_selected`
- 测试：
  - redirect 逻辑
  - tab 切换状态保持
  - 深链进入时的目标路由判断
  - 启动失败后的恢复动作
  - overlay 队列展示顺序

## 实现级测试分解

- 单元测试
  - onboarding flag -> route target
  - deep link payload -> route target / fallback
  - tab reselect behavior
- Widget 测试
  - startup gate loading/error shell
  - root tab bar active state
  - global overlay host priority
- 集成测试
  - 冷启动进入 onboarding
  - 冷启动进入 today
  - 通知深链进入 bedtime
  - bootstrap 失败后重试恢复

## 代码实现边界

- presentation 只负责：
  - 根布局
  - tab bar
  - 启动 loading / error / handoff 页面
  - overlay host
- application 负责：
  - route target resolution
  - onboarding completion decision
  - tab selection state
  - deep link handoff result
- data 负责：
  - shared_preferences 引导状态读取
  - secure_storage 会话存在性检查
  - deep link payload 解析
  - 通知 / widget 入口原始数据适配

## 预览与设计源消费说明

- 当前模块预览证据：[app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
- 该预览只作为 `app-shell` 模块设计冻结前的补充静态证据，不替代共享设计冻结文档。
- display-layer 后续必须优先保留：
  - 顶部安全区留白
  - 大标题与副操作圆形按钮关系
  - 底部 tab bar 位置与 active state
  - 暖白背景 + 大圆角浅边框卡片世界
  - 低噪声、低装饰、强任务层级

## 模块设计源包消费要求

- 后续进入 module freeze 时，必须把以下内容写入 app-shell 模块设计源包：
  - startup gate hierarchy
  - root tab bar states
  - deep-link handoff states
  - overlay priority contract
- 若未来 `app-shell` 页面结构与当前预览图发生冲突，以共享冻结文档与模块设计源包为准，而不是以实现便利为准。

## 模块约束

- 实现不得绕开 `go_router` 再做第二套路由真相源
- 不得把 feature 业务 provider 下沉到 app-shell 里解释
- UI 层必须遵守共享设计冻结后的底部导航和容器语义
- 不得让某个 feature 在运行时替换掉全局 tab shell
- 不得把深链分发散落到多个 feature 页面里各自判断
- 不得在启动阶段直接访问重型业务 repository，只能读取最小必要状态

## 早期风险与开放问题

- 通知深链与 tab 高亮的一致性
- 匿名升级登录后的导航栈恢复策略
- app-shell 是否需要全局 banner 队列而不是单条覆盖
- 冷启动时并行读取 onboarding/session/deep-link 结果的竞态顺序
