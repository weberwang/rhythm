# new-app.pen Flutter 还原架构约束

## 输入摘要

- 设计源：`pen/new-app.pen`
- 当前已核对的顶层页面：
  - `HXIjX` 欢迎价值页
  - `xg3rA` 登录方式选择页
  - `TYxlA` 睡眠数据授权页
  - `MEfd1` 目标作息设置页
  - `sUtLx` 提醒策略设置页
  - `StZbu` 小组件添加引导页
  - `aVYpp` 今日页
  - `ZNCKc` 日历页
  - `dsKAR` 睡前页
  - `pgEGt` 洞察页
  - `GuVU7` 我的页
- 当前 Flutter 工程根：`D:\Projects\Flutter\rhythm`
- 当前落地策略：以 `new-app.pen` 为第一优先设计源，功能服从设计结构，不以现有 Flutter 页面为视觉基准。

## 图片资源导出结果

- 当前已核对页面均未发现必须导出的独立图片资源。
- 现阶段主要是矢量图标、渐变、玻璃卡、热力图单元和文字层级，不需要先导出到 `assets/images/`。

## 图片资源映射表

| 设计节点 | 建议用途 | 是否建议高保真使用 | 是否发生同名覆盖 | 备注 |
| --- | --- | --- | --- | --- |
| 无必须导出节点 | 暂无 | 否 | 否 | 当前优先用 Flutter 代码还原 |

## Flutter 资源接入结果

- 当前无需新增 `assets/images/` 接入。
- 继续后续页面时，若 `pen` 中出现真实插画、照片或纹理图，再补充到 `assets/images/` 并同步 `pubspec.yaml`。

## 全局设计结构

### Root Shell

- 全应用维持现有 `RhythmShell + NavigationBar` 路由壳。
- Pencil 底部导航只作为视觉基准，不在每个页面里重复造一份导航组件。

### Page Family

- 首启链路页：欢迎、登录、授权、目标、提醒、小组件
  - 结构特征：顶部 hero / 中段价值说明或核心选择 / 底部单主动作
- 主导航页：今日、日历、睡前、洞察、我的
  - 结构特征：同一套浅色冷调背景 + 玻璃卡层级 + 单页纵向扫描节奏

### Shared Surface Rhythm

- 页面背景统一为浅冷色渐变，不是纯白。
- 内容主体不是传统列表卡片堆叠，而是：
  - 顶部品牌 hero 卡
  - 2-4 张功能区块卡
  - 卡片内信息密度偏紧凑
- 主要区块宽度统一吃满内容列。

## 设计 Token 归纳

### Color Tokens

| 原始模式 | 归一化 Token 建议 | 语义 | Flutter 落点 | 风险/备注 |
| --- | --- | --- | --- | --- |
| `#F6F8FC ~ #E9EEF8` | `pageBackgroundTop / Bottom` | 页面背景渐变 | `ThemeExtension` | 不建议塞进 `ColorScheme` |
| `#5663A3 ~ #8A96D8` | `heroGradientTop / Bottom` | 顶部品牌 hero | `RhythmHeroThemeExtension` | 已部分存在 |
| `#FFFFFFCC ~ #FFFFFFD8` | `glassSurfacePrimary` | 玻璃卡主底色 | `ThemeExtension` | 需和普通 card 区分 |
| `#FFFFFF80 ~ #FFFFFF90` | `glassBorder` | 玻璃卡描边 | `ThemeExtension` | 不适合复用 Material 默认 divider |
| `#182033` | `contentPrimary` | 主文本 / 深色数值 | `ColorScheme.onSurface` 或扩展 | 可和现有主文本合并 |
| `#6F7891 / #8D97AE` | `contentSecondary / Tertiary` | 次文本 / 标签文本 | `ThemeExtension` | 建议保留两档层级 |
| `#EEF3FF / #E8EEF9` | `accentSoftSurface` | 选中胶囊、状态底 | `RhythmChipThemeExtension` | 已有相近能力 |
| `#F1C98A` | `lateWarningAccent` | 晚睡高亮日期 | `RhythmStatusThemeExtension` | 日历页必须保留 |

### Typography Tokens

