# app-shell Pencil 设计源包

> 产物类型：`module_pencil_design_source_packet`
> 模块：`app-shell`
> 日期：`2026-06-08`
> 上游合同：
> - `docs/rd/modules/app-shell/app-shell.ui-ux.md`
> - `docs/rd/modules/app-shell/app-shell.impl.md`
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`
> - `docs/rd/pencil-design-source-packet.md`
> 当前状态：`in_review_candidate`

## 1. 包结论

本包用于把 `app-shell` 的模块级设计源从“共享冻结”进一步收敛到“可进入模块冻结评审”的粒度。  
这一步不是全局风格再设计，而是把壳层专属状态显式化，并确保后续 Flutter 显示层恢复时不再依赖文字推断。

本轮处理结果：

- 已校验现有共享 `.pen` 文档无全局布局问题
- 已确认共享壳层复用节点：
  - `qs9oz` `Status Bar Component`
  - `OkwbA` `Shared Tab Bar`
- 已新增模块级草图页：
  - `VRrsM` `App Shell Module Draft`
- 已导出模块级壳层证据图：
  - `docs/rd/modules/app-shell/pencil-exports/VRrsM.png`
  - `docs/rd/modules/app-shell/pencil-exports/OkwbA.png`
  - `docs/rd/modules/app-shell/pencil-exports/qs9oz.png`

## 2. 冻结源引用

- `pencil_source_ref`: `docs/rd/app.pen`
- `shared_design_master_packet_id`: `s3gcd`
- `shared_design_master_packet_name`: `Rhythm Shared Design Master`
- `module_design_draft_node_id`: `VRrsM`
- `pencil_source_status`: `frozen_shared_and_module_draft_added`

## 3. in-scope 壳层节点

### 3.1 共享组件节点

- `qs9oz`: `Status Bar Component`
- `OkwbA`: `Shared Tab Bar`

### 3.2 模块级草图节点

- `VRrsM`: `App Shell Module Draft`
- `R6JzXX`: `Launch Recovery State`
- `tbCMr`: `Shell Active State`
- `R7s3M`: `Shell Active Preview`
- `c7ttQB`: `Global Banner Preview`
- `fflJ3`: `Feature Content Host`
- `P9JUf`: `Source Routing Rules`

### 3.3 共享页面上的壳层承载证据

- `MCgNV`: `Today Screen`
- `SvlPW`: `Calendar Screen`
- `N3lMk`: `Bedtime Screen`
- `OSwll`: `Insights Screen`
- `BwvXZ`: `Profile Screen`

这些页面共同证明：

- 顶部状态栏与底部导航已经在共享页级落地
- 五个顶层 tab 的顺序与语义已冻结
- 壳层在不同页面中保持统一姿态

## 4. 主题变量与壳层相关 token

### 4.1 色彩

- `color-primary`: `#2F6B7A`
- `color-secondary`: `#6F8490`
- `color-info`: `#7A93A0`
- `color-surface`: `#F5F8FA`
- `color-surface-container`: `#FCFEFF`
- `color-outline`: `#D9E4EA`
- `color-on-surface`: `#18242B`

### 4.2 字体

- `font-display`: `Geist`
- `font-body`: `Geist`
- `font-caption`: `IBM Plex Mono`
- `font-data`: `Geist Mono`

### 4.3 间距与圆角

- `spacing-sm`: `8`
- `spacing-md`: `16`
- `spacing-lg`: `24`
- `radius-md`: `16`
- `radius-lg`: `24`
- `radius-full`: `9999`

## 5. 壳层结构语义

### 5.1 启动恢复态

节点：`R6JzXX`

显式承载：

- 状态栏
- 启动恢复标题与说明
- 恢复失败后的降级提示

语义要求：

- 冷启动时先解释系统正在恢复，而不是直接暴露空白壳层
- 恢复失败时提供“继续进入本地模式”的明确恢复路径

### 5.2 壳层激活态

节点：`tbCMr`、`R7s3M`

显式承载：

- 状态栏
- 全局横幅层
- feature 内容宿主位
- 共享底部导航

语义要求：

- feature 内容位与壳层责任边界清晰
- 壳层负责路由、来源上下文与共享导航
- feature 只负责业务内容

### 5.3 全局横幅层

节点：`c7ttQB`

显式承载：

- 跨模块状态说明
- 一条轻操作入口

语义要求：

- 横幅必须短
- 横幅不得压过页面主任务
- 横幅只处理跨模块问题，不接管 feature 私有错误

### 5.4 来源路由规则承载

节点：`P9JUf`

显式承载：

- 通知入口
- 小组件入口
- 无效目标降级规则

语义要求：

- 来源目标合法时优先命中目标顶层目的地
- 来源失效时安全回退，不允许把用户送入空壳或死路

## 6. 任务层级与 CTA 预期

对于 `app-shell`，主任务不是“执行某个业务动作”，而是：

1. 正确进入目的地
2. 维持共享壳层一致性
3. 在需要时给出轻量全局说明

因此本模块约束如下：

- 底部导航属于壳层导航，不是主 CTA
- 全局横幅只是一层说明，不与页面主 CTA 抢主次
- 启动恢复态中的“继续进入”属于恢复路径，不是营销入口

## 7. Fidelity-critical 区域与分类

### `preserve_faithfully`

- `OkwbA` 共享底部导航的结构、层级、激活态语义
- `qs9oz` 状态栏与安全区关系
- `R7s3M` 中状态栏 / 横幅 / 内容宿主 / 底部导航的垂直层级
- 全局横幅与主内容之间的轻量优先级关系

### `flutterize`

- 启动恢复态的轻动画与等待节奏
- 来源标记或来源提示的显隐方式
- 横幅关闭/消失的轻交互反馈

### `simplify`

- 无

当前不建议对壳层导航和横幅层级做进一步简化。

## 8. 已接受的工程化缩减

- 启动恢复态当前以模块草图页承载，而不是单独新增一张全局用户页面；这属于可接受的模块级设计表达缩减。
- 全局横幅当前以壳层模块草图中的代表态承载，而不是为每个页面分别重复绘制；这属于可接受的壳层复用表达缩减。

## 9. 视觉一致性校验结果

- `snapshot_layout(problemsOnly=true)` 文档级结果：`No layout problems.`
- `snapshot_layout(parentId=VRrsM, problemsOnly=true)` 模块草图页结果：`No layout problems.`
- `VRrsM` 截图人工检查结果：
  - 未见塌布局
  - 未见可见裁切
  - 壳层层级可读
  - 底部导航与全局横幅关系清晰

## 10. 模块冻结前仍需保持不变的约束

- 五个顶层 tab 的顺序、名称和主语义不可改
- 导航是壳层，不是页面主角
- 全局横幅不得压过 feature 主任务
- 启动恢复与来源降级必须给用户一条安全继续路径

## 11. 待进入 `flutter-design-freeze-gate` 的重点问题

- `app-shell` 的高保真区域是否已经足够支撑 Flutter 恢复：
  - 底部导航
  - 全局横幅
  - 启动恢复态
  - 内容宿主与壳层边界
- 启动恢复态与全局横幅是否属于当前已批准的“可 Flutter 化区域”
- 是否允许在实现中弱化轻投影/轻材质，但保持层级不变

## 12. 当前结论

`app-shell` 已经具备进入模块冻结评审的 Pencil 设计源候选输入：

- 有细化后的模块 UI/UX 合同
- 有细化后的模块实现合同
- 有共享 Pencil 源引用
- 有模块级壳层草图页
- 有共享组件证据与模块导出证据

下一步应进入 `flutter-design-freeze-gate`，而不是直接实现。
