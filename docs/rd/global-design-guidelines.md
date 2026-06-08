---
artifact_type: global_design_guidelines
freeze_status: frozen
source_type: multi_screen_pack
platform_identifier: ios_device
module_preview_policy:
  module_refinement_default: no_generate
  perviewer_opt_in: disabled
  generated_module_preview_paths: []
theme_freeze_files:
  light: light-theme-freeze.yaml
  dark: dark-theme-freeze.yaml
---

## design_position

Rhythm 是一个恢复优先、任务优先的作息行为管理产品，不是医疗诊断工具，也不是内容型助眠应用。它的界面承诺是：用户在疲劳、拖延或偏移之后，依然能在很短时间内看懂“现在该做什么”，并以低羞耻感的方式回到节奏。

## product_personality

产品个性应保持冷静、克制、可信、略带编辑感，但不冷漠。视觉密度偏低到中低，情绪表达偏平稳，避免激烈夸张。记忆点来自清晰的首屏任务层级、精致但克制的容器层次、轻量悬浮的公共壳层，以及一致的安静邀请型 CTA。

## target_users_and_core_scenarios

目标用户是长期晚睡、希望主动调整作息的年轻成人，尤其适用于疲劳、注意力有限、又不希望被高压管理的人群。核心场景包括：

- 今晚打开首页，快速理解下一步行动
- 第二天查看昨晚结果与恢复建议
- 用日历页回看长期节奏，不被数据压迫
- 在洞察页理解周趋势与恢复计划
- 在我的页处理权限、同步、会员和目标配置

界面必须优先优化：疲劳状态下的快速扫读、单手操作、低压迫反馈、以及本地优先的连续可用性。

## global_experience_principles

- 首先帮助用户完成当前任务，而不是先展示统计或商业承接。
- 所有主页面都必须让用户先知道“我在哪里”和“我现在能做什么”。
- 导航是可靠的壳层，不是主角。
- 权限、同步、数据缺失和锁定态都要透明、可继续，不做无意义中断。
- 当前冻结目标面是 `ios_device`，后续实现与审查不得把 `iOS HIG` 误当成“任意移动端都差不多”。

## information_hierarchy_principles

全局信息层级固定为：

1. 今晚行动或当前主任务
2. 最近结果摘要
3. 恢复建议或下一步 guidance
4. 轻量趋势或模式理解
5. 次级配置、会员与补充入口

首屏 CTA 必须在 3 秒内可见或可预测地发现。任何图表、会员提示、历史概览都不得压过首屏主任务。标题层级统一而明确：页面标题负责“在哪里”，主卡标题负责“现在做什么”，标签/眉题负责“这块信息是什么”。

## layout_and_page_structure_principles

页面结构采用手机优先的纵向单主轴布局。共享主页面遵循同一壳层骨架：

- 顶部状态区
- 页面标题与简短引导说明
- 主内容区
- 底部共享主导航

内容区遵循“大主块 + 少量支持块”的结构，不做均权卡片网格。容器之间依靠留白、轻描边和轻阴影区分，而不是厚重边框或强装饰背景。卡片、趋势区、热力图区都要从容器外缘向内留出一致内边距，避免信息贴边。

## component_system_principles

共享组件系统分为四类：

- 壳层类：状态栏、底部主导航
- 行动类：主行动卡、主按钮
- 反馈类：摘要卡、恢复卡、趋势预览、状态芯片
- 配置类：设置行、输入容器、锁定提示

所有共享组件必须复用同一主题系统、圆角系统、标签字体系统和对比规则。允许存在模块私有组件，但它们不得重写全局 CTA 姿态、导航语言或全局信息层级。

## global_public_component_freeze

当前冻结的全局公共组件集合如下：

- `Status Bar Component`
- `Shared Tab Bar`
- `Primary Action Card`
- `Summary Card`
- `Recovery Card`
- 全局主按钮样式
- 全局设置行样式
- 全局状态标签样式

全局允许状态 / 变体：

- 主导航：默认 / 激活
- 主按钮：默认 / 禁用 / 锁定提示共存
- 卡片：主任务 / 摘要 / 恢复 / 普通信息
- 标签：中性 / 警示 / 信息辅助

不可变项：

- 五个主 tab 的顺序、名称与主语义
- 今晚行动优先于结果摘要的首屏结构
- 主按钮的安静邀请型存在感
- 标签使用更精细的 caption 风格，而不是回退到普通 body 样式

允许的工程调整：

- 轻阴影可进一步弱化为更浅的阴影或更轻描边
- 热力图、趋势柱的内部绘制可 Flutter 化
- 字体最终可映射到同气质系统字体栈，但不能回退到普通默认网页字体气质

明确不属于全局共享层的内容：

- 模块内部的复杂状态选择器
- 深度付费解释页的局部内容排版
- 具体周报/恢复细项的模块私有组合件

## interaction_behavior_principles

