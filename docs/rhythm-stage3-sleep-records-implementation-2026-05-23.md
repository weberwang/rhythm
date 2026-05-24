# Rhythm 阶段三实施文档：睡眠记录与手动补录

> 版本：V1.0
> 日期：2026-05-23
> 来源文档：`docs/rhythm-sleep-routine-management-dev-plan-2026-05-22.md`
> 目标阶段：阶段三「睡眠记录与手动补录」
> 适用范围：Flutter 双端 MVP，覆盖 iOS HealthKit 与 Android Health Connect 主链路

## 一、文档目标

本文件用于把总研发规划中的阶段三拆成可直接执行的实施任务，重点解决以下问题：

- 把“阶段三要做什么”拆成可排期、可分工、可测试的任务包。
- 把 iOS 与 Android 双端健康数据主链路纳入同一套实现边界。
- 把数据模型、平台适配、同步编排、手动补录、测试验收之间的依赖顺序写清楚。
- 为阶段四今日页、阶段六日历页提供统一的有效记录口径，避免后续重复返工。

## 二、阶段目标

阶段三的直接交付目标如下：

- 支持 iOS HealthKit 最近 30 天睡眠记录读取与本地入库。
- 支持 Android Health Connect 可用性检测、安装引导、权限申请、最近 30 天睡眠记录读取与本地入库。
- 支持同步失败、权限失败、平台不可用、无数据时降级到手动补录。
- 支持手动新增、编辑睡眠记录，并保留系统原始来源信息。
- 支持统一查询“用户确认后的有效记录”，供今日页和日历页复用。
- 补齐国际化、埋点、单元测试、Widget 测试与最小闭环集成测试。

## 三、阶段边界

### 3.1 本阶段负责

- 睡眠记录领域模型与时间归属规则。
- Drift 本地表结构与仓储实现。
- HealthKit / Health Connect 适配层。
- 双端 30 天同步编排与去重入库。
- 手动补录与编辑。
- 阶段性睡眠记录管理入口页。
- 有效记录查询层。
- 国际化文案、埋点、测试与人工验收清单。

### 3.2 本阶段不负责

- 今日页正式卡片编排与 7 日趋势展示。
- 日历热力图和单日详情页。
- 周报、恢复建议、原因标签。
- Supabase 云同步。
- Android 厂商兼容专项、异常机型差异处理、设备矩阵专项测试。

## 四、前置依赖

开始阶段三前，默认满足以下前提：

- 阶段二已完成目标作息设置、提醒设置与引导闭环。
- `pubspec.yaml` 中已声明 `health`、`drift`、`path_provider`、`riverpod_annotation`、`freezed_annotation`、`intl` 等依赖。
- `lib/features/goal_schedule/` 已能提供 `targetBedtimeMinutes`、`lateThresholdMinutes`、`dayStartMinutes` 等目标配置。
- 当前路由壳仍以 `TodayModulePage` 占位，因此阶段三需要单独提供中间管理页作为验收入口。

## 五、实施原则

### 5.1 领域原则

- 睡眠记录领域必须明确区分“原始系统记录”“手动补录记录”“有效展示记录”。
- 领域层禁止直接依赖 `health` 插件类型、Drift 行对象或平台异常类型。
- 时间归属规则只允许在统一规则层定义，禁止页面或仓储自行计算 `recordDate`。

### 5.2 数据原则

- 用户编辑不能直接抹掉系统原始记录。
- 有效记录查询以“用户确认结果优先”为最高原则。
- 所有记录必须保留来源、可信度、时区、更新时间等追溯信息。

### 5.3 平台原则

- iOS 与 Android 主链路共享同一套领域模型和查询层。
- 平台差异只允许在 `data/health/` 适配层和平台状态模型中收口。
- Android 的“未安装”“不可用”“已安装未授权”“已授权无数据”必须是正式业务状态，不能用占位文案糊过去。

### 5.4 工程原则

- 所有新增类、函数、实体定义必须补简体中文注释。
- 单个文件接近 800 行时优先拆分，不继续堆叠。
- 新增用户可见文案全部接入 `l10n`。
- 进入具体代码修改前，需按仓库约定对将要修改的符号执行 GitNexus impact 分析。

### 5.5 Pencil 使用约定

