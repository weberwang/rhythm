---
artifact_type: global_design_guidelines
freeze_status: frozen
source_type: multi_screen_pack
theme_freeze_files:
  light: light-theme-freeze.yaml
  dark: dark-theme-freeze.yaml
---

## design_position

Rhythm 的全局设计定位是“温和克制的高信任作息行为管理工具”，而不是医疗监测面板、效率打卡器或情绪疗愈内容产品。基于本轮三张共享静态预览图，界面需要稳定传达的体验承诺是：用户在疲劳、挫败或注意力稀缺时，仍能迅速看懂当前结果、下一步动作和更长期的改善方向，并感到自己正在被温和地带回节奏，而不是被监测、审判或催促。

## product_personality

产品个性应稳定保持以下特征：

- 冷静：通过低饱和深海松石主色与暖纸感背景建立稳定感。
- 克制：装饰只服务层级、呼吸感和情绪温度，不服务炫技。
- 可信：结果卡、建议卡、夜间动作卡都优先解释和引导，而不是制造视觉戏剧化。
- 温和：即使在明显晚睡、权限拒绝或锁定场景下，也不使用惩罚式表达。
- 可回访：每一屏都保留一个清晰下一步，不让用户停留在纯信息欣赏。

最应保持的可记忆视觉特征是：

- 暖白纸感背景
- 低饱和深海松石主色
- 柔和珊瑚作为高意图或风险偏移强调
- 高对比衬线大标题与轻量无衬线正文的组合
- 细边框卡片与明确但克制的表面分层

## target_users_and_core_scenarios

目标用户是长期晚睡、愿意调整节奏但不愿被羞辱式监督的人群。当前冻结方向主要为以下核心场景优化：

- 睡前：用户已疲劳，需要低刺激、低负担、单任务导向的收尾引导。
- 次日回访：用户希望 3 秒内知道昨晚结果、今晚目标和现在该做什么。
- 周期性复盘：用户需要长期趋势与恢复解释，但不能被高密度 dashboard 吓退。
- 高意图升级时刻：用户已感知价值，愿意为更深入的恢复计划、长期趋势和高级策略付费。

全局界面必须优先优化：

- 快速扫描
- 低认知负担
- 主动作可发现性
- 状态解释清晰
- 单手触达舒适
- 日间与夜间都可稳定阅读

## global_experience_principles

- 永远先告诉用户“现在发生了什么”，再告诉用户“接下来做什么”。
- 每个核心页面首屏只允许一个主焦点，不允许多个同权重视觉主角竞争。
- 晚睡反馈是恢复入口，不是惩罚入口。
- 睡前场景优先低刺激、低步骤、低信息密度，而不是丰富内容呈现。
- 高级能力必须在用户已理解基础价值后出现，不打断激活或主闭环。
- 权限、同步、数据缺失和锁定状态都必须是被设计过的一等状态，不能只靠 toast 或灰字补丁。
- 引导、首页、睡前、洞察之间必须共享相同的情绪温度和 CTA 优先级逻辑。

## information_hierarchy_principles

- 页面阅读顺序固定为：页面身份 -> 当前结果/当前任务 -> 下一步动作 -> 支撑解释 -> 次级管理入口。
- 首屏一级信息只允许出现一个：欢迎价值、昨晚结果、距离目标时间、当前周期结论等，其余内容必须降为二级卡片。
- 一级 CTA 必须在三秒内可被识别，且视觉强度明显高于说明、管理和会员次入口。
- 统计数字不能裸露成装饰性 KPI，必须与解释文案共生出现。
- 次级信息必须通过卡片、分区或明显留白降权，而不是靠字号微调硬分层。
- 锁定/高级内容必须明显晚于已可用内容出现，避免用户误以为主功能被阻断。

## layout_and_page_structure_principles

- 页面骨架以竖向单列为主，使用连续卡片流和宽松边距建立节奏。
- 顶部导航区保持轻量，标题与功能图标不做厚重栏位。
- 大多数页面遵循“1 个 dominant zone + 1 个 secondary zone + 1 个 support zone”的骨架。
- 卡片是主结构单元，但卡片之间依靠外边距、内边距、细边框和轻微表面差异分层，不依赖重阴影。
- 同屏只允许 1 个高强调面，通常是主结果卡或主动作按钮；其他卡片必须退后。
- 页底导航遵循 iOS HIG 的位置与触达预期，但图标与标签表现保持轻细克制。
- 夜间页面可以更沉浸，但必须保留卡片边界和读写对比，不允许整屏糊成一个暗色平面。

