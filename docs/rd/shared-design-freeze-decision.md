# Rhythm 共享设计冻结决议

> 产物类型：`shared_design_freeze_decision`
> 日期：`2026-06-08`
> 评审目标：`shared_pre_split`
> 上游输入：
> - `DESIGN.md`
> - `docs/rd/app.pen`
> - `docs/rd/pencil-design-source-packet.md`
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`
> - `docs/rd/pencil-exports/MCgNV.png`
> - `docs/rd/pencil-exports/SvlPW.png`
> - `docs/rd/pencil-exports/N3lMk.png`
> - `docs/rd/pencil-exports/OSwll.png`
> - `docs/rd/pencil-exports/BwvXZ.png`
> - `docs/rd/pencil-exports/dMZS3.png`

## 1. 冻结结论

- `freeze_decision`: `frozen_shared_for_split`
- `high_fidelity_freeze_status`: `not_evaluated`
- `review_requirement_status`: `passed`
- `next_skill`: `flutter-rd-module-splitter`

本次评审结论为：按 `静夜秩序` 重建后的共享 / 公共层设计，已经具备重新进入模块拆分的冻结条件。

## 2. 评审依据

### 2.1 业务与用户目标

已明确：

- 产品是作息行为管理工具，不是医疗诊断产品
- 目标用户是长期晚睡、希望主动调整作息的年轻成人
- 首页首屏必须先帮助用户读懂昨晚结果，再帮助用户保护今晚节奏

### 2.2 平台与目标面

已冻结：

- `platform_baseline`: `ios_hig`
- `platform_identifier`: `ios_device`

### 2.3 共享视觉方向

已冻结：

- 安静、克制、有秩序、低压迫
- 暖中性背景 + 浅米白卡片 + 鼠尾草绿 CTA
- 非医疗、非打卡、非高压效率工具
- 结果陈述采用更强阅读感，而不是仪表盘式数据表达
- 图表、商业入口、历史摘要不得压过首屏结果层级

### 2.4 共享信息层级

已冻结：

1. 昨晚结果
2. 今晚目标
3. 下一步动作
4. 轻趋势 / 周理解
5. 次级配置、会员与补充入口

其中 `Today` 页的结果优先首屏结构已通过共享视觉证据直接验证。

### 2.5 共享公共组件

已冻结的共享组件家族：

- `Status Bar Component`
- `Shared Tab Bar`
- `Summary Card`
- `Recovery Card`
- `Primary Action Card`
- 全局主按钮、状态标签、设置行规则

### 2.6 共享壳层

已冻结：

- `Today`
- `Calendar`
- `Bedtime`
- `Insights`
- `Profile`

`Onboarding` 不属于该共享壳层。

### 2.7 冻结合同文件

已存在且具备可消费的冻结前置产物：

- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`

### 2.8 结构化设计源

已存在并可作为共享设计源参考：

- `docs/rd/app.pen`
- `docs/rd/pencil-design-source-packet.md`
- `docs/rd/pencil-exports/*.png`

## 3. 缺失项检查

### 3.1 missing_items

`none`

说明：

- 当前评审目标是 `shared_pre_split`
- 本阶段不要求模块级 `impl.md`
- 本阶段不要求模块私有组件冻结
- 本阶段不要求模块高保真实现合同

## 4. required_artifacts

- `DESIGN.md`
- `global-design-guidelines.md`
- `light-theme-freeze.yaml`
- `dark-theme-freeze.yaml`
- `pencil-design-source-packet.md`
- `app.pen`
- 共享页面导出证据图

## 5. immutable_items

- `Today` 页首屏任务优先级必须是“昨晚结果”高于“今晚目标”、高于“下一步动作”、高于商业入口
- 五个主 tab 的顺序、名称和主语义不可在模块阶段被改写
- 结果卡的大字排版与低压迫气质不可被下游削弱
- 主 CTA 必须保持安静邀请型，而不是命令型
- serif 结果陈述、sans 正文、mono 标签的三层阅读结构不可在下游被重新发明
- 暖中性秩序方向不可被改写回冷灰蓝医疗感、梦境疗愈感或效率打卡感

## 6. allowed_engineering_adjustments

- 极浅阴影和浅表面质感可在 Flutter 实现中进一步简化
- 趋势柱、热力图、统计区与设置列表可按 Flutter 能力工程化重建
- 字体可映射到同气质系统字体栈，但不得破坏结果陈述与正文之间的阅读反差
- 不改变层级、语义和 CTA 对比姿态前提下，可压缩局部装饰细节

## 7. approval_record

- 用户确认记录：
  - `确认全局设计合同`
- 确认日期：
  - `2026-06-08`
- 结论：
  - 共享冻结前合同已获显式批准

## 8. 进入下一阶段的边界

本次冻结只授权：

- 进入 `flutter-rd-module-splitter`
- 以新的共享冻结结果为前提，重建模块索引与模块 `impl.md`

本次冻结不授权：

- 直接进入模块实现
- 直接进入架构或代码阶段
- 在模块阶段重写共享结果优先层级、壳层规则或全局 CTA 姿态
