---
artifact_type: global_design_guidelines
freeze_status: frozen
source_type: multi_screen_pack
platform_identifier: ios_device
module_preview_policy:
  module_refinement_default: no_generate
  perviewer_opt_in: enabled
  generated_module_preview_paths: []
theme_freeze_files:
  light: light-theme-freeze.yaml
  dark: dark-theme-freeze.yaml
---

## design_position

Rhythm 是一个面向长期晚睡用户的作息行为管理产品，不是医疗诊断工具，也不是内容型助眠应用。当前共享设计的体验承诺是：让用户先平静地读懂昨晚发生了什么，再在没有羞耻感的前提下进入今晚的一个小动作。UI 必须传达“我可以理解、可以继续、可以轻一点回到节奏”，而不是“我又失败了”。

## product_personality

产品个性应保持安静、克制、可信、有秩序，并带一点编辑式高级感，但不做情绪化疗愈，也不做效率工具式压迫。视觉密度偏低，留白明显，结果卡的阅读感强于操作面板感。记忆点来自大结果排版、暖中性表面、低刺激导航和有礼貌的 CTA，而不是来自花哨装饰、强动效或高饱和色彩。

## target_users_and_core_scenarios

目标用户是长期晚睡、希望主动调整作息的年轻成人，尤其适用于疲劳、后悔、注意力有限、但又不想被高压管理的人群。核心场景包括：

- 早上打开首页，先读懂昨晚偏移了多少
- 看见今晚目标和收尾时间，知道今晚该怎么收一点
- 在睡前页快速选择今晚状态，不被复杂输入拖住
- 在洞察页理解本周稳定度、主要拖延原因和恢复方向
- 在我的页处理同步、权限、会员和作息设置，但不让配置抢主任务

界面必须优先优化：疲劳状态下的快速扫读、低压迫反馈、结果先读懂、以及本地优先的连续可用性。

## global_experience_principles

- 全局优先帮助用户理解和恢复，而不是先展示统计、会员或历史档案。
- 所有主页面都必须先回答“我现在处于什么状态”和“我接下来该做什么”。
- 当前冻结目标面是 `ios_device`，后续实现与审查必须按真实 iPhone 设备体验验证，不得把 `iOS HIG` 误当作泛移动基线。
- 权限、同步、缺失数据和锁定态都必须透明且可继续，不制造死路。
- 晚睡反馈必须温和但真实，既不粉饰，也不惩罚。

## information_hierarchy_principles

全局信息层级固定为：

1. 昨晚结果或当前已发生的核心状态
2. 今晚目标时间与收尾边界
3. 下一步动作或恢复建议
4. 轻量趋势、模式理解或周理解
5. 次级配置、会员与补充入口

`Today` 页的首屏阅读顺序不可被下游重写。首屏的主结果卡必须成为第一视觉重心，且大字排版应显著强于辅助说明。CTA 不要求在视觉上压倒结果卡，但必须在结果与目标之后自然出现，并保持清晰可达。标题层级固定为：页面标题负责“我在哪”，结果卡大字负责“发生了什么”，辅助说明负责“接下来如何理解或行动”。

## layout_and_page_structure_principles

页面结构采用手机优先的纵向单主轴布局。共享主页面遵循同一壳层骨架：

- 顶部状态区
- 页面标题与一句轻说明
- 结果 / 目标 / 动作主内容区
- 底部共享主导航

内容区采用“大主块 + 少量支持块”的顺序，不做均权网格，也不做层层卡片套娃。留白应承担主要分组责任，容器只在语义需要时出现。结果卡、目标卡、动作卡和趋势卡之间必须有清晰间距，避免像紧凑数据列表。表面区分优先使用背景值差、轻描边与极轻阴影，不使用厚边框、重玻璃或强渐变。

## component_system_principles

共享组件系统分为四类：

- 壳层类：状态栏、底部主导航
- 结果类：结果卡、目标卡
- 行动类：下一步动作卡、主按钮
- 支持类：恢复建议卡、趋势卡、状态标签、设置行

所有共享组件必须复用同一主题系统、圆角族、字体梯度和对比策略。允许模块拥有私有组合件，但不得重写全局结果优先层级、CTA 姿态、导航语言或暖中性表面规则。全局允许的组件变体应保持克制，不通过单页特殊风格制造额外视觉语言。

## global_public_component_freeze

当前冻结的全局公共组件集合如下：

- `Status Bar Component`
- `Shared Tab Bar`
- `Summary Card`
- `Recovery Card`
- `Primary Action Card`
- 全局主按钮样式
- 全局状态标签样式
- 全局设置行样式

全局允许状态 / 变体：

- 结果卡：结果主陈述 / 普通摘要
- 目标卡：目标时间 / 支持说明
- 动作卡：下一步动作 / 睡前动作
- 主按钮：默认 / 禁用 / 锁定提示共存
- 标签：中性 / 提醒 / 风险辅助
- 主导航：默认 / 激活

不可变项：

- `Today / Calendar / Bedtime / Insights / Profile` 的 tab 顺序、名称与主语义
- `Today` 页首屏的结果优先阅读顺序
- 结果卡的大字排版与低压迫气质
- CTA 的安静邀请型存在感
- 暖中性表面与低刺激导航姿态

允许的工程调整：

- 极浅阴影可进一步弱化为更轻阴影或轻描边
- 趋势柱、热力图、统计区的内部绘制可 Flutter 化
- 字体可映射到同气质的系统字体栈，但不能回退成普通廉价默认感
- 轻装饰质感可按性能需求压缩，但不能破坏结果卡主次关系

明确不属于全局共享层的内容：

- 模块内部复杂状态选择器
- 会员深度解释页的私有排版
- 周报 / 月报深层洞察的局部信息编排
- 模块级真实设备预览生成策略之外的临时装饰尝试

