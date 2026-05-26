---
name: flutter-dev
description: Use when implementing or extending the rhythm Flutter app after initialization, especially when working inside existing bounded features, wiring routes or sync flows, or following the project's local-first package and code-generation conventions.
---

# Flutter Dev

## Overview

Operate on the initialized `rhythm` Flutter app using the project decisions captured during setup. This skill is project-specific and must inherit the base rules from `flutter-project-guardrails`.

## Scope

- This skill only constrains implementation work inside the initialized `rhythm` project.
- Do not use this skill to handle project initialization, plugin setup, plugin reconfiguration, or `--force` flows.
- Initialization and plugin handling stay in `flutter-init`.

## Required Base Policy

- Apply `flutter-project-guardrails` first for mandatory package rules, feature layering, annotation usage, and forbidden mixed stacks.
- Use this skill for project-specific details that do not belong in the global guardrails.

## Project Snapshot

- Project name: `rhythm`
- Package id: `com.example.rhythm` (temporary release id, not final production package)
- Platforms: `android`, `ios`, `macos`, `linux`, `web`, `windows`
- Product focus: mobile-first sleep routine management, with health / notification / widget / purchase flows centered on iOS and Android
- Environments: local-first by default, optional Supabase sync via `--dart-define`
- Primary features: `onboarding`, `goal_schedule`, `sleep_records`, `today`, `bedtime`, `calendar`, `insights`, `profile`, `notifications`, `sync`, `membership`, `widget_bridge`, `preferences`
- Core integrations: `health`, `drift`, `shared_preferences`, `flutter_secure_storage`, `flutter_local_notifications`, `flutter_timezone`, `home_widget`, `supabase_flutter`, `google_sign_in`, `sign_in_with_apple`, `purchases_flutter`

## Workflow

1. Map the task to an existing bounded feature under `lib/features/` before creating anything new.
2. Re-check whether the change belongs to `app`, `core`, `data`, `shared`, or a specific feature, and avoid mixing responsibilities.
3. Follow the project command set and environment conventions defined in the references.
4. When adding a new project-specific decision, update the decision log instead of hiding it inside implementation details.

## Hard Rules

- Do not bypass the feature boundaries already established in `lib/features/*`.
- Do not move unrelated code from `lib/features/*` to `lib/modules/*` during normal feature work. `lib/modules/*` is reserved for explicit structure-governance tasks.
- Prefer the current project naming convention: inside features, the external integration layer is still named `data/`; do not introduce a parallel `infrastructure/` folder unless the task is an agreed structure migration.
- Do not add packages outside the approved bundle without recording the reason, owner, and verification impact.
- Do not hand-edit generated `.g.dart` or `.freezed.dart` files.
- Do not add user-facing copy directly in Dart files; update `lib/l10n/app_en.arb` first, then sync other ARB files and regenerate localizations.
- For presentation code, default to `hooks_riverpod` and generated `@riverpod` providers instead of manual state wiring.
- Before changing shared app-shell symbols such as bootstrap, router, or cross-feature services, run GitNexus impact analysis and surface the risk.

## Project Conventions

- Route strategy: `GoRouter` with `/launch` startup dispatch, five tab roots (`/`, `/calendar`, `/bedtime`, `/insights`, `/profile`), and secondary pages pushed as `CupertinoPage`
- Networking strategy: local-first; cloud and account sync go through `supabase_flutter`; no generic `dio + retrofit` layer is introduced until an independent HTTP API actually exists
- Storage strategy: `Drift` for structured local data, `SharedPreferences` for lightweight preferences and bootstrap flags, `FlutterSecureStorage` for sensitive identity/session data, optional Supabase sync for cloud state
- Test commands: `flutter test`
- Build commands: `flutter gen-l10n` and `dart run build_runner build --delete-conflicting-outputs`

## References

- Read `references/project-context.md` for the concrete product, environment, and command summary.
- Read `references/feature-map.md` for bounded feature ownership and extension rules.
- Read `references/module-map.md` for the current top-level module layout and migration boundaries.
- Read `references/decision-log.md` for project-specific architectural decisions and exceptions.
- Read `references/plugin-rules.md` before touching plugin wiring, native config, or bootstrap-time integrations.
