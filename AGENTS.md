## 代码实现约定

- 代码实现优先使用代码注解+代码生成方案。

## Pencil 设计约束

- 当任务实施文档、实现计划或相关说明引用 `pen/app.pen`、Pencil 设计稿或 Pencil MCP 作为界面来源时，实施该任务必须将 Pencil 设计稿作为显示层实现的唯一设计标准。
- 遇到这类任务时，必须先通过 Pencil MCP 读取并核对对应页面、区块、文案承载位和交互层级，再开始实现 Flutter 显示层；不允许只根据实施文档文字描述、已有代码或主观判断推断界面结构。
- 如果当前 Flutter 实现与 Pencil 设计稿不一致，默认以 Pencil 设计稿为准进行调整，而不是优先保持现有实现。
- 只有在确认 Pencil 设计稿无法承载目标功能时，才允许提出设计缺口；在缺口被明确记录并确认之前，不得擅自偏离设计稿实现显示层。
- 本约束只作用于显示层设计标准，不要求在 Flutter 运行时直接接入 Pencil；但要求实现结果在结构、信息层级和交互语义上严格对齐设计稿。

## 插件使用约定

### 使用时机

- 本节“插件”特指 `pubspec.yaml` 中已经声明或准备新增的三方依赖包。
- 先分析再实现：当 `pubspec.yaml` 已经存在能覆盖目标场景的依赖时，只要可能就必须优先用包能力落地，不要先写占位实现、手搓简化版能力或绕开包写临时逻辑。
- 只有在以下情况才允许不直接使用现有依赖：平台前置条件尚未具备、当前任务被用户明确限制为纯占位/纯视觉稿、或用户明确要求暂不接入真实能力。
- 新增依赖前必须先确认：现有 `pubspec.yaml` 是否已有可用包、该能力是否真依赖平台/外部 SDK、以及是否有明确的落层位置。

### 最佳实践

- 一个包只暴露一个项目内适配入口：优先封装成 `Repository`、`DataSource`、`Gateway` 或 `Service`，不要让多个页面分别直接调用同一个包。
- 包返回值先在边界层转换成项目内部模型，再向内传递，避免 UI、应用层、领域层依赖三方类型、错误码和枚举。
- 初始化、权限检查、失败重试、降级策略集中处理，不要把同一套平台判断散落在多个页面或控制器中。
- 依赖能力默认要可替换：优先通过接口、Provider override、Fake/Mock 或内存实现支持测试，避免测试依赖真实设备环境。
- 涉及异步初始化的包，优先在 `app/bootstrap/` 完成全局实例准备；涉及业务能力的调用，优先下沉到 feature 对应的 `data/` 实现。
- 引入或真正接入一个包后，要补充最少一条规则测试、装配测试或降级测试，避免只在真机上人工验证。

### 分层归属

- `domain/` 禁止直接使用三方包：只保留业务实体、值对象、规则、仓储接口，不允许导入包类型、插件异常类型或平台返回模型。
- `domain/`、`data/` 下的实体类默认必须使用 `freezed` / `freezed_annotation` 注解定义，不允许长期手写可变实体或样板 `copyWith`、相等性、序列化结构；只有用户明确要求或生成链路无法覆盖时才允许例外。
- `application/` 不直接调用三方依赖：只负责用例编排、状态聚合和流程推进，可以依赖仓储接口或领域服务，但不能写平台权限、SDK 初始化和原生细节。
- `presentation/` 不直接接包实现：页面和组件只负责触发用户意图、展示状态和错误结果，不直接持有三方包实例，不直接拼装包参数。
- `presentation/` 默认强制使用 `hooks_riverpod` 组织显示层代码：页面、区块组件、表单交互、局部 UI 状态、生命周期副作用、控制器装配优先落在 Hook 方案中，目标是减少样板代码、压缩 `Consumer/ConsumerStatefulWidget` 模板代码并保持显示层实现简洁一致。
- `data/` 是业务插件的主要落点；`app/bootstrap/` 只承接全局初始化型依赖；`core/` 只承接跨 feature 通用但非业务化的公共适配。

### 现有第三方包清单

