# Rhythm Pencil 设计稿到 Flutter 显示层落地方案

## 1. 文档目标

本文档用于把 `[pen/new-app.pen](/D:/Projects/Flutter/rhythm/pen/new-app.pen)` 中已经完成的 Pencil 设计稿，转换成 Flutter 显示层可执行的实现架构方案。

本方案不直接生成页面代码，重点解决以下问题：

- 如何把 `pen` 设计稿转换为 Flutter 主题与组件体系
- 哪些部分需要高保真还原，哪些部分应做 Flutter 化重构
- 页面、弹层、对话框、轻提示应如何拆层
- 后续实现阶段应按什么顺序推进，才能降低返工风险

## 2. 输入摘要

- 设计源：`pen/new-app.pen`
- 当前设计覆盖范围：
  - 首次激活页
  - 一级主页面
  - 二级详情与设置页
  - 底部弹层
  - 确认对话框
  - 轻提示横幅
- 当前 Flutter 项目基础：
  - 路由：`go_router`
  - 状态管理：`flutter_riverpod` + `hooks_riverpod`
  - 本地化：`flutter_localizations` + `intl` + `arb`
  - 图表：`fl_chart`
  - 项目已具备 feature-first 结构

## 3. 图片资源导出策略

### 3.1 当前结论

首批实现建议 **不优先导出图片资源**，以代码还原为主。

原因：

- 当前 `pen` 设计中大部分视觉元素属于可代码化结构，不必扁平化为图片
- 先建立可维护主题和组件体系，能减少后续显示层返工
- 渐变 Hero、卡片、胶囊、按钮、弹层、确认框都更适合用 Flutter 组件表达

### 3.2 后续可导出候选

只有以下情况建议补导出到 `assets/images/`：

- 某些 Hero 区插画存在稳定品牌语义，且代码还原成本明显偏高
- 某些月报/会员页存在生成型纹理或插画
- 某些背景装饰在 Flutter 中实现成本过高，但又确实承载品牌氛围

### 3.3 Flutter 资源接入策略

如果后续发生资源导出：

- 统一导出到 `assets/images/`
- 在 `pubspec.yaml` 中声明 `assets/images/`
- 禁止页面直接拼路径字符串，统一走命名常量或资源访问层

## 4. 全局设计结构

### 4.1 页面家族

- 首开 / 启动链路
  - 启动分发页
  - 欢迎价值页
  - 登录方式选择页
  - 健康权限说明页
  - 目标作息设置页
  - 提醒策略设置页
  - 小组件引导页
- 一级主页面
  - 今日页
  - 日历页
  - 睡前页
  - 洞察页
  - 我的页
- 二级详情与设置页
  - 手动补录
  - 周报详情
  - 历史洞察
  - 目标设置
  - 提醒设置
  - 数据接入
  - 账号同步
  - 会员中心
  - 隐私与数据
  - 小组件与主题
  - 时区与特殊模式

### 4.2 叠层家族

- Bottom Sheet
  - 时间设置
  - 分钟设置
  - 标签选择
  - 睡前拖延原因
  - 恢复计划详情
  - 稳定度说明
  - 数据来源说明
- Dialog
  - 权限补救
  - 放弃未保存修改
  - 同步失败重试
  - 删除账号
  - 导出数据
  - 清空本地数据
- Light Feedback
  - 保存成功提示
  - 同步失败轻提示
  - 会员轻提示

### 4.3 结构模式

- 一级页统一采用 `Tab Shell + Hero + Section Cards`
- 二级页统一采用 `Secondary Header + Scroll Body + Section Cards`
- 弹层统一采用 `Sheet Shell + 轻说明 + 1~3 主操作`
- 确认框统一采用 `Dialog Shell + 风险说明 + 主次操作`

## 5. 设计 Token 归纳

### 5.1 颜色 Token

