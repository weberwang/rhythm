# Rhythm 共享视觉评审：Style 01

- `review_decision`: `needs_revision`
- `review_execution_mode`: `fresh_subagent`
- `final_score`: `77/100`
- `review_target_type`: `static_preview_pack / shared_visual_draft`
- `freeze_target`: `shared_pre_split`
- `business_moment`: 作息管理产品准备进入共享设计冻结，并作为后续模块拆分、Pencil 重建与 Flutter 实现链路的视觉基线。
- `primary_task`: 用户能快速理解当前作息状态、日历节奏与洞察建议，并知道下一步可做什么。
- `primary_cta_paths`: Bedtime 页的 wind-down 行动；Calendar 页的目标编辑与日期详情；Insights 页的 tips 与升级入口。

## 评审依据

- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`
- `style-01-bedtime-preview.png`
- `style-01-calendar-preview.png`
- `style-01-insights-preview.png`

该预览包满足 `draft-completeness-gate` 的可评审门槛：三张主页面都呈现了真实产品界面、主信息层级、核心 CTA 区域、字阶、对比与商业时刻。它不应被视为 `blocked`，但状态覆盖与共享 shell 一致性尚不足以进入 `ready_for_freeze_review`。

## `score_breakdown`

| 维度 | 分数 | 评审说明 |
| --- | ---: | --- |
| 信息层级与扫视顺序 | 22/25 | Bedtime 的倒计时、Calendar 的月历热力焦点、Insights 的周达标率都能在三秒内成为主焦点，符合“页面身份 -> 当前结果/任务 -> 下一步动作”的全局原则。Calendar 的日期详情和目标编辑入口略弱，Insights 下半屏信息密度开始接近同权重卡片流。 |
| 关键任务引导与主路径 | 18/25 | Bedtime 的 wind-down 主卡是最明确的下一步。Calendar 能看到日期详情和 `Edit goal`，但“选中日期后下一步该做什么”仍偏解释型。Insights 同时出现 `Learn more`、`View tips` 与升级入口，用户可能不确定当前最推荐路径。 |
| 字体层级 | 13/15 | 衬线感标题、大数字和中性正文字体形成了高级、克制的阅读梯度。部分标签、图例和卡片辅助文案偏小，若进入运行时动态内容，存在被弱化成灰色说明层的风险。 |
| 对比与可读性 | 12/15 | 浅色暖背景、深海松石主色和白色卡片整体稳定可信。较弱项集中在图例、底部导航非激活态、次级按钮与小尺寸说明文字；这些元素在移动端真实亮度环境下需要更明确的对比保障。 |
| CTA 与转化焦点 | 7/10 | Bedtime 主 CTA 成立，Calendar 的 `Edit goal` 与日期详情路径视觉权重偏轻，Insights 的 tips/learn-more/upgrade 三条路径竞争。升级卡位置正确地晚于可用价值，但 CTA 语义仍需从“解锁更多”收束到“持续改善”。 |
| 系统一致性与精致度 | 3/5 | 卡片、圆形状态语言、细线图标和低饱和色彩方向高度统一。主要扣分来自共享导航壳不一致：底部 tab 命名、数量与顺序在三张图之间不统一，顶部标题结构也存在居中品牌标题与页面标题两种模式，后续冻结会放大实现歧义。 |
| 状态完整性与交付准备 | 2/5 | 已看到 ideal、Calendar 的局部 no data 语义和 Insights 的 locked/premium 入口，但 empty、partial data、loading、error、permission、disabled 尚未形成共享表达。当前只能证明主视觉方向，不能证明生产状态系统。 |

## `strengths`

- 三张图都稳定传达了“温和克制的高信任作息行为管理工具”，没有落入医疗面板、效率打卡或强情绪疗愈风格。
- Bedtime 页首屏主焦点非常清楚：用户先看到睡前倒计时，再看到状态自评，再看到今晚 wind-down 行动。
- Calendar 页用低饱和圆点热力表达节奏偏移，语义比高密度图表更轻，也符合全局圆形状态语言。
- Insights 页把周达标率、原因解释、恢复总结和升级入口串成了“理解自己 -> 获得建议 -> 深入改善”的商业叙事。
- 浅色主题、细边框卡片、轻阴影、圆角和线性图标之间的气质统一，具备成为共享视觉基线的潜力。

## `weaknesses`

- 预览包仍以 ideal/happy path 为主，生产必需状态没有展开到可冻结程度。
- 底部导航在三张图之间不一致：Bedtime、Calendar 与 Insights 的 tab 命名、数量、顺序和当前态语义不统一，无法直接冻结为共享 shell。
- Calendar 页的主任务更像“查看日历”，但下一步行动不够明确；`Edit goal` 视觉权重较轻，日期详情卡也缺少明确的后续处理入口。
- Insights 页的 `Learn more`、`View tips` 和 `Unlock deeper insights` 同屏出现，路径优先级需要收束，否则 tips 与升级会互相稀释。
- 小号标签、图例、辅助描述和底部导航非激活态对比偏克制，可能低于实际移动场景的快速扫视要求。
- 锁定/高级入口已有方向，但缺少 locked 内容的边界说明、可用价值承接和未订阅状态下的可继续路径。

## `risks`

- 若直接进入 `flutter-design-freeze-gate`，共享导航和页面标题模式会造成后续 Pencil 与 Flutter 实现各自解释，形成视觉漂移。
- 缺少 loading/error/permission/disabled/partial-data 会让后续实现团队在真实数据接入时自行补状态，破坏冻结基线。
- Calendar 页如果不补强“选中日期后的下一步”，用户可能只能理解偏移事实，却不知道如何调整目标或处理当日偏差。
- Insights 页如果不明确 tips 与升级的主次，商业入口可能被认为是普通提示卡，或者反过来压过已可用洞察价值。
- 静态预览里的摄影级环境氛围不能被运行时复刻；若没有明确工程 guardrail，Flutter 实现可能误把外部静物氛围当成 UI 装饰需求。

## `hierarchy_assessment`

Bedtime 页层级最成熟。页面身份、倒计时、状态选择和 wind-down 主行动之间有明确的阅读顺序，符合睡前疲劳场景的低认知负担要求。`Tonight's wind-down` 作为唯一高强调卡片合理，但卡片点击、完成反馈和已完成状态还没有被定义。