- 以下清单覆盖 `pubspec.yaml` 中全部非 SDK 依赖；`flutter`、`flutter_localizations`、`flutter_test` 不计入第三方包。
- `flutter_riverpod`：默认状态管理和依赖注入入口；新增页面状态、异步状态、控制器装配优先基于它实现，不要手写全局单例或裸 `InheritedWidget`。
- `hooks_riverpod`：显示层默认强制使用的 Riverpod 入口；页面、弹层、表单、局部状态和副作用管理优先使用 `HookConsumerWidget`、`HookWidget` 等 Hook 方案实现，除非用户明确要求不用 Hook，否则不要再回退到 `ConsumerWidget`、`ConsumerStatefulWidget` 作为默认写法。
- `go_router`：默认路由和跳转能力；页面路由、启动分发、受保护跳转统一走它，不要手写平行导航状态机。
- `riverpod_annotation`：Provider 注解入口；项目内 Riverpod Provider 必须默认使用 `@riverpod` 注解定义并通过生成代码接入，不要同一模块混用手写 Provider、旧式 Provider 风格和生成式 Provider 风格。
- `riverpod_generator`：Riverpod 代码生成器；当 Provider 进入稳定阶段或需要统一生成命名、自动 dispose、家族参数时优先使用。
- `collection`：集合工具包；需要安全集合操作、分组、比较、空安全辅助时优先使用，不要重复手写通用集合扩展。
- `drift`：结构化本地数据默认落点；睡眠记录、周报、标签、恢复计划、同步队列等长期业务数据优先用它，不要堆在内存列表或松散 JSON 里。
- `flutter_secure_storage`：敏感凭据默认存储方案；令牌、匿名身份绑定信息、敏感会话数据必须优先用它，不要回退到 `shared_preferences`。
- `freezed_annotation`：不可变模型注解入口；领域模型、表单状态、ViewState 需要值语义和 `copyWith` 时优先配合 `freezed` 使用。
- `json_annotation`：JSON 模型注解入口；远端数据、缓存结构、持久化 DTO 需要 JSON 映射时优先用它，不要长期手写脆弱的 Map 转换。
- `path`：路径拼接与规范化默认工具；文件路径、目录名组合优先用它，不要手写字符串拼接路径分隔符。
- `path_provider`：应用沙箱目录入口；只要开始落地本地文件、导出数据、缓存目录，就应优先基于它获取目录。
- `shared_preferences`：轻量本地标记与简单用户偏好；启动分发状态、布尔开关、轻量配置可用它，结构化业务数据必须优先切到 `drift`。
- `sqlite3_flutter_libs`：`drift` 的 SQLite 运行时基础包；只作为本地数据库基础设施存在，不直接承载业务逻辑。
- `uuid`：稳定 ID 生成默认工具；本地实体、离线记录、同步队列标识优先用它，不要散落手写随机字符串方案。
- `connectivity_plus`：网络连通性观测；只在确实需要网络状态提示、同步降级或重试门控时使用，不把它当作真实联网成功判断。
- `device_info_plus`：设备环境读取；仅在设备诊断、平台差异分流、埋点附加设备信息时使用，不提前侵入业务流程。
- `health`：健康数据读取与权限链路默认实现；只要开始做真实 HealthKit / Health Connect 接入，就应优先基于它封装 adapter，不要长期停留在说明页占位。
- `flutter_local_notifications`：本地提醒默认实现；真实睡前提醒、到点提醒、周报提醒必须优先基于它调度，不要保留手写定时占位逻辑。
- `flutter_timezone`：系统时区读取默认入口；通知调度、小组件时间展示、跨时区处理需要系统时区时优先用它，不要手写平台判断。
- `home_widget`：桌面小组件与快捷入口默认实现；只要开始做 widget 引导、桌面入口、快照展示，就应优先基于它封装桥接层。
- `package_info_plus`：应用版本和包信息读取；仅在关于页、诊断页、升级检查、埋点版本字段需要时使用。
- `timezone`：时区感知的时间计算与通知调度基础包；真实定时提醒和跨时区时间推算优先用它，不要只靠本地 `DateTime` 硬算。
- `google_sign_in`：Google 登录默认实现；只要开始接真实 Google 登录，不要继续停留在“仅记录点击了 Google 入口”的占位流程。
- `purchases_flutter`：订阅与会员状态默认实现；真实购买、恢复购买、权益判断必须优先基于它，不要长期保留自定义订阅状态模拟。
- `sign_in_with_apple`：Apple 登录默认实现；只要开始接真实 Apple 登录，不要继续停留在“仅记录点击了 Apple 入口”的占位流程。
- `supabase_flutter`：账号同步、云备份、换机恢复默认 SDK；进入真实远端同步、会话恢复、用户绑定时必须优先基于它封装远端数据源。
- `fl_chart`：趋势图、统计图、热力图周边图表默认实现；只要开始做真实图表，不要长期保留手写占位条块或纯文本替代。
- `intl`：时间、数字、文案格式化默认工具；日期展示、本地化格式化、复数/格式化字符串优先用它，不要散落手写格式化逻辑。
- `build_runner`：统一代码生成入口；所有 `freezed`、`json_annotation`、`riverpod_generator` 生成流程统一通过它执行。
- `flutter_lints`：项目静态检查基线；新增代码默认遵守，不允许为了省事批量关闭规则。
- `freezed`：不可变模型生成器；需要值相等、`copyWith`、联合类型时优先用它，不再长期手写样板模型。

## 国际化要求

- 新增面向用户的业务文案、按钮文案、提示文案、标题、空态、错误文案时，默认必须按国际化方案接入，不允许直接在页面、组件、控制器中长期写死字符串。
- 只有在以下情况才允许短期不接国际化：当前任务被用户明确限制为纯占位稿、调试日志、测试断言文案、或内部开发辅助文案。
- 领域层、应用层、数据层不承载最终展示文案；需要展示给用户的文本应尽量在展示层通过国际化资源解析，避免业务层拼装中文常量。
- 一旦某个功能进入真实可交付状态，对应用户可见文案必须补齐到国际化资源，不允许长期保留“后续再国际化”的临时字符串。

## Flutter 国际化约定

- 项目使用 Flutter 官方本地化链路：`flutter_localizations`、`intl`、`l10n.yaml` 和 `lib/l10n/*.arb`。
- 新增或修改文案时，先更新 `lib/l10n/app_en.arb` 模板文件，再同步更新其他语言 ARB 文件。
- 当前 Flutter 版本不启用 `synthetic-package`；业务代码从 `package:rhythm/l10n/app_localizations.dart` 导入生成类。
- 修改 ARB 或 `l10n.yaml` 后运行 `flutter gen-l10n`，再运行 `flutter test` 验证生成代码和应用入口配置。
- `MaterialApp.router` 必须挂载 `AppLocalizations.localizationsDelegates` 和 `AppLocalizations.supportedLocales`。
- 应用标题等依赖语言环境的文案通过 `onGenerateTitle` 或 widget 上下文读取，不要静态读取本地化实例字段。