- 阶段三涉及真实页面交付的任务，默认以 `pen/app.pen` 作为当前 UI 基线，不应脱离既有设计文档各自发挥。
- 当 `T3-07 手动补录与编辑`、`T3-08 阶段性管理入口页`、`T3-10 国际化与埋点` 中涉及新的页面结构、卡片层级、错误态和安装引导态时，优先先在 `pen/app.pen` 中补齐对应页面或状态稿，再落 Flutter 代码。
- `pencil` 的主要用途不是替代实现，而是用于提前确认以下内容：页面区块顺序、按钮主次级、错误态信息层级、Android 安装引导与权限恢复的视觉分支、列表与空态的布局密度。
- 若某个状态只在文档中描述、未在 `pen/app.pen` 中体现，开发前应先补该状态稿，避免实现阶段才临时决定 UI 结构。
- 阶段三至少应在 `pen/app.pen` 中覆盖以下视觉稿：睡眠记录管理页、手动补录页、同步失败态、Android 未安装 Health Connect 引导态、Android 已安装未授权提示态、无数据降级态。
- 使用 `pencil` 修改设计稿时，优先采用“新增阶段三页面帧或在现有 Today 占位基础上新增入口流”的方式，避免直接破坏后续阶段会继续复用的全局模板。
- `pencil` 产出完成后，应至少执行一次截图校验，确认关键状态的层级、文案长度和主要 CTA 没有被截断，再开始对应 Flutter 页面实现。
- 设计稿与代码不一致时，以最新 `pen/app.pen` 中已确认的状态结构为准；若代码已实现但设计稿未更新，应先补设计稿再继续扩展。
- `pencil` 只负责视觉结构与交互形态确认，不替代真实平台接入、仓储实现、同步逻辑、国际化接线和自动化测试。

## 六、建议目录与文件落点

```text
lib/
  core/
    time/
      sleep_record_day_resolver.dart
  data/
    health/
      health_permission_gateway.dart
      health_sleep_data_source.dart
    local/
      rhythm_database.dart
      tables/
        sleep_records_table.dart
        sleep_record_overrides_table.dart
  features/
    sleep_records/
      application/
        manual_sleep_record_controller.dart
        sleep_record_sync_controller.dart
        query_sleep_records_use_case.dart
        effective_sleep_record_provider.dart
      data/
        drift_sleep_record_repository.dart
      domain/
        sleep_record.dart
        effective_sleep_record.dart
        sleep_record_source.dart
        sleep_record_confidence.dart
        sleep_record_rules.dart
        manual_sleep_record_form_state.dart
        repositories/
          sleep_record_repository.dart
          effective_sleep_record_repository.dart
      presentation/
        sleep_records_hub_page.dart
        manual_sleep_record_page.dart
        widgets/
          manual_sleep_record_form_section.dart
          sync_failure_card.dart
          sleep_record_list_section.dart
test/
  features/
    sleep_records/
      sleep_record_rules_test.dart
      health_sleep_data_source_test.dart
      sleep_record_sync_controller_test.dart
      manual_sleep_record_test.dart
      sleep_records_hub_page_test.dart
integration_test/
  sleep_record_manual_fallback_test.dart
```

## 七、任务总览

| 编号 | 任务名 | 核心产出 | 前置依赖 |
| --- | --- | --- | --- |
| T3-01 | 领域模型与时间规则 | 统一模型、归属日规则、有效记录优先级 | 无 |
| T3-02 | 本地表结构与仓储 | Drift 表、Repository、查询层边界 | T3-01 |
| T3-03 | 健康平台抽象 | 权限网关、平台状态模型、统一结果对象 | T3-01 |
| T3-04 | iOS HealthKit 主链路 | HealthKit 读取、映射、入库 | T3-02、T3-03 |
| T3-05 | Android Health Connect 主链路 | 可用性检测、安装引导、权限、读取、入库 | T3-02、T3-03 |
| T3-06 | 双端同步编排 | 30 天同步、去重、失败分类、重试 | T3-04、T3-05 |
| T3-07 | 手动补录与编辑 | 表单状态、保存、编辑、来源说明 | T3-02 |
| T3-08 | 阶段性管理入口页 | 管理页、同步状态卡、记录列表、路由入口 | T3-06、T3-07 |
| T3-09 | 有效记录查询层 | 最近 7/30 天有效记录 Provider | T3-02、T3-07 |
| T3-10 | 国际化与埋点 | 双端文案、事件埋点 | T3-05、T3-08 |
| T3-11 | 自动化测试 | 单测、Widget 测试、集成测试 | T3-09、T3-10 |
| T3-12 | 人工验收与交付收口 | 双端验收清单、风险复核、阶段完成确认 | T3-11 |