## component_system_principles

- 共享组件家族至少包括：主动作按钮、次动作按钮、结果摘要卡、目标/建议卡、说明卡、轻量状态徽记、列表行、底部导航、输入框、锁定说明卡。
- 结果卡、建议卡和轻量说明卡都属于同一共享表面系统：统一圆角、边框强度、标题/正文间距和留白节奏。
- 组件默认走轻量分层路线：细边框优先，阴影只作辅助。
- 图标统一使用细线、低重量、轻几何姿态。
- 主按钮允许更强对比和更完整色块，次按钮只允许浅表面或描边，不与主按钮争主次。
- 夜间和日间必须共享相同的组件语义，而不是同一个组件在 dark 模式下改成另一种权重体系。

## global_public_component_freeze

- 共享全局公共组件集包括：
  - `primary_button`
  - `secondary_button`
  - `result_summary_card`
  - `support_card`
  - `input_field`
  - `tab_bar`
  - `status_badge`
  - `locked_explanation_card`
- 全局允许的状态或变体包括：
  - `primary_button`: default, pressed, disabled
  - `secondary_button`: default, pressed, disabled
  - `input_field`: default, focused, disabled, error
  - `card`: default, accent, locked, disabled
  - `status_badge`: neutral, success, warning, error, info
- 下游 Flutter 不可改变的部分：
  - 主 CTA 与次 CTA 的对比带宽
  - 卡片边界存在感
  - dominant / secondary / support 的视觉分层关系
  - 衬线大标题 + 无衬线正文的全局排版梯度
  - 日间暖纸感与夜间深墨青的双主题方向
- 工程允许的调整包括：
  - 因多语言导致的卡片高度弹性变化
  - skeleton 细节、分隔线细节、图标具体库实现
  - 局部插画或静物氛围在运行时被省略
- 明确不属于全局共享层的部分：
  - 模块私有的图表细节
  - 模块私有的运营卡片排布
  - 任何仅服务某一业务流的单次装饰组件

## interaction_behavior_principles

- 主按钮和主卡片点击区必须足够大，适合疲劳状态和单手操作。
- 交互反馈要克制清晰，优先用颜色、边框、轻位移和内容变化表达。
- 破坏性行为必须放在次级层或确认层，不能与主恢复动作并列。
- 底部导航语义稳定，不能被局部页面重写成促销或流程跳板。
- 通知、小组件和首页回流时，必须恢复到明确上下文，不让用户重新理解当前状态。
- 夜间模式下动效更克制，优先减少刺激，而不是增强沉浸炫光。

## state_and_feedback_principles

- `ideal`：轻、稳、可继续动作，不做过度庆祝。
- `loading`：优先局部 skeleton 或占位，不轻易整页遮罩。
- `empty`：解释“如何开始”，而不是给空容器。
- `error`：页内可恢复，语气中性，不使用系统化恐吓色块。
- `permission`：先解释价值，再解释限制，始终保留可继续路径。
- `partial-data`：明确说明缺了什么，以及当前还能做什么。
- `disabled`：使用透明度、边框和文案组合表达，不做彻底消失。
- `success`：是“你正在回到节奏”，不是“任务完成奖励”。
- `locked/premium`：先让用户理解已获得的价值，再解释更深层内容为何值得升级。

## content_and_copy_principles

- 文案语气必须温和、直接、非命令式。
- 标题要短，说明文案只解释当前必要信息，不扩张成长段教育文本。
- 辅助文案优先回答“为什么我会看到这个”和“现在该做什么”。
- 失败、延迟、无数据文案避免羞辱性词汇，不使用“失败”“必须”“立刻自律”等表达。
- 高级能力文案以“更深入理解、持续改善、长期回稳”为主，而不是“解锁更多功能列表”。
- 睡前场景文案必须更短、更静、更少判断性。

## visual_system_rules

- Typography：
  - 大标题与关键数字使用高对比衬线或衬线感标题风格。
  - 正文、按钮、标签和说明使用中性无衬线。
  - 结果数字需轻重量、宽呼吸、低压迫感，不使用粗黑冲击。
- Reading contrast：
  - 正文与背景、正文与卡片、主 CTA 文本与主按钮之间必须维持高可读性。
  - CTA 对比度必须显著高于次按钮与支撑卡。
- Spacing：
  - 使用 8pt 基础节奏。
  - 核心卡片内边距优先 20-24pt。
  - 卡片与卡片之间间距必须明显，避免拥挤拼贴。
