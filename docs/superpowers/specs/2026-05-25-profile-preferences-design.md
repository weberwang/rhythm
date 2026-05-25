# 我的页语言与主题切换设计

## 1. 背景与目标

当前 `lib/features/profile/presentation/profile_page.dart` 已经承载【我的】页首页结构，但用户还不能在应用内主动切换语言和主题。应用入口 `lib/app/rhythm_app.dart` 当前固定使用 `ThemeMode.system`，也没有基于用户偏好的全局 `locale` 状态源。

本次目标是在【我的】页新增一组偏好设置能力，支持：

- 语言切换：`跟随系统 / 简体中文 / English`
- 主题切换：`跟随系统 / 浅色 / 深色`
- 切换后立即全局生效
- 偏好值持久化到本地，下次启动继续沿用

本次实现默认不考虑旧版兼容迁移，只面向当前工程结构给出完整、可维护、可扩展方案。

## 2. 设计原则

- 保持【我的】页作为个人配置入口的语义完整性，不把语言和主题继续藏进二级页面。
- 主题与语言属于高频轻设置，交互应直接、低打断，不增加跳转和弹层。
- 状态管理、持久化、显示层三者边界清晰，避免页面直接读写 `shared_preferences`。
- 显示层遵循现有视觉基调：清醒、温和、克制、有秩序感。
- 所有面向用户的新增文案必须接入国际化，不在页面中长期写死字符串。

## 3. 方案对比

### 方案 A：我的页首页新增独立偏好设置卡片

- 在首页直接展示语言和主题两组切换控件。
- 用户点击后立即生效，无需跳转。

优点：

- 交互路径最短，反馈最直接。
- 最符合【我的】页承载用户偏好的信息架构。
- 后续继续增加时区格式、提醒风格等轻设置时，可沿同一卡片扩展。

缺点：

- 首页信息密度上升，需要控制卡片视觉权重。

### 方案 B：新增“语言与主题”二级页

- 首页新增单个入口，进入二级页后完成切换。

优点：

- 首页更简洁。
- 后续扩展空间更大。

缺点：

- 多一次跳转，和设置类型的轻量程度不匹配。
- 主题和语言切换的即时反馈链路被拉长。

### 方案 C：并入现有“小组件与主题”页

- 复用已有二级页承载主题，并在其中增加语言分区。

优点：

- 表面改动集中。

缺点：

- 信息架构不自然，语言与小组件属于不同类设置。
- 会继续放大“杂项设置堆积”的问题。

### 结论

采用方案 A：在【我的】页首页新增独立的“偏好设置”卡片。

## 4. 页面与交互设计

## 4.1 页面结构

保持【我的】页现有骨架不变：

- 顶部账号卡保留
- 原设置入口列表保留
- 底部“小组件与主题/桌面存在感”说明卡保留

在顶部账号卡下方、原设置入口列表上方插入一张新的“偏好设置”卡片，使其成为账号之后的第一优先层设置。

页面顺序调整为：

1. 顶部账号卡
2. 偏好设置卡片
3. 原设置入口列表
4. 底部说明卡

## 4.2 卡片结构

偏好设置卡片包含两个分组：

- 语言
- 主题

每个分组使用一致结构：

- 第一行：左侧显示分组标题，右侧显示当前生效值摘要
- 第二行：三段式胶囊切换控件，展示全部可选项

语言可选项：

- 跟随系统
- 简体中文
- English

主题可选项：

- 跟随系统
- 浅色
- 深色

## 4.3 视觉方向

偏好设置卡片不使用深色大 Hero 风格，而是采用低压、轻交互视觉：

- 卡片背景使用 `surface` 提亮层或浅雾绿色
- 选中态使用低饱和青绿色实底
- 未选中态使用弱描边和次级文字色
- 圆角、阴影、留白保持与现有卡片体系一致

这样可以让该区域在视觉上比普通入口更可操作，但不会抢过账号卡的主视觉位置。

## 4.4 交互规则

- 点击任一选项后立即切换全局语言或主题
- 不增加跳转、不弹底部弹层、不弹确认框
- 切换后当前页面原地刷新，底部导航和其他页面文案同步刷新
- 当主题选择“跟随系统”时，应用继续响应系统明暗变化

## 5. 架构与分层设计

新增一个独立的偏好设置 feature，专门承载应用级语言与主题偏好，而不是把逻辑堆进 `profile` 显示层。

建议目录结构：

```text
lib/features/preferences/
  domain/
    app_locale_preference.dart
    app_theme_preference.dart
    app_preferences.dart
    app_preferences_repository.dart
  data/
    app_preferences_local_data_source.dart
    shared_preferences_app_preferences_repository.dart
  application/
    app_preferences_controller.dart
```

### 5.1 domain

- `AppLocalePreference`：定义 `system / zh / en`
- `AppThemePreference`：定义 `system / light / dark`
- `AppPreferences`：聚合两个偏好值，使用 `freezed` 定义不可变实体
- `AppPreferencesRepository`：定义读取与保存偏好的边界接口

设计原因：语言和主题虽然是两个设置，但都属于“应用级显示偏好”，聚合后更利于初始化、持久化和未来扩展。

### 5.2 data

