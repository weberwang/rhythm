# Task 1 启动分发与首次激活状态 TDD 证据

## 范围

本记录只覆盖 Task 1 中 `LaunchGate` 启动分发与首次激活状态判断的 TDD 过程证据。

## 先写失败测试

先新增了测试文件：

- `test/app/launch_gate_test.dart`

测试目标：

- 首次启动时跳转到 `/onboarding/welcome`
- 已完成引导时跳转到 `/`

## 失败命令

实际先执行过以下命令：

```bash
flutter test test/app/launch_gate_test.dart
```

## 失败原因

该次执行失败，失败原因是启动分发实现尚未创建，测试引用的 Provider 文件不存在。

实际失败输出中的关键信息包括：

- `Error when reading 'lib/app/bootstrap/launch_state_provider.dart'`
- `Undefined name 'onboardingCompletedProvider'`

这说明测试先于生产代码落地，失败原因符合“缺少实现”的 TDD 预期。

## 最小实现

随后补了最小实现以让测试通过，范围包括：

- 新增 `lib/app/bootstrap/launch_state_repository.dart`
- 新增 `lib/app/bootstrap/launch_state_provider.dart`
- 新增 `lib/app/bootstrap/launch_gate.dart`
- 修改 `lib/app/bootstrap/app_bootstrap.dart`
- 修改 `lib/app/router/app_router.dart`

实现内容只覆盖 Task 1 所需能力：

- 用 `SharedPreferences` 持久化 `onboarding_completed`
- 启动入口改为 `/launch`
- 在 `LaunchGate` 中根据首次激活状态跳转到 `/` 或 `/onboarding/welcome`
- 为 `/onboarding/welcome` 注册最小占位路由

## 通过命令

补完最小实现后，实际执行过以下命令：

```bash
flutter test test/app/launch_gate_test.dart
```

后续按审查要求，又重新执行过：

```bash
flutter test test/app/launch_gate_test.dart -r expanded
```

## 通过结果

上述通过验证中，`launch_gate_test.dart` 两个用例均通过：

- `首次启动时跳转到引导欢迎页`
- `已完成引导时跳转到今日页`

扩展输出下的结果为：

- `All tests passed!`