- 主操作必须明显，但不命令式。
- 次操作必须退后，不与主操作竞争。
- 危险性或破坏性动作要明确降级，不可和主任务样式混用。
- 主导航只用于顶层目的地切换，不承载页内局部操作。
- 手势和切换反馈应安静、平滑、可预测，不做戏剧化动画。
- 权限请求、同步失败、锁定提示都应给出继续路径，而不是只给终止提示。

## state_and_feedback_principles

系统必须完整覆盖：

- ideal
- loading
- empty
- partial_data
- disabled
- success
- warning
- error
- permission_denied
- premium_locked

这些状态的共同体验要求是：清晰、低压迫、可恢复。加载态应像结构骨架，不像随机等待。错误态必须帮助恢复。警示态表达“需要注意”，不是“你失败了”。恢复态必须传达“接下来怎么做”，而不是只描述偏移。

## content_and_copy_principles

文案语气必须非医疗、非训诫、非游戏化。标题短而清楚，说明句服务行动而不是堆解释。按钮文案应该像轻推一步，例如“开始慢慢收尾”，而不是“立即执行”。错误、空态、恢复建议的用词都应减少羞耻感，保持冷静和可信。

标签命名与状态命名必须稳定、语义化，例如 `recovery path`、`last night`、`pattern note` 这类提示词可以保留，但不能混入营销式夸张文案。

## visual_system_rules

- 字体梯度：
  - 页面标题使用 `Geist` 级别的高可读显示字体
  - 正文与说明使用 `Geist` 级别的干净 Grotesk
  - 标签与细节信息使用 `IBM Plex Mono` 级别的精细 caption 风格
- 对比策略：
  - 主要标题与主要行动保持最高对比
  - 摘要说明次一级
  - 眉题和 caption 作为第三层级
- 间距：
  - 页面级垂直间距偏大
  - 卡片内边距统一充足
- 表面深度：
  - 轻背景 + 更白的卡片面 + 极轻阴影
  - 不使用重玻璃、霓虹或过深投影
- 图标姿态：
  - 细线、精确、轻量
  - 不允许厚重、卡通、装饰性过强的图标
- 动效角色：
  - 只服务状态反馈、导航连续性和 CTA 触感
  - 不作为装饰噱头
- 装饰上限：
  - 不允许大面积渐变
  - 不允许多重厚边框
  - 不允许页面为了“高级感”堆圆角、阴影、发光

## light_theme_rationale

Light 主题采用冷白背景、微蓝灰容器与矿物青主强调，是为了同时保留三件事：清醒感、医疗距离感、和恢复导向的低压迫体验。主按钮需要一眼可见，但不能像警报一样跳出；摘要卡和恢复卡需要有层次，但不能像被重度设计包装的营销组件。浅暖恢复卡只在需要时提供温度差异，用来表达恢复路径而不是消费装饰。

## dark_theme_rationale

Dark 主题不是简单反相，而是保留语义层级后的低眩光版本。背景应转为深墨蓝黑而不是纯黑，表面之间依靠略有层次的深色区分。主强调色继续维持矿物青识别度，但亮度要受控，避免发光感。警示与错误色在暗色中仍需清晰，但不能变成霓虹噪声。文字和图标对比必须稳定，不能为了“高级暗色”牺牲可读性。

## design_prohibitions

- 不得把首页重新做成结果报告页或仪表盘。
- 不得让会员入口、统计图或历史摘要压过今晚行动。
- 不得重写五个主 tab 的顺序、名字或主语义。
- 不得把全局标题体系改成普通默认网页字体感。
- 不得把状态色当成唯一语义来源。
- 不得把当前冷静、恢复优先的方向改写成梦境疗愈、科技炫光或硬核效率产品。

## engineering_guardrails

- 可以弱化阴影、模糊和浅质感，但不能破坏当前层级关系。
- 可以 Flutter 化热力图、趋势柱和设置列表的具体实现，但必须保留主次结构和对比意图。
- 可以按平台字体可用性映射到同气质字体栈，但不能回退到视觉上更廉价、更普通的默认方案。
- 可以简化细节装饰，但不能改变 CTA 优先级、标题层级和壳层一致性。
- 模块阶段默认不生成新预览，除非显式开启 `--perviewer`。

## downstream_reference_index

- `flutter-design-freeze-gate`
  - 必须引用：
    - `global_public_component_freeze`
    - `visual_system_rules`
    - `design_prohibitions`
    - `engineering_guardrails`
    - `light-theme-freeze.yaml`
    - `dark-theme-freeze.yaml`
- `flutter-design-source-control`
  - 必须引用：
    - `layout_and_page_structure_principles`
    - `component_system_principles`
    - `interaction_behavior_principles`
    - `design_prohibitions`
- `flutter-uiux-to-architecture`
  - 必须引用：
    - `information_hierarchy_principles`
    - `layout_and_page_structure_principles`
    - `global_public_component_freeze`
    - `light-theme-freeze.yaml`
    - `dark-theme-freeze.yaml`
- `flutter-rd-module-splitter`
  - 必须引用：
    - `global_experience_principles`
    - `component_system_principles`
    - `global_public_component_freeze`
    - `engineering_guardrails`
