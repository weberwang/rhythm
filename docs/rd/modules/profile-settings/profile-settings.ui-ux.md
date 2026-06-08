# profile-settings UI/UX RD

> 产物类型：`module_uiux_rd`
> 模块：`profile-settings`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 模块目标与目标用户

`profile-settings` 负责承载账户、会员、同步、权限、目标与提醒配置，以及隐私和合规入口。  
目标用户是需要调整配置、查看会员状态、处理权限/同步问题的用户。

## 2. 页面范围与导航入口

- 页面范围：
  - Profile 顶层页
  - 账户区
  - 会员区
  - 同步与权限区
  - 目标与提醒设置区
  - 隐私与支持区
- 导航入口：
  - 底部导航 `Profile`
  - onboarding 完成后的后续设置入口
  - Today / Calendar / Insights 的设置跳转入口

## 3. 核心用户路径

1. 用户进入 Profile，先看到账户与会员状态。
2. 用户查看同步/权限是否正常。
3. 用户调整目标作息或提醒策略。
4. 用户进入隐私、导出、支持或小组件等次级入口。

## 4. 状态矩阵

| 状态 | 触发条件 | 承载位置 | 设计处理 |
| --- | --- | --- | --- |
| ideal | 状态完整 | 分组列表区 | 信息分组清晰、可信安静 |
| loading | 会话或配置读取中 | 分组骨架位 | 保留层级 |
| empty | 未登录或配置缺失 | 账户区/设置区 | 提供继续使用或补充设置路径 |
| error | 同步失败或权限状态异常 | 同步/权限区 | 解释并给修复入口 |
| permission | 健康/通知权限未开 | 权限区 | 说明影响与重新授权入口 |
| partial_data | 会话存在但部分能力未准备好 | 页面分组区 | 精确说明缺口 |
| disabled | 某高级设置不可用 | 相关设置行 | 说明限制 |
| success | 设置已更新 | 行内反馈或轻提示 | 克制确认 |
| locked | 高级设置锁定 | 相关设置行 | 展示价值与升级理由 |

## 5. 结构语义

- `scroll_model`: `whole_page_scroll`
- `list_model`: `grouped_list`
- `overlay_model`: `modal_layer`
- `layout_model`: `linear`
- `sticky_model`: `none`
- `component_repeatability`: 分组标题、设置行、会员状态卡、权限说明行、同步状态行

## 6. 模块级非页面组件设计骨架

| 组件 | 用途范围 | 状态/变体 | 复用边界 | 后续是否进入模块设计源冻结 |
| --- | --- | --- | --- | --- |
| 会员状态卡 | 显示权益与升级入口 | 免费、试用、订阅中、异常 | Profile / Insights 共享商业语义 | 是 |
| 分组设置行 | 各类配置入口 | 默认、说明、副标题、锁定 | Profile 专有，设置类复用 | 是 |
| 权限状态行 | 健康/通知权限说明 | 正常、未开、异常 | Profile / onboarding 共享语义 | 是 |
| 同步状态行 | 账户与云同步状态 | 正常、失败、等待 | Profile 专有 | 是 |

## 7. 设计源

- 共享冻结上游：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/pencil-design-source-packet.md`
- 页面证据：
  - `docs/rd/pencil-exports/BwvXZ.png`
- 设计约束：
  - 安静可信、分组清晰
  - 会员入口可见但不喧宾夺主
- 模块阶段默认不生成新预览

## 8. 设计冻结卡

- `freeze_status`: `reserved`
- `module_component_freeze`: `reserved`
- `high_fidelity_focus`: 会员状态卡、分组列表层级、权限/同步状态行
- `immutable_constraints`:
  - 重要隐私与数据入口必须可找到
  - 会员入口不能压过信任与设置主任务
- `adjustable_items`:
  - 分组标题密度
  - 行内说明文字长度

## 9. 验收门

- UI/UX：
  - 用户能快速找到目标、提醒、同步、权限和隐私入口
  - 页面整体可信安静
- 模块设计冻结：
  - 分组层级与会员入口权重明确
- 代码交接：
  - 账户、会员、同步、目标、提醒入口边界清晰

## 10. 开放问题

- 首发会员权益展示姿态与定价表达仍需商业最终确认。
