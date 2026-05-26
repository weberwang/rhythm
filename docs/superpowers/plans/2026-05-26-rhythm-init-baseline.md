# Rhythm Init Baseline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 补齐 `rhythm` 项目的初始化基线资产，同时避免对现有功能代码做高风险迁移。

**Architecture:** 以现有 `lib/features/*` 结构为主，优先补项目内技能、说明文档和结构占位。现有业务代码不做大规模搬迁，只记录与理想蓝图的差距，为后续渐进治理提供依据。

**Tech Stack:** Flutter、Riverpod、GoRouter、Drift、SharedPreferences、Supabase、build_runner、Flutter l10n

---

### Task 1: 生成项目内 flutter-dev 技能

**Files:**
- Create: `.agents/skills/flutter-dev/SKILL.md`
- Create: `.agents/skills/flutter-dev/agents/openai.yaml`
- Create: `.agents/skills/flutter-dev/references/project-context.md`
- Create: `.agents/skills/flutter-dev/references/module-map.md`
- Create: `.agents/skills/flutter-dev/references/decision-log.md`
- Create: `.agents/skills/flutter-dev/references/plugin-rules.md`

- [ ] 复制模板并替换占位符
- [ ] 写入项目快照、命令约定、模块归属与插件规则

### Task 2: 补齐初始化说明

**Files:**
- Modify: `README.md`
- Modify: `pubspec.yaml`
- Create: `docs/rhythm-init-baseline-gap-2026-05-26.md`

- [ ] 将 README 从默认模板说明升级为项目说明
- [ ] 更新 pubspec 描述，去除默认工程语义
- [ ] 输出当前结构与目标蓝图的差距说明

### Task 3: 补齐结构占位

**Files:**
- Create: `lib/shared/README.md`
- Create: `lib/modules/README.md`

- [ ] 为未来共享层和模块化目录补说明文件
- [ ] 明确当前不做整仓迁移，只做渐进治理

### Task 4: 运行校验

**Files:**
- Verify only

- [ ] 运行 `flutter pub get`
- [ ] 运行 `flutter gen-l10n`
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`
- [ ] 运行 `flutter analyze`
- [ ] 运行 `flutter test`
