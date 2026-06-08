---
artifact_type: stitch_design_source_packet
project_ref: projects/10381993888004407753
stitch_project_mode: new
active_design_system_asset: assets/f22e38e4586a46f487f555bcdbb0e245
status: candidate_ready
model_trace: high_end_visual_design + stitch_apply_design_system
last_updated: 2026-06-08
---

# Stitch Design Source Packet

## 1. 包定位

本包用于把当前有效的 Stitch 共享设计源整理成后续冻结和实现可直接引用的结构化输入。它不承担 Flutter 架构设计职责，只负责明确：

- 当前有效的 Stitch 项目与设计系统资产
- 当前有效的页面引用
- 共享显示层的结构原则
- 历史层与有效层的边界

## 2. 当前有效设计源

- Stitch 项目：`projects/10381993888004407753`
- Stitch 项目模式：`new`
- 当前有效设计系统资产：`assets/f22e38e4586a46f487f555bcdbb0e245`
- 当前有效共享设计主包：`docs/rd/stitch-shared-design-master.md`
- 共享氛围图：`projects/10381993888004407753/screens/27dc9be7e6fd4086a8012273c7de943c`

## 3. 当前有效页面映射

| 业务页面 | 当前有效 Stitch 页面 | 说明 |
| --- | --- | --- |
| Today | `projects/10381993888004407753/screens/7aa8d2da2f4b4ca2a7f0788d2c8f02a1` | 最新 Premium 版，主任务卡和底部导航已统一到高端化语言 |
| Onboarding | `projects/10381993888004407753/screens/6d0540cfc9ff4f94b2c8abbac947ee38` | 最新 Premium 版，首屏欢迎层级更清晰 |
| Bedtime | `projects/10381993888004407753/screens/ffee0db04659405088e927d0a4adb49a` | 最新 Premium 版，任务路径与分组节奏更强 |
| Calendar | `projects/10381993888004407753/screens/98b5dfb732934477bbd153796558c081` | 最新 Premium 版，热力视图与摘要区更偏 editorial |
| Insights | `projects/10381993888004407753/screens/55432dfe87c940b29bb7bce8f050b798` | 最新 Premium 版，统计和洞察区已统一到新主题 |
| Profile | `projects/10381993888004407753/screens/97435e7babeb499bb1102a67ea580be3` | 最新 Premium 版，分组表面和设置容器已升级 |

## 4. 本轮优化的共享结论

### 4.1 共享壳

共享壳已经不再停留在“底部导航存在即可”的层级，而是升级为明确的视觉识别器：

- 五页统一采用悬浮岛式底部导航
- 导航与页面内容之间有独立的空气感
- 导航承担产品化识别，但不与首屏主任务抢夺重心

### 4.2 共享卡面

共享卡面已经形成统一结构：

- 外壳层：轻微染色，用来建立轮廓与高级感
- 内核层：更亮、更聚焦，用来承载真正内容
- 边界层：优先使用发丝线和内高光，而不是粗边框
- 阴影层：使用柔和、扩散、低对比的染色阴影

### 4.3 共享排版

当前共享排版强调：

- 标题有更强的 editorial 感
- 正文保持低压力和良好可读性
- 信息分组依赖留白与节奏，而不是靠密集线框

### 4.4 共享任务优先级

不管页面如何优化，产品的第一优先级没有变化：

1. 用户必须迅速知道今晚该做什么
2. 主任务卡必须压过历史统计和次要信息
3. 恢复引导必须保持温和但明确
4. 趋势、图表、设置、会员提示都不得越级抢占首屏主导权

## 5. 实施约束

后续冻结与实现阶段应遵守以下约束：

- 只以本包列出的当前有效 Stitch 页面作为共享显示层依据
- 旧 Stitch 页面仅作历史留档，不可继续作为实现目标
- Pencil 产物已经被降为 `historical_inactive`
- 未经过新的共享确认前，不应再回切到 Pencil 路线

## 6. 历史层清单

以下资源保留但无效：

- Stitch 初版页面：
  - `projects/10381993888004407753/screens/14081e75904e4d7393334d747aee9a51`
  - `projects/10381993888004407753/screens/50e9f90e0ba54bc8b2a79125daa2dbea`
  - `projects/10381993888004407753/screens/f58befe21a3241bba639fdd6936c82a3`
  - `projects/10381993888004407753/screens/35c597a9fc3f49c7bfc206a9adca5bae`
  - `projects/10381993888004407753/screens/b69b67878504471689499abc71b8b918`
  - `projects/10381993888004407753/screens/31037eaf69964efd86f30749026fee0e`
- Pencil 路线：
  - `docs/rd/app.pen`
  - `docs/rd/pencil-design-source-packet.md`
  - `docs/rd/pencil-exports/`
  - `docs/rd/shared-design-freeze-decision.md`

## 7. 冻结前检查结论

当前这组 Stitch 设计源已经满足以下条件：

- 有稳定的项目引用
- 有当前有效的设计系统资产
- 有六个核心页面的当前有效引用
- 有共享壳、共享卡面、共享任务优先级的统一规则
- 有明确的历史层与有效层边界

因此，这组设计源已经具备进入 `flutter-design-freeze-gate` 的前置条件。
