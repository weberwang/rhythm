# Feature Map

## Primary Features

- `onboarding`：首次激活链路，负责价值说明、登录/匿名进入、健康权限说明、目标作息与提醒设置的首轮引导
- `goal_schedule`：负责目标入睡/起床时间、熬夜阈值、一天起始时间、时区模式等作息目标配置
- `sleep_records`：负责健康数据同步、手动补录、记录修正、晚睡原因标签、来源与可信度展示
- `today`：负责今日摘要、主行动入口、恢复建议摘要与关键快捷操作聚合
- `bedtime`：负责睡前模式、倒计时、状态建议、睡前流程入口
- `calendar`：负责热力图、月视图、日详情、筛选和情绪纸面表达
- `insights`：负责周报、稳定度、原因分布、恢复效果、历史洞察与付费承接入口

## Supporting Features

- `profile`：负责“我的”页面、隐私、数据接入、个人入口聚合
- `notifications`：负责提醒策略、通知权限、通知调度相关能力
- `sync`：负责账号与同步状态、同步队列、云端对账与失败重试
- `membership`：负责会员权益、付费墙、购买与恢复购买链路
- `widget_bridge`：负责桌面小组件快照、入口来源和主题桥接
- `preferences`：负责语言、主题等轻量应用偏好

## Ownership Rules

- `presentation` 只负责页面、组件、文案承载和用户交互
- `application` 负责聚合状态、Provider 暴露、用例编排和流程推进
- `data` 负责仓储实现、本地库、插件接入、远端同步和第三方 SDK 适配
- `domain` 负责实体、值对象、业务规则和仓储契约

## Extension Rules

- 新任务如果沿用同一业务语言和生命周期，优先放进已有 feature，而不是平铺新目录
- 只有在引入新的业务能力边界、独立数据依赖簇或独立交互闭环时，才创建新的 feature
- 跨 feature 协作优先通过仓储接口、Provider 契约或共享值对象完成，不要直接制造隐式循环依赖
