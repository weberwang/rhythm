# Plugin Rules

## Force Switch

- `--force` means: reconfigure plugins in the current task scope, then continue later tasks.
- no `--force` + missing plugin setup means: perform the first-time plugin configuration, then continue later tasks.
- no `--force` + existing plugin setup means: keep the existing plugin setup, skip plugin reconfiguration, and continue later tasks.

## Project Plugin Inventory

- Core plugin set: `flutter_secure_storage, shared_preferences, supabase_flutter, flutter_local_notifications, timezone, flutter_timezone`
- Platform-sensitive plugins: `health, home_widget, google_sign_in, sign_in_with_apple`
- Cloud or console-backed plugins: `supabase_flutter, purchases_flutter`

## Reconfigure Notes

- Plugin reconfiguration scope: `仅在当前 RD 需要的原生插件接线缺失或显式传入 --force 时刷新；否则保留现有平台配置`
- Config files or native entries affected: `android/, ios/, macos/, web/, windows/, linux/, .flutter-plugins-dependencies, pubspec.yaml`
- Post-reconfigure verification: `flutter pub get && flutter analyze && flutter test`
