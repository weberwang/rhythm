# rhythm

A new Flutter project.

## Android 调试脚本

- 脚本路径：`scripts/run_android.ps1`
- 作用：一键完成 Android 设备检测、模拟器选择/启动，以及 `flutter run`

### 用法

```powershell
.\scripts\run_android.ps1
```

- 如果已经连接 Android 设备：
  - 只有一个设备时直接运行
  - 有多个设备时会列出设备并让你选择
- 如果没有连接 Android 设备：
  - 会列出可用 Android 模拟器
  - 需要先选择一个模拟器
  - 选择后自动启动模拟器并等待设备上线
  - 随后执行 `flutter run`

### 可选参数

```powershell
.\scripts\run_android.ps1 -SkipPubGet
```

- `-SkipPubGet`：跳过 `flutter pub get`