| 原始模式 | 归一化 Token 建议 | 语义 | Flutter 落点 | 风险/备注 |
| --- | --- | --- | --- | --- |
| Newsreader 28/500 | `displayHero` | hero 主标题 | `TextTheme.headlineSmall/Medium` + 页面局部覆写 | 品牌感强，需保留 |
| Newsreader 22/500 | `displayMetric` | 时间 / 偏差数值 | `ThemeExtension` 或局部样式 | 不建议塞入通用 `TextTheme` |
| Inter 17/600 | `titleCard` | 卡片标题 | `TextTheme.titleMedium` | 可通用 |
| Inter 15/600 | `titleSection` | 次级区块标题 / 主按钮文案 | `TextTheme.titleSmall` | 可通用 |
| Inter 14/400-500 | `bodyRegular` | 主说明文案 | `TextTheme.bodyMedium` | 可通用 |
| Inter 11/500 | `labelCompact` | 日期、标签、筛选胶囊 | `TextTheme.labelSmall` | 高频复用 |

### Spacing Tokens

- 建议主节奏梯度：`8 / 10 / 12 / 14 / 16 / 18 / 20 / 24`
- 页面横向内边距统一 `20`
- 大卡圆角：
  - hero 卡 `32`
  - 普通玻璃卡 `28`
  - 内层状态块 `18~20`
  - 日期格 / 小胶囊 `9~18`

### Elevation / Surface Tokens

| 层级 | Token 建议 | Flutter 落点 | 备注 |
| --- | --- | --- | --- |
| Hero | `heroShadow` | `RhythmHeroThemeExtension` | 强品牌层级 |
| Glass Card | `glassCardShadow` | `ThemeExtension` | 主页面最常见 |
| Overlay Sheet | `overlayBlur + softShadow` | `RhythmOverlayThemeExtension` | 底部弹层与详情卡共用趋势 |

## 亮色主题方案

- 以浅冷色为底，避免当前很多 Flutter 页面默认的纯白信息面。
- `Scaffold` 背景不直接白底，而是容纳顶部到底部的浅渐变。
- `Card` 默认样式不要直接套全部页面：
  - 普通业务卡保持中性
  - 主导航核心页使用专用 glass card 语义

## 暗色主题方案

- 不做简单反色。
- 暗色模式建议保留：
  - hero 仍是蓝紫冷调，但整体亮度压低
  - glass card 改为深色半透明面，不用浅白半透明直接压暗
  - 日期热力格保留层级差，但避免高饱和暖色溢出

## 组件拆解清单

| 组件 | 设计原意 | Flutter 落法 | 是否高保真 | 是否进入主题层 | 是否抽成复用组件 | 风险/备注 |
| --- | --- | --- | --- | --- | --- | --- |
| 顶部 Hero 卡 | 建立页面情绪和产品语义 | `Shared hero card widget` | 是 | 部分进入 | 是 | 主导航页和首启页都在用 |
| Glass Card | 统一内容容器 | `Shared glass surface widget` | 是 | 是 | 是 | today / calendar / insights / profile 通用 |
| Pill / Chip | 筛选、标签、轻动作 | `Shared segmented chip / tag widget` | 是 | 是 | 是 | calendar / profile / tags 都会用 |
| Compact Metric Block | 双行标签+数值 | `Shared metric tile` | 是 | 否 | 是 | 日历详情、today 行动状态都可复用 |
| Quick Action Pill | 图标+短文案工具入口 | `Feature shared pill button` | 是 | 否 | 是 | today / calendar 快捷记录可共用 |
| Trend Mini Chart | 轻量柱图趋势 | `Feature local widget` | 否 | 否 | 否 | 先保留在 today / insights 各自特化 |
| Day Detail Card / Sheet | 单日解释层 | `BottomSheet + section rows + tag chips` | 是 | 否 | 是 | calendar 核心交互层 |

## 页面实现骨架

### Onboarding Family

- `Welcome`
  - hero
  - 三价值块
  - 单主按钮
- `Auth`
  - hero
  - 三登录入口
  - 匿名继续
- `Health`
  - hero
  - 读什么 / 不做什么 / 你会得到什么
  - 主次动作
