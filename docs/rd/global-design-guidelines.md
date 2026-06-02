---
artifact_type: global_design_guidelines
freeze_status: frozen
source_type: multi_screen_pack
theme_freeze_files:
  light: light-theme-freeze.yaml
  dark: dark-theme-freeze.yaml
---

## design_position

Rhythm 的全局设计定位是“温和克制的高信任作息行为管理工具”，而不是医疗监测面板、效率打卡器或情绪疗愈内容产品。界面需要传达的体验承诺是：用户在压力、疲劳或晚睡挫败状态下，仍然能迅速读懂当前结果、下一步动作和长期改善方向，并感受到产品在帮助自己“回到节奏”，而不是评判自己。

## product_personality

产品个性应稳定保持以下特征：

- 冷静：通过低饱和蓝绿主色和大面积暖中性色背景建立稳定感。
- 克制：装饰存在，但只服务空间层级和呼吸感，不服务“炫技”。
- 轻奢但不张扬：留白、柔和边界、细线图标和细致字号层级共同构成高级感，而不是靠强对比或复杂纹理。
- 可信：卡片、摘要、单日数据、统计块都以清晰解释优先，不以视觉戏剧化抢占主任务。
- 可回访：每一屏都保留一个清晰下一步，不把用户困在信息欣赏或重装饰空壳里。

最应保持的可记忆视觉特征是：

- 暖白纸感背景 + 低饱和深海松石主色
- 大留白与细边框卡片
- 圆点/圆环式轻量状态语言
- 无强光泽、无玻璃炫光、无大面积渐变的平静高级感

## target_users_and_core_scenarios

目标用户是长期晚睡、愿意调整节奏但不希望被羞辱式监督的人群。典型使用场景包括：

- 睡前：用户已经疲劳，注意力稀缺，需要一个低刺激、低负担的收尾动作。
- 次日早晨或白天：用户希望快速知道昨晚相对目标偏移了多少，以及今天应该怎么补救。
- 周中或周末复盘：用户希望通过长期趋势和稳定度理解自己，而不是只看一堆冷数据。
- 高意图升级时刻：用户已经感受到价值，愿意为更深入的恢复计划、长期趋势和高级策略付费。

全局界面必须优先优化：

- 快速扫描
- 情绪不过载
- 状态解释清晰
- 触控目标舒适
- 低认知成本的继续动作

## global_experience_principles

- 永远先告诉用户“现在发生了什么”，再告诉用户“接下来做什么”。
- 所有主页面首屏都必须有一个单一主焦点，不允许多个同权重视觉主角竞争。
- 晚睡反馈是恢复入口，不是惩罚入口。
- 高级能力的价值表达应以“持续改善”叙事承接，而不是以“你看不到更多图表”施压。
- 权限、同步、数据缺失和锁定状态都必须是被设计过的一等状态，不能只靠 toast 或灰字补丁。
- 视觉上的平静感优先于密度堆叠；空间留白是功能性的，不是装饰性的。

## information_hierarchy_principles

- 每个核心页面的阅读顺序固定为：页面身份 -> 当前结果/当前任务 -> 下一步动作 -> 支撑解释 -> 次级管理入口。
- 首屏一级信息只允许出现一个：倒计时、热力图焦点、周达标率、昨晚结果等，其余内容必须降为二级卡片。
- 二级信息使用卡片或显式分区承载，不允许靠字号微小差异硬分层。
- 统计数字应与解释文案共生出现；数字不单独裸露成“装饰性 KPI”。
- 锁定/高级内容必须在视觉上明显晚于已可用内容出现，避免误导用户以为主功能被阻断。

## layout_and_page_structure_principles