Calendar 页主焦点是月份热力图，视觉上成立。问题是热力图下方的摘要、目标编辑和单日详情在行动层面偏平，用户能看懂“5 月表现如何”，但不够快地看懂“现在要改目标、记录原因，还是查看建议”。

Insights 页信息结构清晰但 CTA 分叉偏多。周达标率是正确主焦点，原因榜和恢复总结也能解释结果；然而 `Learn more`、`View tips`、升级卡三者同时给出下一步，会让任务指导从单一路径变成多路径浏览。

## `task_guidance_assessment`

当前视觉方向能让用户快速理解作息状态，但只有 Bedtime 页真正形成了清晰的“下一步行动”。Calendar 页需要把日期详情转化为可执行路径，例如调整目标、补充原因、查看当天建议或确认当前目标。Insights 页需要明确本屏是优先引导用户看 tips，还是优先承接高级洞察升级。

对于预期状态覆盖，当前没有足够证据说明用户在没有数据、只有部分数据、权限未开、加载失败、组件不可用或订阅锁定时仍能知道下一步。因此任务指导不能视为生产完整。

## `cta_assessment`

Bedtime 页的 wind-down 卡片是最接近主 CTA 的组件，视觉权重、位置和文案都符合睡前主任务。建议在后续设计中明确它是可点击卡片、主按钮，还是步骤列表入口，并补齐完成/跳过/稍后提醒状态。

Calendar 页的 `Edit goal` 是关键管理入口，但现在更像辅助链接。日期详情卡的后续行动也不明显，需要明确当前日期详情是查看结果、调整目标，还是进入修复建议。

Insights 页的 CTA 需要降噪。`View tips` 可作为当前可用主 CTA，`Learn more` 应弱化为解释链接，`Unlock deeper insights` 应在用户理解已获得价值之后出现，并说明升级带来的长期改善价值，而不是只强调更深洞察。

## `recommended_fixes`

1. 统一共享 app shell：固定底部导航的 tab 数量、命名、顺序、当前态样式，以及顶部标题使用“品牌标题”还是“页面标题”的规则。
2. 补齐共享状态矩阵：至少覆盖 ideal、empty/no data、partial data、loading、error、permission、disabled、locked/premium，并标注每类状态的文案语气、视觉权重和可继续路径。
3. 收束每页主 CTA：Bedtime 保持 wind-down 为唯一主行动；Calendar 明确目标编辑与日期详情的下一步；Insights 明确 tips 与升级入口的主次关系。
4. 提升小号文字和图例的生产可读性：按主题冻结文件的对比规则复核辅助文本、非激活导航、图例和次级链接。
5. 为 Pencil/Flutter handoff 增加组件级注释：状态圆点、状态选择卡、统计摘要卡、锁定卡、底部导航、主行动卡需要有可复用规格，不应只靠静态图推断。
6. 明确高级入口的价值叙事：先展示已获得洞察价值，再解释升级如何帮助长期回稳，避免让锁定卡压过当前可用内容。

## `next_skill`

`design-preview-to-pen`

原因：当前方向值得保留，但需要把静态预览转成可冻结、可复用、状态完整的 Pencil 设计源，并在进入 `flutter-design-freeze-gate` 前补齐共享 shell、CTA 层级和状态表达。

## `freeze_readiness_note`

当前不建议进入 `ready_for_freeze_review`。Style 01 的视觉气质、核心页面层级和商业方向已经达到可继续推进的水平，但共享导航壳不一致、CTA 路径仍有分叉、生产状态覆盖不足。完成上述修订并重新输出状态完整的设计源后，再进入 `flutter-design-freeze-gate` 会更安全。
