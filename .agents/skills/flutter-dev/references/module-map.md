# Module Map

## Current Top-Level Modules

- `lib/app`：应用壳层，承载 bootstrap、启动分发、根组件、主题和顶层路由
- `lib/core`：跨 feature 的技术公共能力，例如时间语义、分析埋点、通用展示组件
- `lib/data`：当前仍保留在根目录下的共享基础设施实现，例如本地数据库和部分跨 feature 数据源
- `lib/features`：现阶段的主业务承载位，所有作息、记录、洞察、同步、会员、小组件等有界能力都优先在这里维护
- `lib/shared`：预留给真正跨模块复用、又不属于单一业务边界的稳定共享能力
- `lib/modules`：未来结构治理目标位，不作为普通业务任务的默认落点

## Ownership Rules

- 需要改启动、主题或全局导航时，先判断是否属于 `lib/app`
- 需要改跨业务的纯技术能力时，优先判断是否属于 `lib/core`
- 需要改数据库、共享仓储实现或跨 feature 的外部适配时，优先判断是否属于 `lib/data`
- 需要改具体业务页面、规则、控制器、仓储契约时，优先定位到对应 `lib/features/<feature>/`

## Migration Rules

- 当前仓库默认继续维护 `lib/features/*`，不要在普通需求中顺手做整仓迁移
- 如果未来单独立项做结构治理，可以把新模块或迁移后的模块落到 `lib/modules/*`
- 迁移任务必须先说明范围、边界收益和验证方案，再逐模块推进，不要把目录重排和业务迭代混在一起
