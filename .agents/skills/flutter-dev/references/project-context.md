# Project Context

## Product Summary

- 项目名：`rhythm`
- 产品目标：做一个本地优先的作息行为管理应用，帮助晚睡用户完成“目标设置 -> 睡眠记录 -> 睡前模式 -> 次日反馈 -> 原因标签 -> 恢复建议 -> 周报洞察”的闭环
- 目标用户：以作息不稳定、经常晚睡、需要轻干预和复盘反馈的人群为核心；默认支持匿名进入以降低首启门槛
- 当前包名：`com.example.rhythm`
- 支持平台：工程壳覆盖 `android`、`ios`、`macos`、`linux`、`web`、`windows`；健康数据、通知、小组件、购买等核心业务链路以移动端为主

## Delivery Scope

- 首发范围：启动分发、Onboarding、目标作息设置、睡眠记录、今日页、睡前模式、日历热力图、周报洞察、我的页、提醒设置、账号同步、会员能力位、小组件入口
- 不在当前初始化范围：泛健康扩展、社交陪伴能力、复杂多环境 Flavor 体系、`features/*` 到 `modules/*` 的整仓迁移
- 关键集成：`health`、`drift`、`shared_preferences`、`flutter_secure_storage`、`flutter_local_notifications`、`flutter_timezone`、`home_widget`、`supabase_flutter`、`google_sign_in`、`sign_in_with_apple`、`purchases_flutter`

## Environments

- 运行模式：默认本地优先；只有在显式提供云端配置时才启用 Supabase 同步
- 配置策略：当前不拆 Flavor 目录，统一通过 `--dart-define` 注入运行时配置
- 云端配置键：`SUPABASE_URL`、`SUPABASE_PUBLISHABLE_KEY`、`SUPABASE_SYNC_ENABLED`
- Secrets 策略：云端公开配置通过 `--dart-define` 注入；敏感会话、身份或令牌由 `flutter_secure_storage` / SDK 会话层保存

## Commands

- 拉取依赖：`flutter pub get`
- 生成本地化：`flutter gen-l10n`
- 生成代码：`dart run build_runner build --delete-conflicting-outputs`
- 静态检查：`flutter analyze`
- 测试：`flutter test`
- 运行应用：`flutter run`
- Android 调试脚本：`.\scripts\run_android.ps1`
