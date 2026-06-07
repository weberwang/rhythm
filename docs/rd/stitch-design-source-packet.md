# Rhythm Stitch 设计源包

## 产物定位

本文件是本轮 `flutter-workflow-orchestrator` 在 Stitch 阶段合并后的本地设计源包。

它记录：

- 冻结的 Stitch 项目模式与项目 ID
- 共享设计系统资产
- 全部页面级 Stitch 产物与回执
- 效果图到 Stitch 页面的一一映射
- 后续 freeze gate 与 Flutter 架构阶段的上游输入

## Stitch 基础信息

- `stitch_project_mode`: `new`
- `stitch_project_id`: `9392137754454631344`
- `stitch_project_name`: `projects/9392137754454631344`
- `stitch_project_title`: `Rhythm Shared Design Source 2026-06-07`
- `stitch_model_id`: `GEMINI_3_1_PRO`
- `shared_design_system_asset`: `assets/ce15df8dfd494587b335ced8718a3cd3`
- `shared_design_master_packet`: `docs/rd/stitch-shared-design-master.md`

## 页面映射

| page_id | effect_image | stitch_screen_id | stitch_screen_name | screenshot_name | html_name |
| --- | --- | --- | --- | --- | --- |
| `today-page` | `docs/rd/today-page.png` | `2eda27b626844ff491142abab092fe18` | `projects/9392137754454631344/screens/2eda27b626844ff491142abab092fe18` | `projects/9392137754454631344/files/0faaa038e0f049948b6946411db41f8e` | `projects/9392137754454631344/files/052b6559eecd4b79a08fd859701beff3` |
| `onboarding-page` | `docs/rd/onboarding-page.png` | `cbbe81054aa7484582cbc8cca5cde1db` | `projects/9392137754454631344/screens/cbbe81054aa7484582cbc8cca5cde1db` | `projects/9392137754454631344/files/ffff83b4c76f418dad03a12c5bebc4f2` | `projects/9392137754454631344/files/fb34ab21877742f48a6b10f5394e9ac3` |
| `bedtime-page` | `docs/rd/bedtime-page.png` | `f7eac11372464614a3dfe17999af8cd1` | `projects/9392137754454631344/screens/f7eac11372464614a3dfe17999af8cd1` | `projects/9392137754454631344/files/895c4c96e3d6433a9a022fcae9565dd4` | `projects/9392137754454631344/files/63f553a32b5647759f3d35e2de7b58a1` |
| `calendar-page` | `docs/rd/calendar-page.png` | `c9f73ab917d54fa2828b5ab0afbc8e1b` | `projects/9392137754454631344/screens/c9f73ab917d54fa2828b5ab0afbc8e1b` | `projects/9392137754454631344/files/d6d4f7aea89547e2806fa7b4faa80cc9` | `projects/9392137754454631344/files/4c7b4d602d8345c3865b5e58261d51d0` |
| `insights-page` | `docs/rd/insights-page.png` | `5eab24e547c646258b15c1cb24a8e221` | `projects/9392137754454631344/screens/5eab24e547c646258b15c1cb24a8e221` | `projects/9392137754454631344/files/7e3cdc72c6984a4a8b24307d7412ccb5` | `projects/9392137754454631344/files/e9ede1b3a51647278c9e227b6c554ef7` |
| `profile-settings-page` | `docs/rd/profile-settings-page.png` | `bddd6cd7240a43d6a9165fd28921ca57` | `projects/9392137754454631344/screens/bddd6cd7240a43d6a9165fd28921ca57` | `projects/9392137754454631344/files/80b81dca788e427cbebc934e59291445` | `projects/9392137754454631344/files/be962396127245c9ace53164877f9bb9` |

## 页面级回执摘要

### today-page

- 状态：`advanced`
- 作用：代表页与共享壳层基准页
- 关键约束：今晚行动主卡是唯一首屏重心，`Today` 使用太阳语义图标
- 共享组件依赖：共享底部导航、共享卡片体系、共享排版与留白节奏
- 当前备注：Stitch 自动沉淀出项目级设计系统资产，并作为后续页面统一基线

### onboarding-page

- 状态：`advanced`
- 作用：非壳层导航页的品牌化首次进入页
- 关键约束：不使用底部壳层导航；强调品牌、低压迫、轻恢复
- 当前备注：保持了品牌主导与安静 CTA

### bedtime-page

- 状态：`advanced`
- 作用：睡前执行入口页
- 关键约束：单任务聚焦、主 CTA 明确、低干扰
- 当前备注：使用共享底部导航，`Bedtime` 激活

### calendar-page

- 状态：`advanced`
- 作用：长期回看与热力图页
- 关键约束：热力图可读，但不能医疗化或高告警化
- 当前备注：使用低饱和色阶表达恢复状态

### insights-page

- 状态：`advanced`
- 作用：周报、恢复与洞察页
- 关键约束：编辑感、文本主导、轻量趋势表达
- 当前备注：避免了多图表 KPI 墙

### profile-settings-page

- 状态：`advanced`
- 作用：账户、设置、会员与同步页
- 关键约束：清楚、柔和、非后台控制台气质
- 当前备注：会员与同步被收敛成低压 summary card

