artifact_type: global_design_guidelines
freeze_status: frozen
source_type: preview_comp
platform_identifier: ios_device
module_preview_policy:
  module_refinement_default: no_generate
  perviewer_opt_in: enabled
  generated_module_preview_paths:
    - docs/project/modules/app-shell/app-shell-root-preview.png
theme_freeze_files:
  light: light-theme-freeze.yaml
  dark: dark-theme-freeze.yaml

## design_position

Rhythm 的冻结设计定位是“作息管理型移动产品”，不是睡眠报告工具，也不是情绪疗愈内容产品。它要传达的体验承诺是：用户打开首页后，能在极短时间内看清今晚睡眠窗口、当前睡前路径、偏离风险和恢复入口，并被引导进入一个明确、可执行、低羞耻感的下一步。

## product_personality

产品人格应长期保持安静、克制、可靠、秩序感强。视觉上以暖白背景、低噪声卡片层级、深绿色主文字和柔和橄榄/琥珀/珊瑚状态色维持稳定辨识度。密度属于“中低密度任务页”，重点不是展示尽可能多的信息，而是把晚间计划路径组织得清楚、自然、可继续。

## target_users_and_core_scenarios

主要用户是长期晚睡但愿意主动调整节律的移动端用户，首发验证面以 iPhone 真机为准。核心场景是：白天或傍晚查看今日作息目标，夜间跟随 wind-down 清单执行收尾动作，发现偏离时快速理解恢复建议，并在周视图中感知连续性与稳定度。界面必须优先优化“当前下一步”而不是“历史全量数据”。

## global_experience_principles

- 全局交互应始终围绕“先看今晚窗口，再看当前步骤，再看恢复/周视图”的顺序组织。
- 首页必须让用户不用解释就看懂主任务是什么，不能把图表、设置或会员内容放到第一优先级。
- 所有关键动作都要保持低摩擦、低装饰、强可读，不用视觉戏法换取高级感。
- 状态提示应偏说明式和引导式，不使用责备、医疗化或夸张激励语气。
- 当前冻结验证面是 `ios_device`，下游实现必须按 iPhone 真机的安全区、触达尺寸、滚动与反馈习惯来判断是否达标，不能把“移动端”当成模糊概念。

## information_hierarchy_principles

- 第一阅读层级：页面标题与日期、睡眠窗口主卡中的目标时间和时长。
- 第二阅读层级：Wind-down 清单区块标题、开始时间胶囊、当前步骤标题与时间。
- 第三阅读层级：恢复说明、周视图总结、次级描述文案。
- 主 CTA 在本方向里不是显眼的大按钮，而是通过当前任务列表与“Use recovery plan”这类高对比文字动作完成；因此 CTA 优先级要通过位置、字重、颜色和临近留白保证清晰。
- 数字、时间和窗口边界必须始终比解释性文案更显眼。

## layout_and_page_structure_principles

- 页面骨架固定采用手机单列长页结构：顶部页头 -> 核心 summary 卡 -> 任务列表卡 -> 恢复卡 -> 周视图卡。
- 每个大区块使用独立卡片承载，卡片之间用明确但不夸张的垂直间距分隔。
- 页面背景保持大面积暖白净空，卡片使用更亮的白色/奶白色，以细边框而不是重阴影建立层级。
- 卡片内部布局强调“左内容右状态/时间”规则，保证扫描稳定。
- 周视图区块允许承载更多信息，但仍要服从相同的左右对齐逻辑和底部摘要逻辑。

## component_system_principles

- 全局共享组件家族至少包括：页面页头、内容卡片、睡眠窗口进度条、wind-down 行项目、状态胶囊、恢复提示卡、周视图状态圆点、底部摘要统计行、图标圆底座。
- 共享组件默认只允许轻量变体，不允许在不同页面中改成完全不同的形状体系。
- 行项目、卡片标题、时间标签、状态圆点必须跨页面复用相同的间距和字号逻辑。
- 图标始终服务于状态辨识和任务扫描，不应成为插画式装饰主角。

