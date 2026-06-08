# onboarding-activation UI/UX RD

> 产物类型：`module_uiux_rd`
> 模块：`onboarding-activation`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 模块目标与目标用户

该模块负责将首次用户以最低阻力带入可用状态。  
目标用户是首次安装用户、清空数据后重新进入的用户，以及需要重新完成关键首用配置的用户。

## 2. 页面范围与导航入口

- 页面范围：
  - 欢迎价值页
  - 登录选择页
  - 健康数据授权页
  - 目标作息设置页
  - 提醒策略设置页
  - 小组件引导页
  - 完成过渡页
- 导航入口：
  - `app-shell` 启动分发
  - 个人中心内的重新配置入口
- 壳层归属：
  - `Onboarding` 不属于共享底部导航壳层

## 3. 核心用户路径

1. 用户进入欢迎价值页，理解 Rhythm 的核心承诺。
2. 用户选择登录或稍后处理登录。
3. 用户完成健康数据授权或选择手动路径。
4. 用户设置目标作息。
5. 用户设置提醒策略。
6. 用户查看小组件价值说明。
7. 用户进入 Today 首页，形成首次可用状态。

## 4. 状态矩阵

| 状态 | 触发条件 | 承载位置 | 设计处理 |
| --- | --- | --- | --- |
| ideal | 首用流程正常推进 | 各步骤页 | 一步一步推进，不制造压力 |
| loading | 登录/授权/保存中 | 当前步骤主区 | 轻等待，不打断上下文 |
| empty | 无健康数据或跳过登录 | 授权页/完成页 | 明确仍可继续 |
| error | 登录失败、保存失败 | 当前步骤页内 | 就地解释并允许重试或跳过 |
| permission | 健康权限拒绝 | 授权页 | 明确价值与手动路径 |
| partial_data | 已授权但暂无数据 | 授权页/完成页 | 解释延迟，允许先继续 |
| disabled | 某项能力暂不可用 | 相关设置项 | 说明影响，不阻断首用 |
| success | 完成首用 | 完成过渡页 | 安静过渡到 Today |

## 5. 结构语义

- `scroll_model`: `whole_page_scroll`
- `list_model`: `mixed`
- `overlay_model`: `bottom_action_area`
- `layout_model`: `linear`
- `sticky_model`: `sticky_footer`
- `component_repeatability`: 登录入口组、权限说明卡、时间选择容器、提醒选项行、小组件说明卡

## 6. 模块级非页面组件设计骨架

| 组件 | 用途范围 | 状态/变体 | 复用边界 | 后续是否进入模块设计源冻结 |
| --- | --- | --- | --- | --- |
| 首用步骤主卡 | 承载每一步的主信息 | 默认、加载、错误提示共存 | onboarding 内部 | 是 |
| 登录入口组 | Apple / Google / 邮箱 / 稍后路径 | 默认、失败、不可用 | onboarding 与设置页部分复用 | 是 |
| 权限说明卡 | 说明健康数据价值与边界 | 默认、拒绝后解释 | onboarding 与 profile 中权限解释共享语义 | 是 |
| 时间设置容器 | 目标入睡/起床时间设置 | 默认、校验中 | onboarding 与 profile 设置共用语义 | 是 |
| 提醒选项行 | 柔性提醒、到点提醒、周报提醒 | 开、关、说明态 | onboarding 与 profile 设置复用 | 是 |

## 7. 设计源

- 共享冻结上游：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/light-theme-freeze.yaml`
  - `docs/rd/dark-theme-freeze.yaml`
  - `docs/rd/pencil-design-source-packet.md`
- 页面证据：
  - `docs/rd/pencil-exports/dMZS3.png`
- 设计约束：
  - 首屏价值解释与主 CTA 属于高保真区域
  - 不允许将 onboarding 做成纯品牌展示
  - 不允许在授权后立即强推付费
- 模块阶段默认不生成新预览；需要时必须显式 `--perviewer`

## 8. 设计冻结卡

- `freeze_status`: `reserved`
- `module_component_freeze`: `reserved`
- `high_fidelity_focus`: 首屏价值解释、登录选择密度、权限说明与主 CTA 层级
- `immutable_constraints`:
  - 每一步都要减少一个首用阻力
  - 可以跳过部分能力，但不能把跳过设计成失败感
- `adjustable_items`:
  - 步骤进度表现方式
  - 小组件引导的说明长度

## 9. 验收门

- UI/UX：
  - 2 分钟内可进入可用状态
  - 用户能理解为什么需要权限或为什么可以先跳过
- 模块设计冻结：
  - 各步骤主次信息稳定
  - CTA 姿态保持安静邀请型
- 代码交接：
  - 登录、权限、目标、提醒、小组件引导的边界清晰

## 10. 开放问题

- 首发是否允许完全匿名进入，仍需最终商业决定。
- 首发市场语言策略会影响 onboarding 首屏文案优先级。
