<!-- gitnexus:start -->
# GitNexus — Code Intelligence

This project is indexed by GitNexus as **rhythm** (335 symbols, 448 relationships, 7 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

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

## Flutter 国际化约定

- 项目使用 Flutter 官方本地化链路：`flutter_localizations`、`intl`、`l10n.yaml` 和 `lib/l10n/*.arb`。
- 新增或修改文案时，先更新 `lib/l10n/app_en.arb` 模板文件，再同步更新其他语言 ARB 文件。
- 当前 Flutter 版本不启用 `synthetic-package`；业务代码从 `package:rhythm/l10n/app_localizations.dart` 导入生成类。
- 修改 ARB 或 `l10n.yaml` 后运行 `flutter gen-l10n`，再运行 `flutter test` 验证生成代码和应用入口配置。
- `MaterialApp.router` 必须挂载 `AppLocalizations.localizationsDelegates` 和 `AppLocalizations.supportedLocales`。
- 应用标题等依赖语言环境的文案通过 `onGenerateTitle` 或 widget 上下文读取，不要静态读取本地化实例字段。