## global_public_component_freeze

- 属于全局共享层的组件家族：
  - 页面页头：大标题、日期、副操作圆形按钮。
  - 标准内容卡：浅边框、大圆角、暖白底、左主信息右辅信息布局。
  - 睡眠窗口卡：双栏数字信息 + 水平进度/区间条。
  - Wind-down 列表项：左图标底座、中间标题/副标题、右时间。
  - 状态胶囊：暖色轻底、图标 + 文案，承载开始时间或提醒。
  - 恢复卡：左说明、右状态图标，底部留主操作文本。
  - 周视图状态点：成功/警示/失败/未完成四类圆点。
  - 底部摘要统计行：左右并列指标，中间细分隔线。
- 全局允许状态/变体：
  - 卡片：default、summary、warning_surface、success_surface。
  - 列表项：default、current_focus、muted_disabled。
  - 状态圆点：success、warning、error、empty。
  - 文本动作：primary_link、secondary_link。
- 下游不可更改的部分：
  - 卡片大圆角与浅边框体系。
  - 深绿色主文字与暖白背景的主对比关系。
  - 标题/时间/说明三层文字优先级。
  - Wind-down 行项目的三列信息结构。
  - 周视图圆点式状态表达。
- 允许工程侧在不回退设计的前提下调整的部分：
  - 图标具体库实现。
  - 进度条内部技术绘制方式。
  - 卡片内部文案换行细节，只要不改变层级与对齐。
  - 列表分隔线的实现方式。
- 明确不属于全局共享层的部分：
  - 某个模块私有的复杂图表。
  - 会员营销组件。
  - 深度设置表单的专有布局。

## interaction_behavior_principles

- 主交互姿态应始终是“顺着任务流继续”，而不是“做大量分支选择”。
- 二级动作必须克制，不与主任务竞争视觉中心。
- 文本型动作可以使用主绿色，但只能出现在已建立语义上下文的卡片底部或说明结尾。
- 危险/破坏性动作不应出现在首页主路径里；若未来出现，必须显著区别于恢复与引导动作。
- 图标按钮默认使用低存在感圆底，避免抢占主卡片信息层级。

## state_and_feedback_principles

- 理想态：清晰展示目标窗口、步骤列表、周表现，整体平静有序。
- 加载态：保持卡片骨架和行项目骨架，不允许用与信息结构无关的抽象动画替代。
- 空态：优先解释“为什么现在没有数据”，并给出下一步动作，而不是只写“暂无数据”。
- 禁用态：使用更低对比的文字和图标，但仍保持可识别结构。
- 成功态：以深绿色和柔和浅绿底表达，不使用高饱和奖励式效果。
- 警示态：用琥珀色提示偏离或需要关注，但语气仍保持建设性。
- 错误/失败态：用偏珊瑚橙红提示风险或未达成，不制造威胁感。
- 恢复反馈必须强调“仍有可执行方案”，不能让失败态成为终点。

## content_and_copy_principles

- 文案语气应简洁、冷静、支持性强，不做医疗判断，也不做情绪表演。
- 标题尽量短，副标题只承担补充说明，不承担核心信息。
- 时间、窗口、任务名称应使用非常直接的命名，避免比喻式语言。
- helper text 和恢复说明应偏行动建议，而不是抽象说教。
- 空态、提醒态、恢复态中的词汇要让用户感觉“仍可继续”，而不是“已经失败”。

## visual_system_rules

- 字体层级：
  - 大标题使用高对比、大字号、较高字重。
  - 卡片标题和主要数字保持清晰但不过度夸张。
  - 次级说明保持更浅色和更低字重。
- 对比规则：
  - 主文字与背景必须保持稳定强对比。
  - 卡片边框只承担结构分隔，不承担主强调。
  - CTA 型文本和主状态必须与次级说明拉开明显层级。
