# Rhythm 初始化基线补齐设计

> 日期：2026-05-26
> 范围：基于现有工程补齐 `flutter-init` 初始化交付物，不做高风险目录大迁移

## 目标

在不打散现有业务功能的前提下，将 `rhythm` 工程补齐到可持续开发的 Flutter 初始化基线，包括项目内 `flutter-dev` 技能、初始化决策记录、模块映射、项目上下文、README 校准，以及对 bootstrap / 代码生成 / 国际化 / 测试入口的现状核验。

## 约束

- 保留现有 `lib/features/*` 结构，不进行一次性大规模迁移。
- 仅补齐初始化必需产物与低风险配置校准。
- 后续如果要迁移到更严格的 DDD 模块目录，采用按模块渐进迁移，而不是在本次初始化补齐中完成。

## 方案

### 推荐方案

采用“补齐初始化基线，最小化调整现有代码”的方案：

- 生成项目内 `.agents/skills/flutter-dev/`
- 记录项目当前架构、模块边界和插件使用规则
- 对齐 README 与工程启动说明
- 审核 `pubspec.yaml`、`lib/app`、`l10n`、测试目录是否满足初始化基线
- 输出当前结构与目标结构差距，作为后续渐进治理输入

### 不做事项

- 不重命名现有 feature 目录
- 不大规模搬迁页面、Provider、Repository
- 不为追求“理想结构”而回退已完成功能

## 交付物

- `.agents/skills/flutter-dev/SKILL.md`
- `.agents/skills/flutter-dev/references/project-context.md`
- `.agents/skills/flutter-dev/references/module-map.md`
- `.agents/skills/flutter-dev/references/decision-log.md`
- `.agents/skills/flutter-dev/references/plugin-rules.md`
- `.agents/skills/flutter-dev/agents/openai.yaml`
- README 初始化说明补齐
- 一份初始化完成摘要与剩余差距说明

## 验证

- 生成的 `flutter-dev` 技能目录完整可读
- `flutter analyze` 与 `flutter test` 至少完成一次基础验证
- 若无必要代码改动，不对现有业务逻辑做行为改变
