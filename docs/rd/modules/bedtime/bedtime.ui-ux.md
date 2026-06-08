# bedtime UI/UX RD

> 产物类型：`module_uiux_rd`
> 模块：`bedtime`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 模块目标与目标用户

`bedtime` 模块服务“今晚怎么停下来”这一关键任务。  
目标用户是已经接近目标时间、正从通知或小组件回到应用，且注意力与耐心有限的用户。

## 2. 页面范围与导航入口

- 页面范围：
  - Bedtime 顶层页
  - 通知入口态
  - 小组件入口态
  - 睡前状态选择区
  - 轻量收尾动作区
- 导航入口：
  - 底部导航 `Bedtime`
  - Today 主 CTA
  - 通知点击
  - 小组件点击

## 3. 核心用户路径

1. 用户从通知、小组件或 Today 进入 Bedtime。
2. 页面先告诉用户距离目标还有多久。
3. 用户选择今晚状态。
4. 系统给出一个低负担的收尾动作。
5. 用户完成或退出，系统保留行为线索供次日解释。

## 4. 状态矩阵

| 状态 | 触发条件 | 承载位置 | 设计处理 |
| --- | --- | --- | --- |
| ideal | 正常进入睡前页 | 主内容区 | 主动作单一、低刺激 |
| loading | 目标与建议加载中 | 主卡骨架位 | 保留层级，不闪屏 |
| empty | 尚无目标或无建议 | 主内容区 | 引导回目标设置或使用最轻默认动作 |
| error | 建议生成失败 | 建议区 | 仍提供基础收尾动作 |
| permission | 通知未授权或来源不完整 | 顶部说明区 | 解释影响，不阻断使用 |
| partial_data | 目标存在但上下文不足 | 主卡区 | 提供基础模式 |
| disabled | 某动作暂不可用 | 按钮区 | 提示原因 |
| success | 已完成状态选择 | 页面反馈区 | 轻量确认，不做庆功式表现 |

## 5. 结构语义

- `scroll_model`: `whole_page_scroll`
- `list_model`: `static_block`
- `overlay_model`: `bottom_action_area`
- `layout_model`: `linear`
- `sticky_model`: `sticky_footer`
- `component_repeatability`: 状态选择组、收尾动作卡、入口来源提示、小确认反馈

## 6. 模块级非页面组件设计骨架

| 组件 | 用途范围 | 状态/变体 | 复用边界 | 后续是否进入模块设计源冻结 |
| --- | --- | --- | --- | --- |
| 目标倒计时主卡 | 告知距离目标还有多久 | 正常、轻偏移、已过目标 | Bedtime 专有 | 是 |
| 状态选择组 | 选择今晚状态 | 准备睡觉、还想拖一会儿、可能晚睡 | Bedtime 专有 | 是 |
| 收尾动作卡 | 给出一个轻量动作 | 默认、已选择、不可用 | Bedtime / Today 共享语义 | 是 |
| 来源提示条 | 告知来自通知/小组件/Today | 不同来源变体 | Bedtime 专有 | 否 |

## 7. 设计源

- 共享冻结上游：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/pencil-design-source-packet.md`
- 页面证据：
  - `docs/rd/pencil-exports/N3lMk.png`
- 设计约束：
  - 夜间视觉低刺激，但按钮与状态必须清楚
  - 不允许把睡前页做成复杂填写页
  - 单手操作优先
- 模块阶段默认不生成新预览

## 8. 设计冻结卡

- `freeze_status`: `reserved`
- `module_component_freeze`: `reserved`
- `high_fidelity_focus`: 目标倒计时主卡、状态选择组、收尾动作卡
- `immutable_constraints`:
  - 关键路径不超过 3 次点击
  - 主动作始终单一且低负担
- `adjustable_items`:
  - 小确认反馈的表现形式
  - 来源提示条的权重

## 9. 验收门

- UI/UX：
  - 用户能在短时间内完成一次状态选择
  - 收尾动作一眼可懂
- 模块设计冻结：
  - 夜间低刺激与可操作性同时成立
- 代码交接：
  - 通知、小组件、Today 三条入口路径边界清晰

## 10. 开放问题

- 延迟提醒和更复杂睡前策略是否首发开放，仍需业务确认。
