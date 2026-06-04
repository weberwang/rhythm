---
artifact_type: shared_design_packet
freeze_readiness: ready_for_shared_freeze
visual_evidence_mode: mixed
platform_baseline: ios_hig
primary_taste_source: imagegen-frontend-mobile
selected_supporting_skills:
  - flutter-prd-rd-writer
  - flutter-workflow-orchestrator
---

# design_brief

- 产品目标不是“把用户教育成自律的人”，而是降低晚间结束动作的阻力，并把次日反馈变得温和、清晰、可继续。
- 共享设计必须同时满足四件事：
  - 3 秒内读懂主任务
  - 不像医学监测仪表盘
  - 不像冥想疗愈模板
  - 在商业触点出现时仍然保持克制与信任

# platform_baseline

- 默认平台基线：`ios_hig`
- 安全区、触控尺寸、底部手势区、sheet 动线、层级反馈都按 iOS 行为预期冻结。
- Android 后续实现允许在不改信息层级的前提下做原生容器映射，不允许改主任务层级与 CTA 优先级。

# primary_taste_source

- 主导技能：`imagegen-frontend-mobile`
- 选择原因：当前任务需要先形成可冻结的移动端页面级视觉证据，再回写成 Flutter 可消费的共享设计包。
- 支撑方向：温和编辑感、轻色模式、轻纹理、高可读度、低医疗感、非打卡羞辱感。

# art_direction

- 整体方向：`温和秩序感 + 编辑式留白 + 低刺激健康科技`
- 感官关键词：
  - 清醒
  - 克制
  - 柔和
  - 可呼吸
  - 不说教
- 视觉记忆点：
  - 暖象牙底色
  - 雾蓝/矿物青主色
  - 低饱和珊瑚强调
  - 轻山峦/薄雾感纹理
  - 高对比标题 + 清晰正文层级

# taste_constraints

- 禁止默认紫白 startup 渐变。
- 禁止把核心页面做成多层卡片堆叠的“假复杂仪表盘”。
- 禁止强惩罚、强成就徽章、强监控式红色警报。
- 禁止把睡前页做成冥想内容页或长内容消费页。
- 允许轻纹理、柔和自然图形、微插图，但它们只能服务层级，不可抢走 CTA。
- 允许大标题与留白，但首屏只能有一个视觉重心。

# information_hierarchy

- 全局扫描顺序统一为：
  - `昨晚结果 / 当前状态`
  - `今晚目标 / 下一步`
  - `恢复或解释`
  - `次级数据与趋势`
- 今日页必须先回答“昨晚怎么样”和“今晚做什么”，趋势卡只能放在后半屏。
- 睡前页必须把“距离目标还有多久”和“今晚状态选择”压到首屏，不允许被说明文案挤下去。
- 日历页优先呈现偏移结果，再进入单日解释，不能让颜色与数字失去业务语义。
- 洞察页只允许一处主行动入口，其他图表只能承担解释角色。

# cta_posture

- 每页最多一个强主按钮或强主卡片动作。
- 次动作优先用文本按钮、边框按钮、尾箭头 cell 或轻强调 chip。
- 付费触点允许出现高对比卡片，但不可盖过页面原始主任务。
- 危险操作或拒绝路径统一弱化，不使用大面积警示红 CTA。

# visual_system

- 色彩：
  - 背景以暖象牙和柔白为主
  - 主行动与主指标使用矿物青/青绿
  - 说明性强调用雾蓝
  - 恢复提醒与轻风险用低饱和珊瑚/柔和琥珀
- 文字：
  - 主题标题允许高对比衬线气质
  - 功能标题、数值、表单、cell 说明优先中性无衬线
- 结构：
  - 大卡片用于承载“结果、目标、恢复、会员状态”
  - 小组件与列表 cell 用更扁平的 grouped surface
  - 图表区不可过度装饰
- 装饰：
  - 仅允许薄雾、山峦、轻植物、月亮等低刺激象征
  - 装饰图层必须退居二级

# state_matrix

| 状态 | 全局表达 |
| --- | --- |
| ideal | 结果清晰、主动作明确、次要解释后置 |
| empty | 用短句解释为什么空，立即给出补救动作 |
| loading | 使用轻骨架或轻占位，避免大面积 spinner |
| error | 页内提示 + 重试，不弹出破坏节奏的强警报 |
| permission | 解释价值、边界、替代手动路径 |
| partial_data | 标注来源与可信度，不假装精确 |
| disabled | 降低对比度但保留结构感 |
| success | 正向但克制，不做夸张庆祝 |
| locked_or_premium | 先解释可获得的改善，再给升级入口 |
| timezone_shift | 暂停普通判断，要求用户确认时区上下文 |

# component_freeze_scope

## 全局共享组件

- 顶部标题区与说明副标题
- 主指标结果卡
- 目标作息卡
- 恢复建议卡
- Grouped settings cell
- 主按钮 / 次按钮
- 标签选择 chip
- 权限/空态说明块
- 会员锁定卡

## 模块私有组件

- 睡前状态选择宫格
- 日历热力图主体
- 洞察页稳定度解释块
- 周报摘要卡
- 小组件引导示意块

# allowed_engineering_adjustments

- 可以把装饰性的雾面纹理、轻山峦曲线、细小插图简化为原生渐变/矢量形状。
- 可以为 Android 做容器尺寸与导航组件映射，但不可改变信息顺序。
- 可以按 Flutter 性能与响应式需求调整卡片阴影强度、模糊半径与图表实现方式。
- 不允许把共享设计中的大层级标题降成普通列表标题，也不允许把主 CTA 降成二级文本入口。

# visual_evidence

- 共享全局参考：`docs/rd/today-dashboard.png`
- 模块视觉证据：
  - `docs/rd/modules/onboarding-activation/onboarding-welcome.png`
  - `docs/rd/modules/today/today-dashboard.png`
  - `docs/rd/modules/bedtime/bedtime-mode.png`
  - `docs/rd/modules/calendar/calendar-heatmap.png`
  - `docs/rd/modules/insights/insights-weekly-report.png`
  - `docs/rd/modules/profile-settings/profile-settings.png`
- 视觉证据模式：全部为 `light_mode`
- 证据说明：这些图用于冻结层级、结构、CTA 对比与情绪温度，不直接等同于运行时位图资产。

# acceptance_gates

- 共享冻结前必须满足：
  - 关键页面首屏任务 3 秒内可读
  - 主 CTA 与次 CTA 对比清楚
  - 权限、空、部分数据、锁定状态均有统一表达
  - 预览图与文本设计包没有层级冲突
- 模块冻结前必须满足：
  - 模块文档已写清滚动、列表、sticky、overlay、layout 语义
  - 模块私有组件是否冻结已明确
  - 若缺少静态图，也必须能凭文本设计包无歧义落地