- 间距规则：
  - 使用统一 8pt 系列节奏，卡片内边距明显大于列表项内边距。
  - 列表项之间靠细分隔线和垂直呼吸感组织，而不是卡片嵌套卡片。
- 深度规则：
  - 页面主要依靠底色差和细边框分层。
  - 阴影只能是极浅、极软、极弱的辅助，不允许玻璃化、发光或厚重投影。
- 图标规则：
  - 图标线条清晰、统一、偏圆角。
  - 图标底座保持低饱和浅色圆形或圆角方形承载。
- 装饰限制：
  - 不使用插画式大型背景装饰。
  - 不使用紫蓝渐变、霓虹高光、厚玻璃拟态。

## light_theme_rationale

当前冻结 light theme 直接服务于这张最终确认图：背景接近暖白纸面，卡片比背景略亮，主内容使用深墨绿色而不是纯黑，既保持对比，也保留健康、平静、秩序化的情绪温度。琥珀与珊瑚只在警示、偏离、失败相关语义里出现，使主绿色仍然稳定代表“目标、结构、继续前进”。

## dark_theme_rationale

dark theme 不是对 light theme 反相，而是保持同样的语义结构：深色背景、略亮表面、偏暖中性深灰作为主要层级，主绿色降低亮度对比冲击但保持可识别性，警示与错误色减少刺眼感。目标是在夜间场景中仍保留 calm planner 的稳定感，避免变成霓虹健康仪表盘。

## design_prohibitions

- 不得把首页主路径改成强营销或强数据看板结构。
- 不得改变“页头 -> 睡眠窗口 -> wind-down -> recovery -> this week”的主顺序。
- 不得把深绿色主文字改成纯黑或高冷蓝灰体系。
- 不得把 CTA 对比降到与普通说明文字同一层级。
- 不得用大面积插画、渐变、发光、玻璃态重写当前确认方向。
- 不得让周视图状态表达脱离圆点/简洁标记体系。

## engineering_guardrails

- 必须忠实保留：
  - 页面单列骨架。
  - 卡片大圆角 + 浅边框 + 暖白层级。
  - 主数字/时间的层级与位置。
  - Wind-down 行项目的结构和时间右对齐规则。
  - 周视图状态点与底部双指标摘要结构。
- 可以工程简化：
  - 极轻阴影可退化为仅边框层级。
  - 图标底座的微弱渐层可退化为纯色浅底。
  - 进度条内部纹理可退化为纯色/低对比 hatch。
- 需要回退设计控制的改动：
  - 任何主色、主对比、主层级变化。
  - 卡片系统改为扁平无边界列表。
  - 增加会打断主任务路径的大型插画或营销区。
- 模块预览策略冻结如下：
  - module refinement 默认不生成新真机预览。
  - 只有显式 `--perviewer` 才允许模块阶段新增预览。
  - 任何生成的模块预览路径都必须显式写回冻结文档，不能靠口头约定。

## downstream_reference_index

- `flutter-design-freeze-gate`
  - 必引：`global_public_component_freeze`、`visual_system_rules`、`design_prohibitions`
  - 必查文件：`light-theme-freeze.yaml`、`dark-theme-freeze.yaml`
- `flutter-uiux-to-architecture`
  - 必引：`layout_and_page_structure_principles`、`component_system_principles`、`visual_system_rules`
  - 必查文件：`light-theme-freeze.yaml`、`dark-theme-freeze.yaml`
- `flutter-design-source-control`
  - 必引：`design_prohibitions`、`engineering_guardrails`
  - 必查文件：`global-design-guidelines.md`、`light-theme-freeze.yaml`、`dark-theme-freeze.yaml`
- `flutter-design-parity-reviewer`
  - 必引：`information_hierarchy_principles`、`state_and_feedback_principles`、`visual_system_rules`
  - 必查文件：`light-theme-freeze.yaml`、`dark-theme-freeze.yaml`
- `flutter-workflow-orchestrator`
  - 必引：`global_experience_principles`、`engineering_guardrails`
  - 必查文件：`global-design-guidelines.md`
