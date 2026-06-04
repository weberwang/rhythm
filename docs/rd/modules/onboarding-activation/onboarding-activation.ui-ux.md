# onboarding-activation UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：在 2 分钟内把用户从“第一次打开”推进到“今晚可开始使用”。
- 目标用户：首次安装用户、尚未完成授权/目标设置的回流用户。

## 页面范围与导航入口

- 欢迎价值页
- 登录选择页
- 健康授权页
- 目标作息设置页
- 提醒策略页
- 小组件引导页
- 完成过渡页

## 核心用户路径

1. 用户看到产品承诺。
2. 选择登录或稍后同步。
3. 授权健康数据，或切入手动路径。
4. 设置目标入睡/起床时间与阈值。
5. 选择提醒策略。
6. 了解小组件价值。
7. 进入正式今日页。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| ideal | 单页单目标推进 |
| login_failed | 页内反馈 + 重试 / 稍后继续 |
| permission_denied | 提供手动路径 |
| platform_unavailable | 文案解释 + 降级路径 |
| partial_setup | 回流时回到未完成步骤 |
| network_offline | 不阻断本地激活 |

## 结构语义

- `scroll_model`: whole-page scroll
- `list_model`: static block
- `overlay_model`: modal layer
- `layout_model`: linear
- `sticky_model`: sticky footer
- `component_repeatability`:
  - 步骤页主标题区
  - 主按钮区
  - 价值点列表
  - 设置 cell / 选择块

## 模块级组件骨架

- `OnboardingHeroPanel`
- `AuthOptionStack`
- `PermissionValueCard`
- `GoalSetupTimeBlock`
- `ReminderChoiceCell`
- `WidgetGuideCard`
- `CompletionTransitionPanel`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 模块视觉证据：`docs/rd/modules/onboarding-activation/onboarding-welcome.png`
- 本模块冻结包：本文 + `onboarding-activation.impl.md` + 共享冻结产物 + 模块预览图

## 设计冻结卡

- 已冻结：
  - 每页只有一个主目标
  - 登录不是付费触点
  - 权限失败仍能继续
  - 完成页不强推订阅
- 允许工程调整：
  - 时间选择器具体控件样式
  - 小组件指引的分平台说明布局

## 验收门槛

- 首屏必须 3 秒内解释产品价值，不出现医疗暗示。
- 权限页必须明确“读取什么 / 不读取什么 / 用户得到什么”。
- 目标作息页不能像复杂设置页。
- 完成页必须自然导入今日页，而不是结束感很强的“任务完成页”。