- 页面骨架以竖向单列为主，使用宽松边距和连续卡片流构成节奏。
- 顶部导航区保持轻量，标题与功能图标不做厚重头部条。
- 卡片是全局主结构单元，但卡片之间要通过外边距、内边距和细边框区分语义层级，不依赖重阴影。
- 核心主卡片可使用品牌色背景或浅色强调，但同屏只允许 1 个高强调面。
- 列表型内容使用“轻卡片 + 细分隔 + 足够呼吸”的方式承载，避免 dense dashboard 样式。
- 页底导航遵循 iOS HIG 触达基线，但图标与标签表现要更轻、更细、更克制。

## component_system_principles

- 组件家族应至少包括：主动作按钮、次动作按钮、摘要卡片、状态选择卡、轻量统计块、详情卡、底部导航、日期/热力单元、说明/锁定卡。
- 所有重复卡片都必须遵守统一的圆角族、边框强度、标题/正文间距和信息块节奏。
- 圆形状态元素是系统级语言，可用于热力点、完成状态、轻选择器，但不能任意演化成高装饰图形。
- 图标使用细线、低重量、轮廓优先的姿态，避免厚重填充图标体系。
- 高级/锁定卡可以使用暖色调强调，但不能破坏全局的平静主基调。

## interaction_behavior_principles

- 主按钮和主卡片点击区必须足够大，适合单手操作和疲劳状态点击。
- 交互反馈要克制清晰，优先用颜色、边框、轻位移和内容变化表达，不靠夸张动画。
- destructive 行为必须留在次级层或确认层，不得与主恢复动作并列。
- 底部导航行为稳定，不通过局部页面重写导航语义。
- 通知、小组件和首页回流时，应恢复到明确上下文，不让用户重新理解当前状态。

## state_and_feedback_principles

- `ideal`：保持轻、稳、可继续动作，不做过度庆祝。
- `loading`：优先局部 skeleton 或占位，不轻易整页遮罩。
- `empty`：解释“如何开始”，而不是展示无意义空容器。
- `error`：页内可恢复，语气中性，不用系统化恐吓色块。
- `permission`：先解释价值，再解释限制，始终保留可继续路径。
- `partial-data`：明确告诉用户缺了什么，以及当前还能做什么。
- `disabled`：使用透明度、边框和文案组合表达，不做彻底消失。
- `success`：是“你正在回到节奏”，不是“任务完成游戏化奖励”。
- `locked/premium`：先让用户理解已获得价值，再解释更深层内容为何值得升级。

## content_and_copy_principles

- 文案语气必须温和、直接、非命令式。
- 标题要短，说明文案只解释当前必要信息，不扩张成长段教育文本。
- 帮助文案优先回答“为什么我会看到这个”和“现在该做什么”。
- 警示和失败文案避免羞辱性词汇，不使用“失败”“必须”“立刻自律”等表达。
- 高级能力文案以“更深入理解、持续改善、长期回稳”为主，而不是“解锁更多功能列表”。

## visual_system_rules

- Typography：
  - 标题使用高对比衬线或衬线感标题风格，仅用于产品名、页面大标题、关键核心数字标题。
  - 正文与功能标签使用中性无衬线，确保移动端可读性和稳定性。
  - 大数字需要轻重量、宽呼吸、低压迫感，不使用粗黑体冲击。
- Spacing：
  - 采用宽松的 8pt 基础节奏，但核心卡片内边距倾向 20-24pt 区间。
  - 卡片与卡片之间间距必须明显，避免拥挤拼贴。
- Surface depth：
  - 主要靠暖背景与浅边框卡片形成层次。
  - 阴影非常轻，仅作为微弱悬浮提示，不构成主要分层手段。
- Color：
  - 品牌主色为低饱和深海松石系。
  - 成功与稳定倾向柔和青绿。
  - 偏移/风险倾向柔和珊瑚与暖橙，而不是高饱和红。
- Icon posture：
  - 细线、低重量、轻几何感，保持理性与安静。
- Illustration posture：
  - 当前视觉证据中没有系统级插画语言，全局规则冻结为 `not_provided`。
