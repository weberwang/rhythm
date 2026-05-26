# rhythm

`rhythm` 是一个本地优先的 Flutter 作息行为管理应用，目标是帮助用户完成目标作息设置、睡眠记录、睡前模式、次日反馈、恢复建议与周报洞察的闭环。

## 当前工程基线

- 应用壳：`lib/app/`
- 核心公共能力：`lib/core/`
- 现有业务模块：`lib/features/`
- 本地化资源：`lib/l10n/`
- 测试：`test/`、`integration_test/`
- 项目内开发技能：`.agents/skills/flutter-dev/`

当前仓库已经具备启动壳、路由、国际化、测试和插件接入。目录仍以 `lib/features/*` 为主，后续如需迁移到更严格的 `lib/modules/*` 蓝图，采用按模块渐进治理，不在普通业务任务中整仓搬迁。

## 常用命令

```powershell
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

## 云端同步配置

当前项目默认本地优先运行。若要启用 Supabase 同步，需要通过 `--dart-define` 提供运行时配置：

```powershell
flutter run `
  --dart-define=SUPABASE_URL=... `
  --dart-define=SUPABASE_PUBLISHABLE_KEY=... `
  --dart-define=SUPABASE_SYNC_ENABLED=true
```

## Android 调试脚本

- 脚本路径：`scripts/run_android.ps1`
- 作用：一键完成 Android 设备检测、模拟器选择或启动，以及 `flutter run`

### 用法

```powershell
.\scripts\run_android.ps1
```

### 可选参数

```powershell
.\scripts\run_android.ps1 -SkipPubGet
```

- `-SkipPubGet`：跳过 `flutter pub get`
