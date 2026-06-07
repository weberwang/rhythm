# Rhythm 全局设计方向包

> 产物类型：shared_taste_direction_packet
> 日期：2026-06-07
> 来源：`docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md`
> 技术基线：`docs/rd/global-technical-baseline.md`
> 工作流阶段：`technical_baseline_ready -> shared_taste_direction`

## 1. 设计摘要

Rhythm 的共享视觉方向不是“助眠冥想产品”，也不是“医学数据仪表盘”，而是一个克制、轻恢复、低压迫的行为节奏工具。

本轮将其读取为：

- `页面类型`：移动端消费型健康行为产品
- `受众`：长期晚睡但愿意改善的年轻成人
- `气质语言`：编辑感恢复工具、偏冷清醒、低压迫、非模板化、非游戏化
- `主导审美来源`：`design-taste-frontend`

## 2. 设计包

### 2.1 design_brief

Rhythm 需要一个让用户在疲劳状态下仍能快速理解“今晚先做什么”的移动端界面系统，再由安静的结果摘要与恢复建议补充判断。它必须让用户感受到被温和纠偏，而不是被量化审判。

### 2.2 platform_baseline

`iOS HIG`

### 2.3 platform_identifier

`ios_device`

### 2.4 primary_taste_source

`design-taste-frontend`

### 2.4.1 selected_supporting_skills

- `flutter-taste-router`
- `design-taste-frontend`

### 2.5 art_direction

- 明亮 light mode 为唯一工作流基准
- 以“冷静编辑页面 + 轻产品化操作入口”的混合感为主
- 保持编辑感秩序，而不是重科技感、重监控感或拟物疗愈感
- 首页重心必须聚焦一张“今晚行动主卡”，而不是昨晚结果卡
- 首屏信息密度保持稀疏，允许只有一个主行动焦点和少量辅助块

### 2.6 taste_constraints

- 禁止医疗监测仪表盘气质
- 禁止蓝紫 AI 渐变套路
- 禁止强打卡、强惩罚、强勋章化语言
- 禁止一屏塞满等高卡片或多张同权重卡片
- 禁止洞察页和今日页变成密集数据面板
- 禁止昨晚结果卡重新成为首页第一视觉重心
- 保持单一强调色系统，不做多色竞争

### 2.7 information_hierarchy

全局信息层级按以下顺序锁定：

1. 今晚目标与主行动入口
2. 昨晚结果摘要
3. 恢复建议或睡前进入建议
4. 最近 7 天趋势预告
5. 辅助操作与次级入口

### 2.8 cta_posture

- CTA 不应像“任务完成按钮”，而应像“轻推进下一步”
- 主 CTA 语气偏安静邀请，例如“开始慢慢收尾”“现在进入睡前节奏”
- 次 CTA 应低对比存在，不与主 CTA 争抢

### 2.9 visual_system

- 背景：冷白、雾灰与灰蓝之间的低对比明亮底色
- 结构：大面积留白 + 1 张主行动卡 + 2 个安静辅助块，不用满屏卡片阵列
- 卡片：大圆角、轻描边、低强度阴影，以高度和留白而不是颜色制造层级
- 图形：趋势图和热力图使用低饱和状态色，不做荧光强调
- 导航：底部导航有清楚产品感，但视觉权重必须明显低于首页主卡

### 2.10 state_matrix

必须覆盖以下状态：

- 理想态
- 空态
- 加载态
- 错误态
- 权限未授权
- 部分数据
- 禁用态
- 成功反馈态
- 已手动修正
- 明显晚睡恢复态
- 会员锁定态

### 2.11 component_freeze_scope

- 全局共享：主状态卡、次级信息卡、标签芯片、底部导航、趋势条、付费锁定条
- 模块私有：睡前模式状态选择器、恢复计划详情块、月报详情视图
- 局部允许变化：热力图细节表现、不同页面的二级说明布局

### 2.11.1 shared_navigation_contract

主壳层页面必须共享同一套底部导航合同，不允许在不同页面各自改写 tab 数量、顺序、命名或激活态语义。

- `适用页面`：
  - `today-page`
  - `calendar-page`
  - `bedtime-page`
  - `insights-page`
  - `profile-settings-page`
- `不适用页面`：
  - `onboarding-page`
- `固定 tab 顺序`：
  - `Today`
  - `Calendar`
  - `Bedtime`
  - `Insights`
  - `Profile`
- `固定语义`：
  - `Today`：每日首页与今晚行动入口
  - `Calendar`：长期回看与热力图
  - `Bedtime`：睡前执行入口
  - `Insights`：周报、恢复与洞察
  - `Profile`：账户、设置、会员与同步
- `视觉要求`：
  - 导航必须可识别为产品壳层导航
  - 导航权重必须明显低于页面主卡
  - 激活态只能通过轻强调色和文字层级变化表达，不允许高饱和跳出
  - 所有壳层页使用同一套图标语义与标签文案

### 2.12 high_fidelity_visual_contract

当前为共享级高保真约束，供后续 freeze 使用：