## 共享一致性结论

- 全部页面使用同一个 Stitch 项目
- 全部页面使用同一个共享设计系统资产
- 全部页面默认走 `MOBILE + LIGHT`
- 壳层页面已共享同一套底部导航语义
- 当前无记录的下载位图资产
- 当前无记录的新共享组件家族分叉

## 当前未处理的建议项

Stitch 在部分页面回执中给出了可选建议，但本轮未接受，也未再次变体化：

- `today-page`: 更强主卡 / 更编辑化排版 / dark mode 变体
- `onboarding-page`: 品牌动画 / 更强 CTA / 展开 setup flow
- `bedtime-page`: dark mode / 呼吸练习预览 / 更简 mood selector
- `calendar-page`: 更强热力图色彩 / 下方 highlights / day detail view
- `insights-page`: journaling prompt / 更抽象可视化 / 改 headline 角度
- `profile-settings-page`: 登出按钮 / edit profile flow / 更强会员卡

本轮统一结论：先保留当前第一轮 Stitch 结果，不在进入 freeze gate 前继续扩散变体。

## 2026-06-07 HIG 重构变体

为满足“严格 HIG 优先”的新决策，本轮没有直接覆写原始 screen，而是在同一 Stitch 项目内新增了一组 HIG-first 重构变体，作为后续 Flutter 显示层对齐与 freeze 复核的新候选上游。

### 新增变体映射

| page_id | source_screen_id | hig_variant_screen_id | hig_variant_title | screenshot_name | html_name |
| --- | --- | --- | --- | --- | --- |
| `today-page` | `2eda27b626844ff491142abab092fe18` | `51b4aadf3997486abceade65db49dc26` | `Today - iOS Native Redesign` | `projects/9392137754454631344/files/94536b188af441ee949a06ca5db9e342` | `projects/9392137754454631344/files/b4089a4e61594d71803d5de0b21eeddc` |
| `calendar-page` | `c9f73ab917d54fa2828b5ab0afbc8e1b` | `6971f58fecb3473bb64e9323211849ac` | `Calendar - iOS Native Redesign` | `projects/9392137754454631344/files/22dd6503bf8d477fa7668ab40e4c100f` | `projects/9392137754454631344/files/66bc794f565b41b9b34899bee23caf0c` |
| `bedtime-page` | `f7eac11372464614a3dfe17999af8cd1` | `7f4da15704764a55a8b732c2e1ac802d` | `Bedtime - iOS Native Redesign` | `projects/9392137754454631344/files/ee3f01e2e3cb4f339c712fcf315eed5d` | `projects/9392137754454631344/files/ab01e5aeb00a4638985fc546f9c94d6f` |
| `insights-page` | `5eab24e547c646258b15c1cb24a8e221` | `74e0b55f0f5b4fe78976b7c9c3e3b48c` | `Insights - iOS Native Redesign` | `projects/9392137754454631344/files/c94eb58c07dc48358a63a73e087cf5e1` | `projects/9392137754454631344/files/28e366f68c9e45f9af8abeccab9b77e0` |
| `profile-settings-page` | `bddd6cd7240a43d6a9165fd28921ca57` | `9bbedcb82e564947828ac7d710bd4146` | `Profile - iOS Native Redesign` | `projects/9392137754454631344/files/9a51c08178c649129054c9b585d1e31d` | `projects/9392137754454631344/files/73f1fe2c004e4a5498aa082df6495bc2` |
| `onboarding-page` | `cbbe81054aa7484582cbc8cca5cde1db` | `7e4bf4d1691840e3bed58672091ce2b2` | `Onboarding - iOS Native Redesign` | `projects/9392137754454631344/files/1cce22a30f4044238e20e7921a13987c` | `projects/9392137754454631344/files/cf635a46362b420885759edc610fb3e1` |

### 本轮重构目标

- `Today`：把主行动卡改成更原生的功能入口，减少海报感，增强昨夜摘要与趋势的可读层级
- `Calendar`：把月视图改成更标准的 iOS 回看结构，避免只靠颜色表达状态
- `Bedtime`：把睡前入口改成单任务 iOS 流程页，并将状态选择收敛为更标准的 segmented/choice 语义
- `Insights`：把编辑化海报结构改成周摘要 + 关键洞察 + 次级洞察列表
- `Profile`：改成 inset grouped settings 风格，移除大面积装饰型头卡
- `Onboarding`：保留品牌识别，但改成更像 iOS 首次进入页的价值说明与开始动作

### 当前结论

- 上述 6 张 HIG 重构变体已生成并可通过各自 `screen_id` 读取
- 这批变体是当前最接近 “严格 HIG 优先” 目标的 Stitch 候选稿
- 原始第一轮 screen 仍保留在项目中，便于并行比较与回退
- 后续如果进入 freeze gate，应优先以本节 HIG 变体为复核对象，而不是继续以第一轮代表稿作为唯一上游

## 下一步

- 进入 `flutter-design-freeze-gate`
- 对照本地效果图与本 Stitch 设计源包做共享 freeze 判断
- 如 freeze 通过，再进入共享 guidelines 冻结或后续模块拆分
