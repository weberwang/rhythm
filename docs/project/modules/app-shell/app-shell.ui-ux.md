# app-shell UI/UX RD

## 文档状态

- uiux_status：`implementation_final`
- 当前阶段：`module_uiux_refinement`

## 模块目标与目标用户

`app-shell` 的目标是为 Rhythm 提供稳定的根导航、底部一级入口、启动分发与全局容器。目标用户是所有进入应用的用户，无论其处于匿名、已登录、已授权还是权限未完成状态。

## 页面范围与导航入口

- 启动页 / 启动分发
- 根级底部导航容器
- 全局 loading / error / redirect 壳层
- 匿名可用主链路入口
- 根级深链承接页

导航入口：应用冷启动、热启动、通知深链、小组件深链、恢复购买回流。

## 核心用户路径

1. 用户启动应用。
2. app-shell 判断本地引导状态、登录状态、健康权限状态与目标设置完成度。
3. 根据状态路由到 onboarding、today 或 bedtime 的对应入口。
4. 用户在底部 tab 之间切换，壳层保持状态与导航栈稳定。
5. 若来自通知或小组件深链，壳层先完成分发，再把用户落到目标模块上下文。

## 页面级结构与层级

### 启动分发页

- 顶层为全屏安全区容器，不展示底部 tab。
- 中心区域只承载品牌级 loading / redirect 状态，不承载业务解释性长文案。
- 错误态允许展示一个主说明和一个恢复动作。

### 根级 tab shell

- 顶层为 root shell 容器。
- 中间为活动模块内容区域。
- 底部为固定 tab bar。
- tab bar 永远位于安全区上方，不能被 feature 页面单独替换。
- root shell 默认不额外显示业务标题栏，标题和内容归各 feature 自行承担。

### 深链承接过渡

- 当深链目标需要额外数据校验时，先展示轻量过渡态，再进入目标模块。
- 过渡态不能让用户误以为自己被跳出主链路。

## 页面分解与 section hierarchy

### `startup-gate`

1. 品牌级空白留白
2. 中心 loading / redirect 状态
3. 错误态单主说明
4. 单主动作按钮

### `root-shell`

1. 当前模块内容插槽
2. 全局 overlay 承载层
3. 底部 tab bar

### `deep-link-handoff`

1. 轻量状态图标或中性 loading
2. 当前跳转说明
3. 失败时单一回退动作

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 正常展示底部导航与活动模块页面 |
| loading | 启动分发骨架或轻量 loading shell |
| empty | 不适用 |
| error | 根级错误页或可恢复提示层 |
| permission | 路由到授权引导或顶部提示 |
| partial_data | 允许进入 today，但在页面内部提示部分数据不可用 |
| disabled | 某些 tab 或全局入口不可点击 |
| success | 登录恢复、同步恢复、购买恢复后的成功反馈 |
| locked_or_premium | 某些深链目标需在 feature 内展示锁定态，而不是壳层拦截 |

## Redirect 决策矩阵

| 条件 | 落点 |
| --- | --- |
| 首次进入且未完成引导 | onboarding-activation |
| 已完成引导且存在 today 所需基础配置 | today |
| 通知深链指向 bedtime 且 bedtime 条件满足 | bedtime |
| 小组件深链指向 today 摘要 | today |
| 登录恢复或购买恢复完成后需要回流 | 保持当前 tab，展示全局成功反馈 |
| 根级状态读取失败 | app-shell error shell |

## 详细状态矩阵

| 场景 | 触发条件 | 视觉表现 | 用户下一步 |
| --- | --- | --- | --- |
| startup_loading | 冷启动初始化中 | 居中轻量 loading | 等待 |
| startup_redirecting | 已确定目标路由，等待跳转 | 短暂过渡态 | 等待 |
| startup_failed | bootstrap 或关键状态读取失败 | 错误说明 + 重试按钮 | 重试 |
| tab_idle | 常规使用中 | 固定底部 tab + 当前 feature 内容 | 切换 tab 或继续当前任务 |
| deep_link_resolving | 通知 / widget 深链解析中 | 过渡态，不显示复杂业务内容 | 等待 |
| deep_link_blocked | 深链缺少前置条件 | 回退说明 + 返回默认落点 | 回到 today 或 onboarding |
| overlay_success | 登录恢复 / 购买恢复成功 | 顶部或浮层成功反馈 | 继续当前页 |
| overlay_warning | 同步或配置状态需注意 | 非阻断 banner | 查看或忽略 |
| overlay_error | 非致命全局错误 | 错误 banner / toast | 重试或稍后处理 |

## 结构语义

