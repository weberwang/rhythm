# Rhythm 项目约束

## Flutter 插件与代码生成最佳实践

### Riverpod / Hooks 约束

- 状态管理必须优先使用 `flutter_riverpod`、`hooks_riverpod`、`riverpod_annotation`、`riverpod_generator` 这一套，不要在新代码里回退到 `provider`、`setState` 驱动全局状态或手写单例容器。
- 页面组件默认优先使用 `HookConsumerWidget`、`ConsumerWidget` 或 `ConsumerStatefulWidget`，根据是否需要 hooks 决定具体类型。
- 只要是新建或重构的 Provider，默认使用 `@riverpod` 注解生成，不再新增手写 `Provider`、`NotifierProvider`、`FutureProvider` 样板，除非生成方式确实无法表达。
- Provider 命名必须和业务语义一致，禁止出现 `fooProvider`、`tempProvider`、`testProvider` 这类无业务含义的名字。
- Provider 只负责状态装配、依赖注入和用例编排，不要把 Widget 逻辑、路由跳转细节或平台 API 直接塞进 Provider。
- UI 层不要跨层直接读写多个 Repository；跨领域组合必须收敛到 Provider / Controller / UseCase。
- 如果某个状态需要持久化、可测试和可覆盖，必须通过 Riverpod Provider 暴露，不要偷偷挂在静态变量里。

### Freezed / JSON 约束

- 业务实体、页面状态对象、请求响应模型优先使用 `freezed` 定义，不要继续新增手写 `copyWith`、`==`、`hashCode`、`toString` 样板类。
- 只要模型存在序列化、缓存、接口传输或数据库嵌套字段需求，就必须补 `fromJson/toJson`，并通过 `json_serializable` 生成。
- `freezed` 模型必须拆分到独立文件，保留 `part '*.freezed.dart';` 和需要时的 `part '*.g.dart';`。
- 禁止手改生成文件：`*.freezed.dart`、`*.g.dart`、`*.gr.dart`、`*.drift.dart` 一律只允许通过生成器更新。
- 模型字段命名默认与领域语言一致；如果接口字段不一致，使用注解映射，不要为了迁就接口污染领域命名。

### Drift 约束

- 本地持久化必须优先使用 `drift`，不要在新功能里并行引入第二套本地数据库方案。
- 表定义、数据库入口、DAO/Repository 边界必须清晰：`Table` 负责结构，数据库类负责注册，Repository 负责业务读写，不要把业务逻辑塞进表或数据库类。
- 复杂查询优先封装到 Repository 或专门的数据访问层，不要在页面或 Provider 中直接拼 Drift 查询。
- 测试数据库默认使用内存连接；涉及 Widget 测试时，数据库关闭策略要兼容测试环境，避免流关闭导致的假失败。
- 数据库存储的是持久化结构，不等于领域实体；复杂业务判断仍应保留在 domain / application 层。

### build_runner 与生成流程约束

- 只要修改了 `@riverpod`、`@freezed`、`@JsonSerializable`、`DriftDatabase`、`Table` 或相关 `part` 文件，必须重新运行代码生成。
- 默认生成命令使用：
  `dart run build_runner build --delete-conflicting-outputs`
- 如需持续开发观察，可使用：
  `dart run build_runner watch --delete-conflicting-outputs`
- 完成任务前必须确认生成文件与源文件一致，不能留下“改了注解但没生成”的半成品状态。
- 如果代码生成失败，先解决依赖和版本冲突，再继续写业务代码；不要带着坏掉的生成链继续堆实现。

### 目录与分层约束

- 新代码继续遵循 `轻量 DDD + Clean Architecture + feature-first`：
  `presentation` 放 UI，`application` 放状态/用例编排，`domain` 放业务概念和规则，`data` 放存储与平台实现。
- `features/*` 目录必须按业务边界组织，不要为了省事把多个无关功能塞进一个文件夹。
- 同一文件超过 800 行前必须拆分；当生成文件不计入约束时，源文件仍必须遵守 800 行限制。
- 类、函数、实体定义必须补简体中文注释，重点解释业务意图、边界条件和设计原因。

### 测试约束

- 新增业务规则时，必须优先写单元测试；新增页面交互时，必须优先写 Widget 测试。
- 修 Bug 必须先写能复现问题的失败测试，再修实现，不允许只靠手工验证。
- 对 Provider / Controller 的核心逻辑，优先测试业务状态变化，而不是只测 UI 文案。
- 如果新增模型依赖生成文件，测试前必须先完成代码生成，避免把“未生成”误判成业务失败。

### 提交前检查

- 提交前必须至少运行与本次改动相关的测试；如果影响范围较大，必须跑 `flutter test` 和 `flutter analyze`。
- 修改了代码生成相关内容时，提交前必须确认生成文件已经更新并纳入版本控制。
- 如果依赖版本发生变化，提交前必须确认 `flutter pub get` 成功，并检查 `pubspec.lock` 是否同步更新。

<!-- gitnexus:start -->
# GitNexus — Code Intelligence

This project is indexed by GitNexus as **rhythm** (422 symbols, 532 relationships, 7 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

> If any GitNexus tool warns the index is stale, run `npx gitnexus analyze` in terminal first.

## Always Do

- **MUST run impact analysis before editing any symbol.** Before modifying a function, class, or method, run `gitnexus_impact({target: "symbolName", direction: "upstream"})` and report the blast radius (direct callers, affected processes, risk level) to the user.
- **MUST run `gitnexus_detect_changes()` before committing** to verify your changes only affect expected symbols and execution flows.
- **MUST warn the user** if impact analysis returns HIGH or CRITICAL risk before proceeding with edits.
- When exploring unfamiliar code, use `gitnexus_query({query: "concept"})` to find execution flows instead of grepping. It returns process-grouped results ranked by relevance.
- When you need full context on a specific symbol — callers, callees, which execution flows it participates in — use `gitnexus_context({name: "symbolName"})`.

## Never Do

- NEVER edit a function, class, or method without first running `gitnexus_impact` on it.
- NEVER ignore HIGH or CRITICAL risk warnings from impact analysis.
- NEVER rename symbols with find-and-replace — use `gitnexus_rename` which understands the call graph.
- NEVER commit changes without running `gitnexus_detect_changes()` to check affected scope.

## Resources

| Resource | Use for |
|----------|---------|
| `gitnexus://repo/rhythm/context` | Codebase overview, check index freshness |
| `gitnexus://repo/rhythm/clusters` | All functional areas |
| `gitnexus://repo/rhythm/processes` | All execution flows |
| `gitnexus://repo/rhythm/process/{name}` | Step-by-step execution trace |

## CLI

| Task | Read this skill file |
|------|---------------------|
| Understand architecture / "How does X work?" | `.claude/skills/gitnexus/gitnexus-exploring/SKILL.md` |
| Blast radius / "What breaks if I change X?" | `.claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md` |
| Trace bugs / "Why is X failing?" | `.claude/skills/gitnexus/gitnexus-debugging/SKILL.md` |
| Rename / extract / split / refactor | `.claude/skills/gitnexus/gitnexus-refactoring/SKILL.md` |
| Tools, resources, schema reference | `.claude/skills/gitnexus/gitnexus-guide/SKILL.md` |
| Index, status, clean, wiki CLI commands | `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` |

<!-- gitnexus:end -->