- `Goal`
  - hero
  - 两个关键时间卡
  - 底部主次动作
- `Reminder`
  - hero
  - 三种提醒模式卡
  - 单主按钮
- `Widget Guide`
  - hero
  - 预览卡
  - 主次动作

### Main Navigation Family

#### Today

- 页面角色：主导航首页
- 结构：
  - 昨晚结果 hero 卡
  - 今晚行动卡
  - 恢复建议卡
  - 快捷记录卡
  - 趋势卡
- 状态区：
  - loading / goalMissing / permissionFailed / empty / ready

#### Calendar

- 页面角色：月视图 + 单日解释入口
- 结构：
  - 月度摘要 hero 卡
  - 月历热力图卡
  - 单日详情卡
- 交互：
  - 月切换按钮
  - 顶部模式/筛选胶囊
  - 点击日期展开详情
  - 详情进入标签弹层

#### Bedtime

- 页面角色：今晚执行页
- 结构预期：
  - 倒计时 hero
  - 今晚状态选择
  - 轻量下一步行动建议

#### Insights

- 页面角色：周报与恢复建议总览
- 结构预期：
  - 周报 hero
  - 核心指标卡
  - 原因分布
  - 恢复计划入口
  - 历史入口

#### Profile

- 页面角色：设置与能力入口集合
- 结构预期：
  - 个人状态 hero
  - 会员 / 目标 / 提醒 / 数据权限 / 小组件 / 偏好 卡片组

## 高保真 / Flutter 化取舍说明

### 建议高保真还原

- 顶部 hero 的比例、圆角、冷调渐变和文字层级
- glass card 的半透明 + 描边 + 轻阴影体系
- 主导航页的单列扫描节奏
- today / calendar 的卡片顺序和信息层级
- heatmap 的冷暖色分层

### 建议 Flutter 化重构

- Pencil 中重复画出的底部导航：
  - 保留到 `RhythmShell`
  - 页面内容区不重复实现
- 绝对定位文本与状态块：
  - 改为更稳定的 `Row / Column / Stack`
- 筛选 / 月切换 / 标签交互：
  - 使用 Flutter 可访问组件，不逐节点复刻

### 建议简化处理

- 纯装饰性背景模糊
- 仅用于展示节奏感的细小阴影差异
- 设计稿里的禁用“稍后再说”占位文字

## 实现边界建议

- 页面文件控制在 800 行内：
  - 主页面负责编排
  - 共享 glass card / hero / chip 下沉到 shared
  - feature 特有详情和图表留在 feature 内
- 领域层和应用层不为设计稿新增无业务意义的字段。
- 如果设计稿要的只是“显示顺序变化”，优先在 presentation 调整，不改 domain 语义。
- 如果设计稿要求新的信息结构，再评估是否需要补充 `ViewState` 聚合字段。

## 可供 flutter-init 消费的规范摘要

- theme constraints
  - 主导航页默认使用浅冷色页面背景渐变
  - hero / glass card / chip / overlay 统一走 `ThemeExtension`
- token constraints
  - 保持冷色主轴 + 暖色晚睡警示点缀
  - 保持 `Newsreader` 负责品牌标题与数字强调，`Inter` 负责结构文本
- component constraints
  - 必须抽出 shared `HeroCard`、`GlassCard`、`PillChip`
  - 快捷动作胶囊和 metric tile 建议作为业务共享组件
- page-shell constraints
  - 底部导航只存在于 `RhythmShell`
  - 主页面内容统一单列滚动，不做复杂嵌套滚动
- high-fidelity boundaries
  - hero、glass card、热力图层级、主信息顺序必须高保真
- Flutterization boundaries
  - 绝对坐标、重复导航、装饰性模糊与禁用占位文本允许 Flutter 化

## 风险与待确认项

- 当前 `flutter test` / `dart analyze` 在本工作区持续超时，自动化验证证据不足。
- 本地化生成链路不可用时，新增文案需要继续手动同步 `app_localizations*.dart`。
- `calendar / bedtime / insights / profile` 仍需按本文件继续逐页落地。
- 如果后续在 `pen` 中发现真实图片资源，需要补做 `assets/images/` 导出与接入。
