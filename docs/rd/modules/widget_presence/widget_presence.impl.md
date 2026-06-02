# widget_presence 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/widget_presence/widget_presence.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责小组件快照生成、隐私过滤、HomeWidget 网关、刷新和入口跳转。不负责今日页内部状态或提醒调度规则。

## 2. 继承包栈

- `home_widget`
- `riverpod_annotation`
- `freezed_annotation`

## 3. 领域模型

- `WidgetSnapshot`
- `WidgetEntrySource`
- `WidgetThemeViewState`

## 4. 应用状态

- 无目标
- 无数据
- 未授权
- 有完整摘要
- 刷新中
- 刷新失败
- 平台不可用

## 5. 基础设施边界

- `HomeWidgetGateway` 封装数据写入、刷新和入口参数。
- `WidgetSnapshotService` 从目标、今日摘要和权限状态生成低敏快照。
- 入口跳转由 `WidgetEntryController` 协调。

## 6. 数据与安全

小组件允许展示：

- 今晚目标
- 距离目标
- 昨晚状态摘要
- 入口参数

禁止展示：

- 原始入睡/起床时间
- 记录来源主键
- 时区和可信度细节
- 过细健康数据

## 7. 埋点

- `widget_guide_viewed`
- `widget_snapshot_updated`
- `widget_opened`
- `widget_theme_page_viewed`

## 8. 测试范围

- 快照隐私过滤
- 无目标快照
- 无数据快照
- 刷新失败
- 小组件入口分发

## 9. 实现约束

小组件不得直接读取底层 Repository；必须通过快照服务聚合。
