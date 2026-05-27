# Decision Log

## Base Decisions

| Area | Decision | Reason | Impact |
| --- | --- | --- | --- |
| State | 统一使用 `flutter_riverpod` + `hooks_riverpod` + `@riverpod` 组织状态与依赖 | 降低显示层样板代码，并让 Provider 命名、生命周期和生成方式保持一致 | 新增控制器、状态聚合和依赖装配默认走注解生成链路 |
| Routing | 使用 `GoRouter`，由 `/launch` 启动分发页决定去向，一级主链路保持 5 个 tab 根路由，二级页统一走 `CupertinoPage` | 让首次激活、主导航和设置/详情语义分层清晰，同时保持移动端页面推进感 | 改路由时要先确认是 tab 根页还是二级详情页，避免错误地把页面塞进同一层级 |
| Network | 当前不预铺通用 `dio + retrofit` 空壳，远端能力先通过 `supabase_flutter` 承载 | 项目当前真实远端诉求是账号、同步和匿名云身份，没有独立 REST API | 需要远端改动时优先在对应 feature 的 `data/` 下封装 Supabase 适配；只有出现独立 HTTP API 再引入通用网络层 |
| Storage | 采用本地优先存储：结构化数据走 `Drift`，轻量偏好走 `SharedPreferences`，敏感身份走 `FlutterSecureStorage`，云端同步为可选增强 | 保证核心作息闭环不依赖网络，同时保留换机恢复和多设备同步能力 | 业务规则默认依赖本地数据可用；同步失败时要有降级和重试语义 |
| Structure | 当前业务主目录维持 `lib/features/*`，feature 内外部适配层沿用 `data/` 命名，不在普通任务中推进整仓迁移 | 现有功能、测试和生成代码已经围绕这一结构展开，直接搬迁风险高 | 新任务优先遵循现状边界；若要做 `modules/*` / `infrastructure/` 统一，必须单独立项 |
| Localization | 所有用户可见文案都必须先落到 `lib/l10n/app_en.arb`，再同步其他语言并重新生成本地化类 | 避免页面里散落硬编码字符串，保持中英文资源一致性 | 页面、弹层、错误态和按钮文案新增时都要连带更新 ARB 与生成文件 |

## Change Records

- 2026-05-27: 为多端启动图标生成引入 `flutter_launcher_icons` 作为开发期工具，唯一职责是从 `assets/icons/app_icon.png` 生成 Android 与 iOS 图标资源；业务代码不直接依赖该包。验证影响：需要执行 `flutter pub get`、`dart run flutter_launcher_icons -f flutter_launcher_icons.yaml`，并检查 `android/app/src/main/res/mipmap-*` 与 `ios/Runner/Assets.xcassets/AppIcon.appiconset/` 产物是否更新。
- 若后续引入独立 HTTP API、正式发行包名、多 Flavor 配置或 `features/*` 到 `modules/*` 的迁移，请在本文件追加决策记录，而不是只在实现里隐式变化