## 八、任务拆解明细

### T3-01 领域模型与时间规则

**目标**

- 建立阶段三的统一业务语言，避免 iOS、Android、手动补录三条链路各有一套语义。

**输入**

- 阶段二的目标作息配置。
- 总规划中的 `SleepRecordSource`、`SleepRecordConfidence` 枚举约定。

**输出**

- `SleepRecord`
- `EffectiveSleepRecord`
- `SleepRecordSource`
- `SleepRecordConfidence`
- `sleep_record_rules.dart`
- `sleep_record_day_resolver.dart`

**实施步骤**

1. 定义底层记录模型，覆盖来源、可信度、时区、是否用户修正、更新时间等字段。
2. 定义有效记录模型，明确其面向下游页面消费，而不是直接等价于底层表结构。
3. 抽离 `recordDate` 归属规则，统一处理 `dayStartMinutes` 与跨午夜睡眠。
4. 明确有效记录优先级：用户修正 > 手动补录 > 系统原始记录。
5. 为复杂时间归属和优先级逻辑补充中文注释。

**测试**

- `23:30 -> 07:00` 归属规则。
- `02:30 -> 10:00` 且 `dayStart=04:00` 的归属规则。
- 时区变化后旧记录不重算归属日。
- 有原始记录与修正记录同时存在时的有效记录选择。

**完成标准**

- 后续所有实现都可以直接复用这一层，不再重复解释记录含义。

### T3-02 本地表结构与仓储

**目标**

- 把领域模型安全落到本地存储，并建立对上稳定的仓储边界。

**输出**

- `sleep_records_table.dart`
- `sleep_record_overrides_table.dart`
- `drift_sleep_record_repository.dart`
- Repository 接口

**实施步骤**

1. 在 Drift 中建立原始记录表和用户修正表或等价覆盖结构。
2. 为记录表补齐 `recordDate`、`fellAsleepAt`、`wokeUpAt`、`durationMinutes`、`source`、`timezone`、`confidence`、`lastSyncedAt` 等字段。
3. 实现仓储接口，提供“写入原始记录”“写入手动记录”“写入用户修正”“查询最近记录”等能力。
4. 实现底层去重查询接口，为同步编排层提供复用能力。
5. 对表结构设计原因和覆盖关系补中文注释。

**测试**

- 建表成功。
- 插入原始记录。
- 插入用户修正。
- 查询最近 7 天/30 天原始记录。

**完成标准**

- 上层控制器无需直接感知 Drift 细节。

### T3-03 健康平台抽象

**目标**

- 为 iOS 与 Android 构建统一的健康数据入口和状态模型。

**输出**

- `health_permission_gateway.dart`
- `health_sleep_data_source.dart`
- 平台状态与失败结果模型

**实施步骤**

1. 定义权限状态、平台可用性状态、同步失败结果的统一内部模型。
2. 封装健康权限检查、权限申请、重新申请和平台探测接口。
3. 把插件原始错误转换成业务可读结果，禁止向上抛散乱异常。
4. 约定统一返回对象，至少包含：平台类型、状态、记录数、失败原因、最后同步时间。

**测试**

- 权限已授权。
- 权限拒绝。
- 平台不可用。
- 插件异常转业务错误。

**完成标准**

- iOS 和 Android 的上层编排逻辑可以共用一套返回契约。

### T3-04 iOS HealthKit 主链路

**目标**

- 跑通 iOS HealthKit 最近 30 天睡眠数据读取、标准化与入库。

**影响文件**

- `ios/Runner/Info.plist`
- `lib/data/health/health_sleep_data_source.dart`
- `lib/features/sleep_records/application/sleep_record_sync_controller.dart`

**实施步骤**

1. 补齐 iOS 侧健康权限说明配置。
2. 完成最近 30 天睡眠记录读取。
3. 将 HealthKit 返回结果标准化映射为项目内部记录模型。
4. 通过仓储写入本地库。
5. 输出同步结果摘要。

**测试**

- 首次授权成功。
- 用户拒绝权限。
- 无数据场景。
- 系统异常场景。

**完成标准**

- iOS 主链路可独立完成“授权 -> 同步 -> 入库 -> 查询”。

### T3-05 Android Health Connect 主链路

**目标**

- 跑通 Android Health Connect 的正式业务分支，而不是只留接口层。