- Motion role：
  - 仅用于层级切换、状态确认和轻卡片反馈。
  - 不允许把炫技 motion 当作品牌记忆主手段。
- Decorative limits：
  - 不允许全局玻璃化、强渐变、霓虹描边、大面积拟物纹理。
  - 道具式静物氛围只属于静态预览表现，不能直接转译为运行时 UI 组件。

## light_theme_rationale

Light 主题采用温暖纸感背景、柔和白卡片和低饱和松石主色，是为了同时满足三件事：

- 保持作息产品需要的平静和信任，不落入医疗蓝白或效率工具冷硬感。
- 让热力图、倒计时、周报数字等核心信息在浅背景下获得高可读性而不刺眼。
- 通过暖中性底色配合冷静主色，形成“温和但有秩序”的商业级记忆点。

Light 模式下的暖色提醒与高级卡片强调都被压在较低饱和度，以防打破整体安静气质。

## dark_theme_rationale

Dark 主题不能简单反相。它应保留 light 主题的安静、克制与高信任气质，同时控制夜间阅读眩光。

因此 dark 主题采用：

- 暖冷平衡的深墨青背景，而不是纯黑；
- 分层清晰但不过亮的深色 surface band；
- 亮度抬高但饱和度仍克制的主色与状态色；
- 更柔和的 overlay 与 focus ring，避免夜间刺眼。

Dark 模式的目标是让夜间使用更像安静灯下的仪表阅读，而不是霓虹高对比控制台。

## design_prohibitions

- 不得把品牌主色替换成高饱和蓝紫或强荧光色。
- 不得把核心页面重做成高密度 dashboard。
- 不得把晚睡反馈设计成羞辱、惩罚或红色警报式体验。
- 不得把静态预览里的环境静物、植物、书本等外部道具直接转译成应用内装饰资源。
- 不得把锁定内容视觉做得比已可用主内容更强势。
- 不得在局部页面自行改写全局卡片圆角、边框强度、标题层级和底部导航姿态。

## engineering_guardrails

- 运行时实现可以省略静态预览中的摄影级场景光影与外部道具氛围，但必须保留温暖背景、细边框卡片、主色节奏和层级克制。
- 允许为了适配动态内容长度而调整卡片高度，但不允许压缩全局留白节奏到“模板化列表密度”。
- 允许使用 Flutter 原生或自定义组件实现热力图、状态卡、统计块，但必须保持冻结的色义、边界和层级关系。
- Dark 主题不能从 light 主题自动算反色，必须显式映射到冻结文件中的语义值。
- 若后续某个模块需要大幅突破当前视觉系统，必须回到全局冻结流程，而不是局部自行扩展。

## downstream_reference_index

- `flutter-design-freeze-gate`
  - 必须核验本文件 metadata block、全部 section 顺序，以及 [light-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/dark-theme-freeze.yaml) 的 concrete leaf values。
- `design-preview-to-pen`
  - 必须引用：`layout_and_page_structure_principles`
  - 必须引用：`component_system_principles`
  - 必须引用：`visual_system_rules`
  - 必须引用：`design_prohibitions`
  - 必须引用：`engineering_guardrails`
  - 必须引用主题文件：[light-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/dark-theme-freeze.yaml)
- `flutter-pen-to-architecture`
  - 必须引用：`information_hierarchy_principles`
  - 必须引用：`component_system_principles`
  - 必须引用：`visual_system_rules`
  - 必须引用主题文件中的全部 role families
- `flutter-design-source-control`
  - 必须将本文件和两个主题冻结文件加入冻结源优先级，并把任何改动请求回路由到本技能加 `flutter-design-freeze-gate`
- `flutter-design-parity-reviewer`
  - 必须对照：`global_experience_principles`
  - 必须对照：`state_and_feedback_principles`
  - 必须对照：`visual_system_rules`
  - 必须对照主题文件中的 `component_state_roles` 与 `contrast_rules`
