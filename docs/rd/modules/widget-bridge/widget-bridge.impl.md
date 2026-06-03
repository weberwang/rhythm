# Widget Bridge Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[widget-bridge.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：桌面小组件快照、小组件引导、桌面入口来源桥接。
- 有界上下文：拥有平台桥接与快照更新，但不拥有业务主规则。

## 3. 继承的全局技术栈与模块使用说明

- 平台桥接：`home_widget`
- 数据来源：从 `today-feedback`、`schedule-reminders`、`bedtime-session` 消费摘要数据
- 主题：消费全局主题 token，不自建一套组件视觉体系

## 4. 领域模型与应用状态

- 领域对象：`WidgetSnapshot`、`WidgetEntrySource`
- 应用状态：快照刷新、添加引导、入口回流状态

## 5. 基础设施依赖与表现边界

- 依赖小组件网关、快照服务、入口来源控制器。
- 表现层负责引导和说明，不在页面里实现原生桥接细节。

## 6. API / 仓储 / 权限 / 后端协作说明

- 小组件快照默认从本地聚合结果生成，不依赖实时云端请求。
- 平台不支持时要回退为说明页与稍后添加路径。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：组件快照、桌面来源回流事件
- 安全：组件展示内容控制在必要摘要范围，不泄露过量敏感信息
- 埋点：小组件引导曝光、添加说明点击、桌面唤起来源
- 监控：快照刷新失败、入口路由失败、平台桥接异常
- 测试：快照生成测试、来源路由测试、平台降级测试

## 8. 模块约束

- 不允许把小组件做成独立业务岛。
- 不允许让组件展示语义偏离今日页和睡前入口主表达。
- 实现阶段在设计冻结后不得擅自增加与主应用不一致的视觉语言。

## 9. 页面级状态与路由合同

- 路由入口：
  - 激活流程、我的页和桌面回流都可进入小组件引导或来源恢复路径。
  - 小组件点击回流只能深链到今日页相关区块或睡前关键动作，不扩展到无语义首页顶层。
- 页面状态所有权：
  - 引导页拥有基础价值说明与平台步骤状态。
  - 预览页拥有基础/高级样式示意与平台支持状态。
  - 回流桥接拥有来源标记、上下文恢复和轻确认提示状态。
- 返回行为：
  - 添加完成后必须回到触发入口并留下可读确认，不打断主业务路径。
  - 桌面回流后返回系统时不得丢失当前来源标记和目标落点。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [widget-bridge.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md) 中定义的 `widget_value_preview_card`、`add_widget_step_group`、`widget_context_badge`、`widget_upgrade_preview_card` 组件边界。
- 小组件预览、引导说明和回流上下文必须共用同一套 calm 视觉层级，不能因为平台桥接而分裂成独立视觉子品牌。
- `home_widget`、快照生成和桌面来源桥接只允许在平台网关与数据边界实现；显示层只消费平台支持状态、快照摘要和回流来源语义。