- Surface depth：
  - 主层次靠暖背景 / 深墨青背景与浅卡 / 深卡边界形成。
  - 阴影只作为微弱悬浮提示，不构成主要分层手段。
- CTA posture：
  - 日间可用深海松石或柔和珊瑚作主 CTA，但同屏只保留一个强强调 CTA。
  - 夜间主 CTA 可回到更稳定的青绿语义，避免高刺激亮橙。
- Icon posture：
  - 细线、低重量、轻几何感，保持理性与安静。
- Illustration posture：
  - 允许静态预览里出现静物、月亮、暖光等氛围元素，但它们不自动成为运行时组件系统。
- Motion role：
  - 仅用于层级切换、状态确认和轻卡片反馈。
  - 不允许把炫技 motion 当作品牌记忆主手段。
- Decorative limits：
  - 不允许全局玻璃化、强渐变、霓虹描边、大面积拟物纹理。
  - 不允许让装饰静物压过主任务。

## light_theme_rationale

Light 主题采用暖纸感背景、柔和白卡片、深海松石主色和柔和珊瑚强调，是为了同时满足三件事：

- 保持作息产品需要的平静与信任，不落入医疗蓝白或效率工具冷硬感。
- 让首页结果卡、欢迎页主动作和恢复建议在浅背景下获得高可读性而不刺眼。
- 通过暖中性底色配合冷静主色，形成“温和但有秩序”的商业级记忆点。

## dark_theme_rationale

Dark 主题不能简单反相。基于睡前场景预览，它需要保留 warm calm 的产品气质，同时控制夜间眩光和视觉刺激：

- 采用深墨青背景而不是纯黑；
- 保留卡片与页面的层级边界；
- 主 CTA 亮度足够识别，但不进入霓虹区间；
- 风险与强调色在 dark 模式下降亮而不升饱和。

## design_prohibitions

- 不得把品牌主色替换成高饱和蓝紫或强荧光色。
- 不得把核心页面重做成高密度 dashboard。
- 不得把晚睡反馈设计成羞辱、惩罚或红色警报式体验。
- 不得把静态预览里的静物、月亮、植物、暖光直接转译成必须存在的运行时装饰资源。
- 不得把锁定内容视觉做得比已可用主内容更强势。
- 不得在局部页面自行改写全局卡片圆角、边框强度、标题层级和底部导航姿态。
- 不得把主 CTA 对比度降低到与次动作同一带宽。

## engineering_guardrails

- 运行时实现可以省略静态预览中的摄影级氛围和静物，但必须保留背景温度、边框强度、主色节奏和层级克制。
- 允许为了适配动态内容长度而调整卡片高度，但不允许压缩全局留白节奏到模板化列表密度。
- 允许使用 Flutter 原生或自定义组件实现热力图、状态卡、统计块，但必须保持冻结的色义、CTA 主次与层级关系。
- Dark 主题不能从 light 主题自动反算，必须显式映射到冻结文件中的语义值。
- 若后续某个模块需要大幅突破当前视觉系统，必须回到共享冻结流程，而不是局部自行扩展。
- 任何实现若让单主焦点变成多主焦点并列，都视为设计回滚。

## downstream_reference_index

- `flutter-design-freeze-gate`
  - 必须核验本文件 metadata block、全部 section 顺序，以及 [light-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/dark-theme-freeze.yaml) 的 concrete leaf values。
- `flutter-uiux-to-architecture`
  - 必须引用：`information_hierarchy_principles`
  - 必须引用：`component_system_principles`
  - 必须引用：`global_public_component_freeze`
  - 必须引用：`visual_system_rules`
  - 必须引用主题文件中的全部 role families
- `flutter-design-source-control`
  - 必须将本文件和两个主题冻结文件加入冻结源优先级，并把任何改动请求回路由到 `design-preview-to-global-guidelines` 加 `flutter-design-freeze-gate`
- `flutter-design-parity-reviewer`
  - 必须对照：`global_experience_principles`
  - 必须对照：`state_and_feedback_principles`
  - 必须对照：`visual_system_rules`
  - 必须对照：`global_public_component_freeze`
  - 必须对照主题文件中的 `component_state_roles` 与 `contrast_rules`
- Optional external design adapters
  - 必须引用：`layout_and_page_structure_principles`
  - 必须引用：`component_system_principles`
  - 必须引用：`global_public_component_freeze`
  - 必须引用：`visual_system_rules`
  - 必须引用：`design_prohibitions`
  - 必须引用：`engineering_guardrails`
  - 必须引用主题文件：[light-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/dark-theme-freeze.yaml)