## interaction_behavior_principles

- 主操作必须清楚，但不能命令式。
- 次操作必须后退，不与主操作竞争。
- 底部导航只承担顶层目的地切换，不承载页内操作。
- 睡前页状态选择要快速、直接、单手可达，不靠隐藏手势完成主任务。
- 危险性或破坏性动作必须明确降级，不得与主任务样式混用。
- 过场、切换、按钮触感与反馈都应安静、平滑、可预测，不做戏剧化动效。

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

这些状态的共同要求是：清晰、低压迫、可恢复。加载态应像结构骨架，不像随意等待。空态必须保留下一步动作。警示态表达“需要注意”，不是“你失败了”。错误态必须给出继续路径。晚睡结果与恢复建议的表达必须真实但不羞辱。

## content_and_copy_principles

文案语气必须非医疗、非训诫、非游戏化。标题短、真、可读，不做营销式夸张。按钮文案应像轻推一步，例如“开始慢慢收尾”或“保护今晚的收尾”，而不是“立即执行”。空态、错误态、恢复态和锁定态都应减少羞耻感，帮助用户继续。

命名规则应稳定、语义化，例如：

- `last night`
- `tonight's target`
- `your next step`
- `recovery note`
- `partial sync`
- `premium locked`

不允许混入医疗承诺、纪律口号或焦虑型付费文案。

## visual_system_rules

- 字体梯度：
  - 页面标题使用干净高可读的 sans 标题字
  - 结果陈述与关键时间使用高对比 serif 展示字
  - 正文说明使用克制的 sans 正文字
  - 标签与辅助状态使用精细的 mono caption
- 对比策略：
  - 结果陈述为全局最高阅读对比
  - 页面标题与关键目标时间次之
  - 正文说明与 caption 退居第三层级
- CTA 对比姿态：
  - CTA 必须明显，但不能压过结果卡
  - 主按钮与辅助卡不得落入同一对比带
- 间距：
  - 页面级垂直间距偏大
  - 卡片内边距统一充足
  - 首屏结果卡与其他卡片间需保留呼吸感
- 表面深度：
  - 暖中性背景 + 更亮的卡片面 + 极轻阴影
  - 不使用重玻璃、霓虹或厚重深投影
- 图标姿态：
  - 细线、轻量、可读
  - 不允许厚重、卡通或装饰性过强的图标
- 动效角色：
  - 只服务状态反馈、导航连续性和按钮触感
  - 不作为气氛装饰
- 装饰上限：
  - 不允许大面积渐变
  - 不允许多重厚边框
  - 不允许为了“高级感”堆叠圆角、阴影、发光

## light_theme_rationale

Light 主题采用暖中性羊皮纸背景、浅米白卡片和鼠尾草绿 CTA，是为了让产品从“冷静恢复”进一步收束到“安静秩序”。这套值让结果卡可以像安静的阅读面而不是数据仪表盘，同时保留足够对比来支撑大结果文字、目标时间和 CTA。琥珀与珊瑚只承担偏移和提醒语义，不承担装饰角色。

## dark_theme_rationale

Dark 主题不是浅色反相，而是保留同一语义结构后的低眩光版本。背景应转为深褐黑与墨橄榄之间的暖暗面，表面层级靠细微亮度差区分。主色仍然保持鼠尾草绿识别，但亮度受控，避免发光和科技感。风险与提醒色在暗色中必须可读，但不能变成霓虹噪声。结果陈述仍需维持清晰的阅读层级，而不是只剩高亮数字。

## design_prohibitions

- 不得把首页重新做成行动先于结果的旧链路。
- 不得让图表、会员入口或历史摘要压过结果卡。
- 不得把全局视觉再推回冷灰蓝医疗感。
- 不得把当前暖中性秩序方向改写成梦境疗愈、科技炫光或效率打卡产品。
- 不得把 serif 结果陈述降级为普通正文字层级。
- 不得把状态色当成唯一语义来源。

## engineering_guardrails

- 可以弱化阴影、轻质感和描边细节，但不能破坏结果优先层级。
- 可以 Flutter 化趋势柱、热力图和设置列表的具体绘制实现，但必须保留结构顺序和对比意图。
- 可以将字体映射到同气质系统字体栈，但不能丢失结果陈述与正文之间的气质差。
- 可以压缩局部装饰，但不能让 CTA 与次级按钮落入同一视觉带。
- 模块细化默认不生成新的真实设备预览。
- 当前工作流已获显式 `--perviewer` 授权，模块阶段允许进入生图分支。
- 当前冻结的模块预览策略为：
  - `module_refinement_default: no_generate`
  - `perviewer_opt_in: enabled`
  - `generated_module_preview_paths: []`

## downstream_reference_index

- `flutter-design-freeze-gate`
  - 必须引用：
    - `information_hierarchy_principles`
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
    - `engineering_guardrails`
    - `light-theme-freeze.yaml`
    - `dark-theme-freeze.yaml`
- `flutter-uiux-to-architecture`
  - 必须引用：
    - `information_hierarchy_principles`
    - `layout_and_page_structure_principles`
    - `global_public_component_freeze`
    - `visual_system_rules`
    - `light-theme-freeze.yaml`
    - `dark-theme-freeze.yaml`
- `flutter-design-parity-reviewer`
  - 必须引用：
    - `global_public_component_freeze`
    - `visual_system_rules`
    - `state_and_feedback_principles`
    - `light-theme-freeze.yaml`
    - `dark-theme-freeze.yaml`
- `flutter-workflow-orchestrator`
  - 必须引用：
    - `platform_identifier`
    - `module_preview_policy`
    - `global_public_component_freeze`
    - `engineering_guardrails`