- 封装本地持久化读写
- 使用 `shared_preferences` 存储枚举值
- 提供 `AppPreferencesRepository` 的 `shared_preferences` 实现，避免显示层或入口层直接读写 key

设计原因：项目要求第三方包只暴露一个项目内适配入口，本地设置也应走边界层，避免 key 散落。

### 5.3 application

- 暴露 Riverpod provider 与 controller
- 负责初始化偏好、更新偏好、保存偏好、失败回滚
- 对外提供：
  - 当前 `AppPreferences`
  - 派生后的 `ThemeMode`
  - 派生后的 `Locale?`

设计原因：`MaterialApp.router` 只需要消费最终可用的 `ThemeMode` 和 `Locale?`，而不应该知道内部枚举和存储细节。

### 5.4 presentation

- 【我的】页新增 `偏好设置` 卡片组件
- 组件只负责读取当前偏好状态并触发切换事件
- 不直接接触 `shared_preferences`、枚举映射或全局 App 重建逻辑

## 6. 持久化方案

本次持久化使用 `shared_preferences`。

原因：

- 数据规模小，仅保存轻量枚举偏好
- 工程已引入该依赖
- 无需引入数据库表或复杂迁移

建议存储 key：

- `app_preferences.locale`
- `app_preferences.theme`

建议存储值：

- 语言：`system` / `zh` / `en`
- 主题：`system` / `light` / `dark`

首次启动若无本地记录，默认回落到：

- 语言：`system`
- 主题：`system`

## 7. 应用入口装配

当前 `lib/app/rhythm_app.dart` 中 `MaterialApp.router` 固定写死：

- `themeMode: ThemeMode.system`

需要调整为通过 provider 读取偏好派生值：

- `themeMode` 由 `AppThemePreference` 派生
- `locale` 由 `AppLocalePreference` 派生

派生规则：

- `system` -> `themeMode = ThemeMode.system`
- `light` -> `themeMode = ThemeMode.light`
- `dark` -> `themeMode = ThemeMode.dark`
- `locale = null` 表示跟随系统
- `zh` -> `Locale('zh')`
- `en` -> `Locale('en')`

这样应用会在偏好更新后直接重建顶层 `MaterialApp.router`，从而实现全局即时生效。

## 8. 异常处理与边界

## 8.1 乐观更新

切换交互采用“先更新界面，再落本地”的乐观更新策略。

原因：

- 语言与主题属于轻设置，优先保证点击后的即时反馈
- 本地持久化本身成本低，失败概率较低

## 8.2 保存失败处理

如果本地保存失败：

- 回滚到旧偏好值
- 显示一次 Snackbar 提示用户“设置未保存成功”

这样既保留即时交互感，也避免视觉状态与持久化状态不一致。

## 8.3 国际化边界

新增的所有设置名称、选项名称、失败提示文案都必须进入 ARB：

- 偏好设置标题
- 语言标题
- 主题标题
- 当前值摘要
- 选项文案
- 失败提示

其中 `English` 是否保留英文展示，属于产品选择；本次按用户已确认的切换范围实现，展示值允许作为语言名保留英文自称。

## 9. 测试设计

本次必须补齐从数据层到显示层的测试，避免只做人工验证。

### 9.1 数据层测试

验证：

- 无本地值时返回默认偏好
- 枚举值与 `shared_preferences` 存储值映射正确
- 保存后重新读取结果一致

### 9.2 应用层测试

验证：

- 初始化时能加载本地偏好
- 更新语言后状态立即变化
- 更新主题后状态立即变化
- 保存失败时会回滚到旧值
- `AppLocalePreference` 到 `Locale?` 的派生正确
- `AppThemePreference` 到 `ThemeMode` 的派生正确

### 9.3 显示层测试

验证：

- 【我的】页出现“偏好设置”卡片
- 默认状态展示“跟随系统”
- 点击语言选项后页面文案随之变化
- 点击主题选项后主题态随之变化
- 当前选中项样式与未选中项样式存在差异

### 9.4 应用级验证

至少补一条应用级测试，验证：

- 首次切换并保存偏好后，重建应用仍能恢复上次设置

## 10. 影响范围

预期改动范围主要包括：

- `lib/app/rhythm_app.dart`
- `lib/features/profile/presentation/profile_page.dart`
- 新增 `lib/features/preferences/**`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`
- 对应 `test/features/preferences/**`
- 对应 `test/features/profile/presentation/profile_page_test.dart`

本次不调整现有二级页面信息架构，不把语言和主题拆入单独路由，也不扩展主题商店等超出当前范围的能力。

## 11. 实施顺序

1. 先补偏好数据层和应用层测试，定义期望行为
2. 实现偏好实体、持久化与 controller
3. 改造 `RhythmApp` 消费全局语言与主题偏好
4. 在【我的】页插入偏好设置卡片并接入国际化文案
5. 补齐显示层测试与应用级持久化验证
6. 运行 `flutter gen-l10n` 与相关测试确认结果

## 12. 非目标

以下内容不在本次范围内：

- 主题商店
- 自定义品牌色方案
- 跟随时间自动切换主题
- 将语言/主题迁移到二级“设置中心”
- 多语言扩展到中文、英文之外的更多语种
