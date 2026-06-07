# Rhythm Stitch 共享设计主包

## 产物定位

本文件是 `flutter-workflow-orchestrator` 进入 Stitch 阶段时的共享设计主包。

它服务于：

- 统一 Stitch 页面扩展的全局视觉基线
- 避免页面级生成各自发散
- 作为 `today / onboarding / bedtime / calendar / insights / profile-settings` 的共同上游约束

## 上游确认状态

- 工作流阶段：`global_effect_images_ready`
- 效果图状态：`confirmed_for_stitch_entry`
- 模式：`light mode`
- 平台标识：`ios_device`

## 效果图输入集

- `docs/rd/today-page.png`
- `docs/rd/onboarding-page.png`
- `docs/rd/bedtime-page.png`
- `docs/rd/calendar-page.png`
- `docs/rd/insights-page.png`
- `docs/rd/profile-settings-page.png`

## 最终产品设计方向

- 主方向：`编辑产品混合版`
- 首页主卡：`行动型主卡`
- 首屏密度：`稀疏型`
- 色彩温度：`偏冷清醒`
- CTA 气质：`安静邀请型`
- 底部导航：`稍有产品感，但低权重`

## 全局视觉原则

- 这是一个克制、轻恢复、低压迫的行为节奏工具，不是医疗监控面板
- 视觉高级感来自取舍、层级、留白和秩序，不来自花哨特效
- 首页先讲今晚做什么，昨晚结果只做安静摘要
- 趋势只做轻量辅助，不得抢首屏
- CTA 像邀请，不像命令

## 全局禁止项

- 禁止医疗监测仪表盘气质
- 禁止蓝紫 AI 渐变套路
- 禁止强打卡、强惩罚、强勋章化语言
- 禁止多张同权重主卡并列
- 禁止把 `today` 和 `insights` 做成密集数据面板
- 禁止重新让昨晚结果卡成为首页第一视觉重心

## 色彩与视觉系统

- 背景：冷白、雾灰、灰蓝之间的低对比明亮底色
- 主强调：矿物青
- 辅助强调：低饱和冷琥珀
- 极少量特殊提示：克制珊瑚
- 卡片：大圆角、轻描边、低强度阴影
- 层级依靠留白、高度与尺寸，不依赖高饱和颜色

## 字体与排版气质

- 清晰、克制、略带编辑感的无衬线系统
- 标题允许大，但每页只保留明确的主层级
- 正文与说明使用短句，不做长段落解释
- 标签和状态文案清楚但不抢戏

## CTA 姿态

- 主 CTA 必须清楚，但不具命令感
- 推荐气质：安静邀请型
- 次级 CTA 必须退后，不得与主 CTA 抢主导

## 壳层与导航合同

适用页面：

- `today-page`
- `calendar-page`
- `bedtime-page`
- `insights-page`
- `profile-settings-page`

不适用页面：

- `onboarding-page`

壳层固定 tab：

1. `Today`
2. `Calendar`
3. `Bedtime`
4. `Insights`
5. `Profile`

壳层约束：

- 所有壳层页共享同一套图标语义与英文标签
- `Today` 使用太阳语义图标
- 导航必须可识别为产品壳层导航
- 导航权重必须明显低于页面主卡
- 激活态只通过轻强调色与文字层级变化表达

## 页面级目标

### today-page

- 今晚行动主卡必须是唯一首屏视觉重心
- 昨晚结果只能做安静摘要
- 恢复建议弱于主行动卡
- 趋势只做轻量露出

### onboarding-page

- 不使用主壳层导航
- 作为品牌化、低压迫、清晰引导的首次进入页面
- 维持轻恢复、非营销轰炸的基调

### bedtime-page

- 围绕睡前执行入口组织页面
- 保留单任务聚焦感，不做功能卡片瀑布流

### calendar-page

- 围绕长期回看与热力图
- 可信息化，但不能走医疗监控面板气质

### insights-page

- 强调周报、恢复与洞察
- 依然保持编辑感，而非数据堆叠

### profile-settings-page

- 呈现账户、设置、会员与同步
- 保持清楚、温和、低压迫，不做后台控制台风格

## Stitch 生成约束

- 所有页面必须消费同一共享设计主包
- 不允许页面局部重定义全局 palette、typography mood、CTA posture
- 不允许局部重定义导航壳层规则
- 所有输出默认为高保真 iOS mobile light mode
- 需要优先复用已有共享组件家族，而不是每页重新发明