**影响文件**

- `android/app/src/main/AndroidManifest.xml`
- `lib/data/health/health_permission_gateway.dart`
- `lib/data/health/health_sleep_data_source.dart`
- `lib/features/sleep_records/presentation/widgets/sync_failure_card.dart`

**实施步骤**

1. 完成 Android 侧 Health Connect 可用性检测。
2. 区分五类状态：设备不可用、未安装、已安装未授权、已授权无数据、读取异常。
3. 未安装时提供安装引导入口。
4. 已安装未授权时提供权限申请与恢复入口。
5. 已授权时读取最近 30 天睡眠记录并标准化入库。
6. 平台状态全部通过统一状态模型回传到展示层。

**测试**

- 未安装。
- 不可用。
- 已安装未授权。
- 已授权有数据。
- 已授权无数据。
- 读取异常。

**完成标准**

- Android 用户可以在所有主状态下得到明确动作路径，不会卡死在错误页。

### T3-06 双端同步编排

**目标**

- 把平台读取、去重、入库、失败分类和重试统一收口到同步用例中。

**输出**

- `sleep_record_sync_controller.dart`
- 同步结果摘要模型

**实施步骤**

1. 建立统一同步流程：平台探测 -> 权限检查 -> 记录读取 -> 标准化 -> 去重 -> 入库 -> 返回摘要。
2. 把失败结果分类为：权限失败、平台不可用、未安装、无数据、读取异常。
3. 对重复同步场景做稳定处理，避免脏数据。
4. 为 UI 提供重试入口所需状态。
5. 为埋点层输出同步成功和同步失败事件参数。

**测试**

- 首次同步成功。
- 二次同步去重。
- 同步失败重试。
- 同步后读取最近记录。

**完成标准**

- 双端同步主链路都能通过同一控制器完成编排。

### T3-07 手动补录与编辑

**目标**

- 在自动同步不可用时提供完整的人工补救闭环。

**输出**

- `manual_sleep_record_form_state.dart`
- `manual_sleep_record_controller.dart`
- `manual_sleep_record_page.dart`

**实施步骤**

1. 定义手动补录表单状态，包含记录日期、入睡时间、起床时间、编辑态与错误状态。
2. 实现跨字段校验：起床时间不能等于入睡时间，睡眠时长必须为正。
3. 先使用 `pencil` 在 `pen/app.pen` 中确认手动补录页的区块结构、字段顺序、保存按钮层级和错误提示位置。
4. 统一复用新增和编辑两种表单场景。
5. 保存时写入手动记录或用户修正记录。
6. 明确展示来源说明，告知用户不会删除原始系统记录。

**测试**

- 新增记录。
- 编辑已有记录。
- 校验失败提示。
- 保存后有效记录优先级生效。

**完成标准**

- 用户可以在没有自动同步的情况下完成可用闭环。

### T3-08 阶段性管理入口页

**目标**

- 在今日页正式完成前，提供可独立验收阶段三能力的入口页。

**输出**

- `sleep_records_hub_page.dart`
- `sleep_record_list_section.dart`
- `sync_failure_card.dart`

**实施步骤**

1. 建立记录管理页，展示同步状态、最近记录列表和主操作入口。
2. 先使用 `pencil` 在 `pen/app.pen` 中补齐管理页、同步失败态、Android 未安装引导态和无数据态的视觉稿。
3. 放置手动补录、编辑、重试、安装引导等动作入口。
4. 为 Android 不同状态展示不同 CTA。
5. 从当前 `TodayModulePage` 或独立路由提供入口。

**测试**

- 有数据状态。
- 无数据状态。
- 同步失败状态。
- Android 未安装 Health Connect 状态。

**完成标准**

- 阶段三所有能力都可从 App 内独立访问和验收。

### T3-09 有效记录查询层

**目标**

- 给阶段四今日页和阶段六日历页提供统一消费层。

**输出**

- `query_sleep_records_use_case.dart`
- `effective_sleep_record_provider.dart`

**实施步骤**

1. 建立最近 7 天/30 天有效记录查询接口。
2. 聚合原始记录、手动补录和用户修正记录。
3. 返回面向 UI 的稳定数据结构，保留来源、可信度、时区信息。
4. 保证未来页面无需再自行处理优先级逻辑。

**测试**

- 只有原始记录。
- 只有手动补录。
- 原始记录 + 用户修正。
- 最近 7 天/30 天查询结果正确。

**完成标准**