- `colorBg = #EDF1F8`
- `colorSurface = #FFFFFF`
- `colorSurfaceSoft = #FFFFFFCC`
- `colorTextPrimary = #182033`
- `colorTextSecondary = #6F7891`
- `colorTextMuted = #8D97AE`
- `colorBorder = #DCE3F0`
- `colorBorderSoft = #FFFFFF4D`
- `colorHeroTop = #3D4673`
- `colorHeroBottom = #7C88C9`
- `colorAccentWarm = #F1C98A`
- `colorAccentMint = #9AC9BF`

### 5.2 字体 Token

- `fontHeading = Newsreader`
- `fontBody = Inter`
- `fontWeightRegular = 400`
- `fontWeightMedium = 500`
- `fontWeightSemibold = 600`

### 5.3 圆角 Token

- `radiusSm = 12`
- `radiusMd = 18`
- `radiusLg = 24`
- `radiusXl = 32`

### 5.4 间距 Token

- `spacing4 = 4`
- `spacing8 = 8`
- `spacing12 = 12`
- `spacing16 = 16`
- `spacing20 = 20`
- `spacing24 = 24`
- `spacing32 = 32`

## 6. 亮色主题方案

### 6.1 ThemeData 负责项

- `colorScheme`
- `textTheme`
- `scaffoldBackgroundColor`
- `cardTheme`
- `dividerColor`
- `inputDecorationTheme`
- `bottomSheetTheme`
- `dialogTheme`

### 6.2 ThemeExtension 负责项

建议新增以下扩展：

- `RhythmHeroTokens`
  - Hero 渐变、Hero 文字色、Hero 边框透明度
- `RhythmOverlayTokens`
  - 弹层底色、对话框底色、模糊/阴影语义
- `RhythmStatusTokens`
  - 成功、警告、风险、信息态颜色
- `RhythmChipTokens`
  - 芯片底色、文字色、选中态
- `RhythmCalendarTokens`
  - 日历热力图分层色

### 6.3 视觉原则

- 保留“月夜陪伴型”氛围
- 保留大圆角、柔和边框、低压阴影
- 不把背景做成纯白扁平 Material 默认风格

## 7. 暗色主题方案

### 7.1 主题原则

暗色模式不能做简单反色。

需要保留：

- 夜色 Hero 的语义连续性
- 文本层级清晰度
- 危险态与成功态语义的可识别性

### 7.2 建议策略

- 背景改为深灰蓝底，而不是纯黑
- Hero 保留蓝灰渐变，但降低高亮刺眼度
- 卡片采用深表面色 + 低透明描边
- 暖色点缀保留，但降低饱和和亮度

## 8. 组件拆解清单

### 8.1 Primitives

- `RhythmPrimaryButton`
- `RhythmSecondaryButton`
- `RhythmDangerButton`
- `RhythmChip`
- `RhythmPill`
- `RhythmSectionTitle`
- `RhythmSheetHandle`
- `RhythmBannerAction`

### 8.2 Composite Widgets

- `HeroGradientCard`
- `SectionSurfaceCard`
- `SettingEntryTile`
- `SegmentedPillSwitcher`
- `BottomSheetShell`
- `ConfirmDialogShell`
- `FeedbackBanner`

### 8.3 Business Widgets

- `TodaySummaryHero`
- `BedtimeStatusSelector`
- `BedtimeActionPreviewCard`
- `RecoveryPlanSummaryCard`
- `RecoveryPlanStepCard`
- `StabilityScoreCard`
- `SyncStatusDialog`
- `PrivacyDangerDialog`

### 8.4 Page Sections

- 首开 Hero 区
- 今日页状态区
- 日历热力图区
- 睡前状态选择区
- 洞察周报摘要区
- 我的页入口矩阵区

## 9. 页面实现骨架

### 9.1 App Shell

- 一级页统一走底部导航 Shell
- Tab bar 样式统一抽到共享布局
- 每个一级页只负责编排 Hero 和多个 section

### 9.2 Page Shell

- 二级页统一采用二级页头
- 统一背景和 section 节奏
- 滚动逻辑统一，不允许每页各自写一套壳

### 9.3 Overlay Layer

