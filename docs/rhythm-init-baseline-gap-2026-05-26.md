# Rhythm 初始化基线差距说明

## 已具备的初始化资产

- 已有统一启动入口：`lib/app/bootstrap/app_bootstrap.dart`
- 已有统一应用根组件：`lib/app/rhythm_app.dart`
- 已有 `GoRouter` 路由入口与启动分发：`lib/app/router/app_router.dart`
- 已接入 Flutter 官方本地化链路：`lib/l10n/*.arb`
- 已有较完整的单元测试与 Widget 测试目录
- 已接入核心插件与本地数据库能力

## 本次补齐内容

- 新增项目内 `.agents/skills/flutter-dev/` 技能
- 补齐项目上下文、模块地图、决策记录、插件规则
- 更新 `README.md` 与 `pubspec.yaml` 的默认模板描述
- 新增 `lib/shared/` 与 `lib/modules/` 的结构说明占位

## 当前仍存在的结构差距

- 主业务目录仍以 `lib/features/*` 为主，尚未迁移到理想蓝图中的 `lib/modules/*`
- feature 内对外部适配层当前命名为 `data/`，尚未统一为 `infrastructure/`
- 还没有通用 `core/network` 目录；当前远端能力以 `supabase_flutter` 适配为主
- `com.example.rhythm` 仍是当前包名，尚未替换为正式发行包名
- 当前未拆分 flavor / environment 目录体系，仅通过 `--dart-define` 注入云端配置

## 后续建议

1. 以单模块为单位逐步把 `data/` 语义收敛到更清晰的基础设施层职责。
2. 若未来接入独立 HTTP API，再引入模块归属明确的 `dio + retrofit` 基线，而不是提前铺空壳。
3. 在正式发版前统一替换 Android/iOS/macOS 的包名与签名配置。
4. 若后续启动一次结构治理，可单独立项把 `features/*` 渐进迁移到 `modules/*`。
