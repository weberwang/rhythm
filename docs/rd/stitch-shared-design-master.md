---
artifact_type: stitch_shared_design_master
project_ref: projects/10381993888004407753
stitch_project_mode: new
active_design_system_asset: assets/f22e38e4586a46f487f555bcdbb0e245
status: candidate_ready
last_updated: 2026-06-08
---

# Stitch Shared Design Master

## 1. 当前有效共享设计源

Rhythm 当前共享设计源已经固定为 Stitch 路线。本文件定义当前唯一有效的共享视觉主包，作为后续共享冻结、模块设计拆分和 Flutter 显示层实现的上游依据。

当前有效资源：

- Stitch 项目：`projects/10381993888004407753`
- 当前有效设计系统资产：`assets/f22e38e4586a46f487f555bcdbb0e245`
- 当前有效结构化设计源包：`docs/rd/stitch-design-source-packet.md`
- 历史但无效的 Pencil 路线：`docs/rd/app.pen` 及其导出物，仅保留参考，不再作为当前依据

## 2. 共享视觉母题

本轮设计稿的目标不是“更花哨”，而是把 Rhythm 从温和工具感继续提升到更明确的 premium product 质感。当前有效母题如下：

- 恢复优先：仍然以“今晚该做什么”作为第一信息重心
- 高级编辑感：让页面更像被精心编排过的产品页面，而不是普通健康工具面板
- 结构化深度：通过双层包边、发丝线、内核卡面与柔和阴影建立层次，而不是靠重玻璃和夸张漂浮
- 安静但明确：颜色、留白、导航和按钮都更有产品化辨识度，但不制造压迫感

## 3. 本轮高端化升级结论

本轮基于 `high-end-visual-design` 的优化，当前有效的共享升级点为：

- 双层包边 `double-bezel` 成为共享主卡片结构
- 悬浮岛式底部导航成为五大主页面的共享壳组件语言
- Today 与 Bedtime 的主任务卡明显抬升，首屏更能说明“现在该做什么”
- Calendar 与 Insights 的内容排版更偏 editorial，减少普通数据面板感
- Profile 的分组区域从普通设置列表升级为 premium grouped surfaces
- 发丝线、柔和阴影、暖白底与冷调矿物青形成新的统一氛围

## 4. 当前有效页面清单

以下页面是当前唯一有效的共享页面引用：

| 页面角色 | 当前有效 Stitch 页面 |
| --- | --- |
| Today | `projects/10381993888004407753/screens/7aa8d2da2f4b4ca2a7f0788d2c8f02a1` |
| Onboarding | `projects/10381993888004407753/screens/6d0540cfc9ff4f94b2c8abbac947ee38` |
| Bedtime | `projects/10381993888004407753/screens/ffee0db04659405088e927d0a4adb49a` |
| Calendar | `projects/10381993888004407753/screens/98b5dfb732934477bbd153796558c081` |
| Insights | `projects/10381993888004407753/screens/55432dfe87c940b29bb7bce8f050b798` |
| Profile | `projects/10381993888004407753/screens/97435e7babeb499bb1102a67ea580be3` |
| 共享氛围图 | `projects/10381993888004407753/screens/27dc9be7e6fd4086a8012273c7de943c` |

## 5. 共享组件总原则

### 5.1 主任务卡

主任务卡必须是首页首屏锚点。其结构原则为：

- 外层是柔和染色的外壳
- 内层是更亮的内容核心区
- 标题、目标时间、主 CTA 与辅助说明要形成明确纵向节奏
- 不能让趋势、统计、升级入口或装饰元素抢走首屏注意力

### 5.2 底部导航

底部导航已经切换为悬浮岛式共享壳组件。其语义要求为：

- 视觉上独立于页面背景
- 作为共享公共组件保持五页一致
- 激活态依赖色彩、字重与图标强调，不依赖夸张徽章
- 导航存在感要足够高级，但不能压过主内容

### 5.3 分组表面

Calendar、Insights、Profile 中的大部分信息块和分组块都应遵循统一的分组表面语言：

- 先用留白和分组决定结构
- 再用发丝线和柔和投影补足分层
- 避免普通列表式强分割线
- 避免廉价卡片堆叠感

## 6. 共享排版与色彩取向

当前有效设计系统资产体现出的视觉参数可以概括为：

- 主强调色：偏矿物感的深青色
- 背景基调：偏暖白、非纯白
- 外壳层：比背景略深的冷暖混合浅色
- 标题：更强的几何感与编辑感
- 正文：更柔和、更适合恢复情境下阅读

这套取向用于提升高级感，但不改变产品“恢复优先、低压引导、非医疗化”的根本语义。

## 7. 历史层说明

当前项目里仍保留以下历史层：

- Stitch 初版页面
- Stitch 首轮 Premium 变体
- Pencil `.pen` 与导出图

这些产物都不是当前有效依据。后续任何共享冻结、模块实现与显示层比对，默认只认本文件列出的当前有效页面引用。

## 8. 下一关口

本主包已经具备进入共享冻结评审的条件。用户确认后，下一步进入：

- `flutter-design-freeze-gate`