- BottomSheet：走统一 `BottomSheetShell`
- Dialog：走统一 `ConfirmDialogShell`
- Banner：走统一 `FeedbackBanner`

### 9.4 State Regions

每个页面家族都应明确：

- loading
- empty
- error
- partial content
- blocking overlay

## 10. 关键取舍说明

### 10.1 建议高保真还原

- Hero 渐变卡
- 大圆角卡片语言
- 胶囊式切换器
- 轻提示横幅
- 危险确认框与导出确认框

### 10.2 建议 Flutter 化重构

- Pencil 中的绝对定位内容块
- 伪滚轮时间选择结构
- 复杂弹层内部的重复文字层
- 某些 purely decorative 装饰节点

### 10.3 建议简化处理

- 无业务语义的弱纹理背景
- 不承载层级信息的多重阴影
- 纯视觉性小碎块

## 11. 页面与组件落地顺序建议

### 阶段一：主题与共享层

- 建立 `ThemeData`
- 建立 `ThemeExtension`
- 建立按钮、卡片、胶囊、弹层壳、对话框壳、轻提示横幅

### 阶段二：页面壳统一

- 一级页 Shell
- 二级页 Shell
- Overlay Shell

### 阶段三：一级页显示层

- 今日页
- 睡前页
- 洞察页
- 日历页
- 我的页

### 阶段四：二级页显示层

- 首先补高频设置页
- 再补历史、周报、会员、隐私等低频页

### 阶段五：弹层与对话框

- 时间弹层
- 分钟弹层
- 标签与拖延原因弹层
- 恢复计划 / 稳定度说明弹层
- 权限 / 同步 / 隐私确认框

### 阶段六：视觉回归与重构

- 对照 `pen` 做视觉回归
- 只在必要时导出图片资源
- 收敛重复样式实现

## 12. 实现边界建议

- `presentation/` 不直接依赖 Repository
- 页面只消费 Controller / ViewState
- 所有共享视觉语言放入 `shared` 层，而不是散在 feature 内
- feature 侧只保留业务化 section 和页面装配

建议新增结构：

- `lib/shared/presentation/theme/`
- `lib/shared/presentation/widgets/primitives/`
- `lib/shared/presentation/widgets/composites/`
- `lib/shared/presentation/layout/`

## 13. 可供后续实现直接消费的约束摘要

### 13.1 Theme Constraints

- 必须保留 `Newsreader + Inter` 双字体体系
- 必须保留 Hero 渐变语义
- 必须用 ThemeExtension 承接 Hero / Overlay / Status 语义

### 13.2 Token Constraints

- 页面禁止写死主色、圆角、间距
- 芯片、危险态、成功态颜色统一走语义 Token

### 13.3 Component Constraints

- 所有按钮走统一按钮组件
- 所有卡片走统一卡片组件
- 所有弹层走统一 Shell
- 所有确认框走统一 Dialog Shell

### 13.4 Page Shell Constraints

- 一级页固定 `Hero + Sections + Floating Tab Bar`
- 二级页固定 `Secondary Header + Sections`
- Overlay 禁止各 feature 各自实现一套视觉风格

### 13.5 High-Fidelity Boundaries

- Hero、关键卡片、弹层材质、危险确认框需要高保真
- 页面结构和节点树不要求 1:1 照搬 Pencil

### 13.6 Flutterization Boundaries

- 不逐节点翻译 Pencil
- 不把绝对坐标硬搬到 Flutter
- 不用图片替代本可组件化的结构

## 14. 风险与待确认项

- `pen` 中少数洞察弹层在 Pencil 截图器下存在渲染异常，但结构节点已存在。后续实现应以节点结构与文案语义为准。
- 暗色主题若要首批落地，应在页面开发前先建立完整 Token 体系。
- 是否把首批落地范围收敛为“一级页 + 高频弹层”，再补二级页，需要实现阶段再确认。
- 图片资源当前不建议首批导出；若后续决定导出，应先补一份资源映射表。