- 今晚行动主卡必须在首屏形成唯一视觉重心
- 昨晚结果只能作为安静摘要，不得重新成为首屏霸主
- 目标、摘要、建议三层信息必须通过尺寸、留白和色块清楚分层
- 颜色提示只表达偏移等级，不表达羞辱或危险
- 文字密度必须适合单手快速扫读，避免长段落解释
- 趋势信息只能作为辅助判断，不得压过今晚行动入口，首屏只允许轻量露出
- 底部导航、标签和趋势条需保持统一圆角与描边系统
- 壳层页面的底部导航合同必须严格一致，不允许页面间出现不同的 tab 集合或顺序

### 2.13 allowed_engineering_adjustments

- 趋势图具体笔触和插值方式可根据 Flutter 图表能力做工程化调整
- 热力图格子密度可依据不同机型宽度轻微调整
- 轻纹理背景可在实现期弱化为纯色或极浅渐变
- 阴影和模糊效果可在不破坏层级的前提下降级为边框体系

### 2.13.1 technical_direction_constraints

- 默认支持匿名本地进入，不把“必须登录”作为页面可用前提
- 所有核心页面必须能承载本地优先与远端增强并存的状态表达
- 数据为空、同步失败、权限缺失、会员锁定都必须在首屏层级中有明确落点
- 不把复杂视觉效果作为首发闭环成立前提；涉及非原生质感时允许后续通过位图证据补强
- 全局共享组件必须适配 `today / bedtime / calendar / insights / profile-settings` 的一致语义，而不是只服务单页视觉
- 首页的主行动优先级必须高于结果图、趋势图和会员入口，不得因商业或统计需求反向提升次级模块

### 2.14 acceptance_gates

- 3 秒内能看出今晚的主任务，不依赖解释文字
- 不出现医疗化仪表盘或游戏化打卡视觉隐喻
- 主 CTA 明确且不强迫，语气像邀请而不是命令
- 明显晚睡时，恢复建议优先级高于统计图
- 所有状态色都有文字辅助，不依赖颜色单独表达

### 2.15 style_generation_constraints

- `palette_direction`：冷白底、雾灰蓝中性、矿物青、低饱和冷琥珀、极少量克制珊瑚
- `typography_mood`：清晰、克制、略带编辑感的无衬线系统
- `component_family_cues`：行动型大主卡、安静薄摘要卡、细描边、小型标签芯片、稍有产品感的底部导航
- `image_treatment_posture`：不依赖插画主体，不做大面积照片背景，以 UI 本身层级为主

## 2.16 confirmed_direction_summary

- `主方向`：编辑产品混合版
- `首页主观感受`：编辑感恢复工具
- `首屏主卡类型`：行动型主卡
- `首屏密度`：稀疏型
- `色彩温度`：偏冷清醒
- `CTA 气质`：安静邀请型
- `底部导航处理`：稍有产品感，但必须低权重

## 3. 代表页选择

本轮共享代表页固定为：`today-page`

选择原因：

- 同时承载结果反馈、今晚目标、恢复建议、趋势和 CTA
- 最能代表 Rhythm 的核心层级与商业姿态
- 可直接验证“不是报告页，也不是医疗仪表盘”的设计边界

## 4. 视觉证据

- 当前共享视觉证据：已生成并修订完成全页 light mode 静态页面证据，当前版本可作为全页效果图确认门输入
- 代表页输出路径：`docs/rd/today-page.png`
- 其余页面输出路径：
  - `docs/rd/onboarding-page.png`
  - `docs/rd/bedtime-page.png`
  - `docs/rd/calendar-page.png`
  - `docs/rd/insights-page.png`
  - `docs/rd/profile-settings-page.png`
- 历史备份路径：`docs/rd/today-page.history.png`
- 旧方向草图备份路径：`docs/rd/today-page.pre-regen-stale.png`
- 壳层页统一前备份路径：`docs/rd/today-page.pre-shell-unify.png`
- 模式要求：light mode
- 当前状态：`all_page_effect_images_pending_confirmation`
- 作用：当前整套页面已可进入全页效果图确认门；确认后再进入 Stitch

## 5. 冻结前说明

本文件只是共享设计方向包，不代表已完成共享冻结。
只有在代表页效果图确认、其余页面效果图补齐、并通过后续设计冻结检查后，才允许进入更后续的结构化设计源和模块拆分阶段。

## 6. 当前自动推进结论

- 本轮已完成共享视觉方向文本归一化，可作为 `shared_taste_direction` 阶段输入。
- 用户已通过头脑风暴确认新的最终产品设计方向，且其核心约束已写回本文件。
- 当前 `docs/rd/today-page.png` 已按“行动型主卡 + 稀疏首屏 + 偏冷清醒 + 安静邀请型 CTA”方向重生成。
- 其余核心页面 `onboarding / bedtime / calendar / insights / profile-settings` 也已按同一共享方向生成页面证据；其中 `today-page` 已追加壳层统一修订，使设备外框、顶部状态区与底部导航合同对齐其他壳层页。
- 当前全页效果图已恢复到可确认状态；在用户明确确认前，仍不得进入 Stitch。
