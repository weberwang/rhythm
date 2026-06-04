---
artifact_type: global_design_guidelines
freeze_status: frozen
source_type: mixed
theme_freeze_files:
  light: light-theme-freeze.yaml
  dark: dark-theme-freeze.yaml
---

## design_position

- Rhythm 是作息行为管理产品，不是医学数据面板。
- UI 需要传达的承诺是：今晚可以更轻地收尾，明天可以更清楚地理解偏移。
- 冻结后的设计姿态必须稳定地表现出“温和、清醒、可信、可持续”。

## product_personality

- 气质：克制、平静、低压迫、具备编辑感。
- 自信水平：高可读、高秩序，但不过度炫技。
- 密度：中低密度，重点模块可以更大、更疏朗。
- 稳定记忆点：暖象牙底、矿物青主色、低饱和珊瑚强调、轻自然纹理。

## target_users_and_core_scenarios

- 用户通常在疲惫、拖延、自责或注意力分散状态下使用产品。
- 首次激活场景需要快速建立信任；睡前场景需要低刺激和低认知负担；次日复盘场景需要清楚但不羞辱。
- UI 必须优先优化：
  - 深夜低精力决策
  - 次日快速扫描
  - 高意图升级决策

## global_experience_principles

- 每个页面先告诉用户“现在最重要的下一步是什么”。
- 失败后默认进入恢复路径，而不是惩罚路径。
- 权限、无数据、部分数据都应该可继续，不允许出现断崖式空白。
- 引导和付费都不能打断主闭环。

## information_hierarchy_principles

- 一级层级只给一个重心：结果、目标、操作三者中只能有一个占视觉主导。
- 数值型内容必须有语义解释，不能裸露成“图表即答案”。
- 标题、数值、说明文案形成明确三层梯度。
- CTA 优先级永远高于装饰图层与次级统计。

## layout_and_page_structure_principles

- 核心页面采用“主焦点卡 + 解释区 + 辅助动作区”的通用骨架。
- Grouped surface 只用于承载信息分组，不用于制造复杂度。
- 页面纵向节奏保持“重卡片 -> 轻说明 -> 次级列表/图表”。
- 除 root shell 外，不使用复杂浮层叠浮层结构。

## component_system_principles

- 共享组件优先围绕“结果、目标、恢复、设置、锁定、空态”六类能力建立。
- 共享组件允许有限变体，但必须共用间距、圆角、描边与标题层级规则。
- 模块私有组件可以在局部丰富，但不得覆盖共享 CTA 与文字层级规则。

## global_public_component_freeze

- 共享全局组件族：
  - 主结果卡
  - 目标作息卡
  - 恢复建议卡
  - 主按钮
  - 次按钮
  - Grouped settings cell
  - 标签选择 chip
  - 会员锁定卡
  - 空态/权限说明块
- 允许的共享状态：
  - default
  - pressed
  - disabled
  - locked
  - warning-soft
- 下游不可改动项：
  - 主 CTA 的对比等级
  - 标题/正文的层级差
  - 卡片圆角家族与留白尺度
- 工程允许微调项：
  - 阴影强度
  - 装饰曲线细节
  - Android 平台容器边距适配
- 明确不属于全局共享层的组件：
  - 睡前状态三选卡
  - 热力图单元格
  - 稳定度解释视图
  - 周报摘要布局

## interaction_behavior_principles

- 主动作必须在 1 次视觉扫描内找到。
- 次动作优先用尾箭头、文本按钮、轻描边按钮。
- 切换、标签、过滤器的命中区必须舒适，不允许用过小胶囊承载高频操作。
- 破坏性操作需要弱提示与二次确认，但不使用强恐吓语气。

## state_and_feedback_principles

- ideal：清晰、稳定、不夸奖过度。
- loading：轻骨架、轻淡入，不用高频 spinner。
- empty：解释原因并直接给补录/授权入口。
- disabled：保留结构，降低对比。
- success：温和正向，不做大动画庆祝。
- warning：使用柔和琥珀或珊瑚，不进入告警红。
- error：页内提示 + 重试，保证本地路径仍可继续。

## content_and_copy_principles

- 语气要温和、可信、去医疗化。
- 标题短、动作明确、说明文案不过度解释。
- 空态与错误态先告诉用户“还能做什么”，再说明为什么。
- 付费文案强调改善结果，不强调功能堆砌。

## visual_system_rules

- 标题优先高对比、具呼吸感；正文优先可读、节制。
- 主背景必须偏暖偏柔，避免冷硬蓝白监测感。
- 主 CTA 使用稳定矿物青系，不允许与次按钮落在相同对比带。
- 共享卡片使用柔和边界与低强度阴影，不做厚重玻璃质感。
- 图标偏线性或轻填充，不允许通用开发者图标库的廉价感。
- 动效仅服务进入、状态切换与卡片淡入，不能成为视觉主角。

## light_theme_rationale

- 轻色主题承载首发工作流基线，因为它最能表达“可信又不压迫”的产品承诺。
- 暖象牙背景能削弱医疗监控感；矿物青主色能同时承载理性与温和。
- 珊瑚强调只用于恢复、提醒与轻风险，不参与主 CTA 竞争。

## dark_theme_rationale

- 深色主题不是反色版本，而是保留相同层级逻辑的夜间阅读方案。
- 背景和卡片对比应被压进更窄的亮度带，避免刺眼高反差。
- 主色保留识别度，但要降低亮度与饱和冲击，保护深夜使用体验。

## design_prohibitions

- 禁止把主页面重构为医学仪表盘。
- 禁止把主 CTA 降为次级文本入口。
- 禁止把恢复建议变成失败惩罚模块。
- 禁止把视觉风格改成重紫、重霓虹、重玻璃的通用模板。
- 禁止在实现阶段自行改变标题层级、按钮对比和状态色语义。

## engineering_guardrails

- 允许把装饰纹理简化为原生渐变、模糊与矢量形状。
- 允许把插图与小自然元素抽象为可维护的 Flutter 形状或局部资产。
- 不允许为了实现方便删除首屏主焦点区。
- 不允许用统一卡片模板覆盖所有模块，导致页面结构失去差异。
- 若视觉与交互语义冲突，必须回到设计控制链路处理。

## downstream_reference_index

- `flutter-design-freeze-gate`
  - 必引：`information_hierarchy_principles`, `global_public_component_freeze`, `visual_system_rules`
  - 必查文件：`light-theme-freeze.yaml`, `dark-theme-freeze.yaml`
- `flutter-uiux-to-architecture`
  - 必引：`layout_and_page_structure_principles`, `component_system_principles`, `engineering_guardrails`
  - 必查文件：`light-theme-freeze.yaml`, `dark-theme-freeze.yaml`
- `flutter-design-source-control`
  - 必引：`design_prohibitions`, `engineering_guardrails`
  - 必查文件：全部三份共享冻结产物
- `flutter-design-parity-reviewer`
  - 必引：`information_hierarchy_principles`, `state_and_feedback_principles`, `visual_system_rules`
  - 必查文件：`light-theme-freeze.yaml`, `dark-theme-freeze.yaml`