- scroll_model：`fixed zone`
- list_model：`static block`
- overlay_model：`mixed`
- layout_model：`layered`
- sticky_model：`sticky footer`
- component_repeatability：
  - 底部 tab item
  - 根级 app bar / 顶部留白策略
  - 全局错误 / loading 覆层
  - 深链过渡提示层

## 模块级非页面组件骨架

- `shell-tab-item`
  - 用途：底部一级入口
  - 状态：active / inactive / badge / disabled
  - 复用边界：整个产品共享
  - 设计冻结预期：是
- `startup-gate-view`
  - 用途：冷启动分发
  - 状态：loading / redirecting / failed
  - 复用边界：仅壳层
  - 设计冻结预期：是
- `global-overlay-host`
  - 用途：全局 toast、恢复购买反馈、同步状态反馈
  - 状态：info / success / warning / error
  - 复用边界：跨模块共享
  - 设计冻结预期：是
- `deep-link-handoff-state`
  - 用途：通知 / 小组件深链承接时的短暂过渡
  - 状态：resolving / ready / blocked
  - 复用边界：仅壳层
  - 设计冻结预期：是

## 模块组件冻结边界

- 必须冻结：
  - 底部 tab 的结构、间距、图标-文案关系、active 语义
  - startup gate 的 loading / error / retry hierarchy
  - deep-link handoff 的 resolving / blocked hierarchy
  - overlay host 的优先级顺序：blocking error > success banner > info toast
- 允许调整：
  - icon library 具体实现
  - loading 指示器具体动画形式
  - overlay 进入/退出动画时长
- 不属于 app-shell 冻结范围：
  - 各 feature 页面自己的 header、卡片和业务列表
  - feature 内部 sticky header
  - feature 内部空态与错误态细节

## 设计源

- 共享设计基线：[global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- 共享主题：[light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)
- 最终确认视觉基线：[rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png)
- 模块预览证据：[app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
- taste constraints：暖白背景、低噪声卡片、深绿色主层级、单列长页语义、克制 CTA
- 模块预览：本轮已显式启用 `--preview` / `--perviewer`，当前只记录 `app-shell` 预览，不默认扩散到其他模块

## 设计冻结卡

- freeze_scope：`module_candidate_ready`
- 当前高保真重点：
  - 底部 tab 的 active/inactive/disabled 规则
  - 启动分发的 loading / redirect / error hierarchy
  - 深链进入 bedtime 或 today 时的壳层承接方式
  - 根级 overlay 的出现层级与消失节奏
- fidelity_critical_regions：
  - 底部 tab bar
  - 顶部安全区与内容起始留白
  - deep-link handoff 的过渡语义
  - blocking error shell 的主说明与主动作关系

## 实现前明确结构语义

- `scroll_model`
  - shell 自身不滚动，滚动属于当前活动 feature 页面。
- `list_model`
  - app-shell 本身不拥有业务列表，只拥有 tab 和过渡状态。
- `overlay_model`
  - 允许 toast、banner、blocking error、恢复购买反馈。
- `layout_model`
  - 壳层使用固定容器 + 底部 sticky tab + 活动内容插槽。
- `sticky_model`
  - 只有 tab bar 是全局 sticky；feature 自己的 sticky header 不可覆盖 tab。

## 交互规则与回退路径

- 点击已激活 tab：
  - 默认回到该 tab 根栈顶，不重复 push 同一路由。
- 点击未激活 tab：
  - 切换到对应 branch，并保留该 branch 先前栈状态。
- 启动分发失败：
  - 只提供一个主动作 `重试`，不提供复杂分支。
- deep-link blocked：
  - 若引导未完成，回 onboarding
  - 若主链路可用但目标不可用，回 today
- overlay success：
  - 不抢占导航焦点，默认自动消失。

## 验收门槛

- UI/UX：根导航、tab 保持、启动分发状态清晰
- 模块设计冻结：底部导航、壳层反馈与重定向语义冻结
- 代码交接：go_router 根路由、tab shell、redirect policy 已明确

## 模块设计冻结接受条件

- 已存在至少一份模块静态预览证据
- 底部 tab、startup gate、handoff state、overlay host 都有明确状态定义
- root shell 与 feature shell 的职责边界无歧义
- 已明确哪些区域必须忠实保持，哪些区域只需语义一致

## 开放问题

- 匿名升级登录后，tab 栈是否需要保留当前位置还是重建到 today？
- 小组件 / 通知深链进入 bedtime 时，是否允许绕过 today 的默认 tab 高亮？
- root shell 是否需要在恢复购买成功后强制回流到 profile-settings，还是只展示全局反馈后留在当前页面？
