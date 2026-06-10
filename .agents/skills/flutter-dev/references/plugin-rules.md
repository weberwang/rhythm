# Plugin Rules

## Force Switch

- `--force` means: reconfigure plugins in the current task scope, then continue later tasks.
- no `--force` + missing plugin setup means: perform the first-time plugin configuration, then continue later tasks.
- no `--force` + existing plugin setup means: keep the existing plugin setup, skip plugin reconfiguration, and continue later tasks.

## Project Plugin Inventory

- Core plugin set: `health, flutter_local_notifications, flutter_timezone, home_widget, flutter_secure_storage, shared_preferences, drift`
- Platform-sensitive plugins: `google_sign_in, sign_in_with_apple, device_info_plus, connectivity_plus, package_info_plus`
- Cloud or console-backed plugins: `supabase_flutter, purchases_flutter`

## Reconfigure Notes

- Plugin reconfiguration scope: `本次未传 --force，且现有平台工程与依赖配置已存在，因此不重复覆盖插件配置。`
- Config files or native entries affected: `none in this initialization pass`
- Post-reconfigure verification: `flutter pub get; flutter analyze`