- 今日页和日历页后续只需接入这一层即可。

### T3-10 国际化与埋点

**目标**

- 防止阶段三先写死文案再返工，并保证行为数据可观测。

**影响文件**

- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`
- 埋点服务接口或调用点

**实施步骤**

1. 补齐双端权限、平台不可用、无数据、安装引导、同步结果、手动补录成功等文案键。
2. 使用 `pencil` 截图校验 Android 安装引导、权限恢复和同步失败态，确认国际化文案长度不会破坏布局。
3. 运行 `flutter gen-l10n` 更新生成文件。
4. 在同步成功、同步失败、手动创建、手动编辑四类关键行为接入埋点。
5. 确保文案不出现医疗化表达。

**测试**

- 中英文文案键完整。
- 埋点事件触发时机正确。

**完成标准**

- 阶段三新增用户文案全部走国际化资源。

### T3-11 自动化测试

**目标**

- 用自动化测试锁死阶段三的关键规则和主路径。

**输出**

- 领域单元测试
- Widget 测试
- 最小闭环集成测试

**实施步骤**

1. 补齐 `sleep_record_rules_test.dart`，覆盖归属日、优先级、去重。
2. 补齐 `health_sleep_data_source_test.dart`，覆盖平台状态映射和失败结果。
3. 补齐 `manual_sleep_record_test.dart`，覆盖新增、编辑、表单校验。
4. 补齐 `sleep_records_hub_page_test.dart`，覆盖同步状态、入口展示、Android 安装引导状态。
5. 建立 `integration_test/sleep_record_manual_fallback_test.dart`，覆盖“Android 不可用或权限失败 -> 手动补录 -> 查询有效记录”。

**完成标准**

- 阶段三最小闭环不再只靠人工点验。

### T3-12 人工验收与交付收口

**目标**

- 在进入阶段四前，把阶段三的双端闭环收口干净。

**人工验收清单**

- iOS 首次授权、拒绝授权、再次打开设置。
- Android 首次检测 Health Connect 可用性。
- Android 未安装时进入安装引导。
- Android 不可用时展示说明并降级手动补录。
- Android 已安装但未授权时重新申请权限。
- Android 授权成功后同步最近 30 天数据。
- Android 授权成功但无睡眠数据时进入手动补录。
- 同步异常时执行重试或降级补录。
- 手动编辑后查询有效记录结果更新。
- 时区切换前后记录归属稳定。

**完成标准**

- 双端都具备完整补救路径。
- 进入阶段四前，今日页所需数据口径已经稳定。

## 九、实施顺序建议

### 第一批：打底层

- T3-01 领域模型与时间规则
- T3-02 本地表结构与仓储
- T3-03 健康平台抽象

### 第二批：打双端主链路

- T3-04 iOS HealthKit 主链路
- T3-05 Android Health Connect 主链路
- T3-06 双端同步编排

### 第三批：补人工闭环

- T3-07 手动补录与编辑
- T3-08 阶段性管理入口页
- T3-09 有效记录查询层

### 第四批：收口质量

- T3-10 国际化与埋点
- T3-11 自动化测试
- T3-12 人工验收与交付收口

## 十、建议验证命令

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter test test/features/sleep_records
flutter test integration_test/sleep_record_manual_fallback_test.dart
```

## 十一、阶段完成定义

满足以下条件后，阶段三可以判定为完成：

- iOS HealthKit 主链路可读最近 30 天睡眠记录并写入本地库。
- Android Health Connect 主链路可完成可用性检测、安装引导、权限申请、记录读取与本地入库。
- 双端失败场景都能重试或降级到手动补录。
- 手动补录与编辑结果可以覆盖为“用户确认后的有效记录”。
- 今日页和日历页后续只需接入统一查询层，无需再自行合并多种记录来源。
- 阶段三自动化测试与人工验收清单完成。

## 十二、与后续阶段的衔接

阶段三完成后，可以直接为后续阶段提供以下能力：

- 阶段四今日页：读取有效记录、同步状态、无数据与权限失败状态。
- 阶段六日历页：读取按归属日聚合的有效记录、来源和可信度。
- 阶段七洞察页：基于最近 7 天有效记录计算达标率、稳定度和恢复建议。

阶段三若未完成以下能力，后续阶段会明显返工：

- 有效记录统一口径。
- Android 主链路正式接入。
- 手动补录与用户修正共存模型。
- 时间归属规则统一收口。
