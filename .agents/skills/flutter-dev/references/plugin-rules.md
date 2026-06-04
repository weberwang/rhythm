# Plugin Rules

## Force Switch

- `--force` means: reconfigure plugins in the current task scope, then continue later tasks.
- no `--force` + missing plugin setup means: perform the first-time plugin configuration, then continue later tasks.
- no `--force` + existing plugin setup means: keep the existing plugin setup, skip plugin reconfiguration, and continue later tasks.

## Project Plugin Inventory

- Core plugin set: `flutter_secure_storage, shared_preferences, supabase_flutter, flutter_local_notifications, timezone, flutter_timezone, drift`
- Platform-sensitive plugins: `health, home_widget, google_sign_in, sign_in_with_apple`
- Cloud or console-backed plugins: `supabase_flutter, purchases_flutter`

## Reconfigure Notes

- Plugin reconfiguration scope: `本次 flutter-init 未传入 --force，且工程已存在平台目录与插件解析产物，因此保留现有原生插件配置`
- Config files or native entries affected: `android/, ios/, macos/, web/, windows/, linux/, .flutter-plugins-dependencies, pubspec.yaml`
- Post-reconfigure verification: `flutter pub get && flutter gen-l10n && dart run build_runner build --delete-conflicting-outputs && flutter analyze && flutter test`
