# Rhythm 共享设计冻结决议

> 产物类型：`shared_design_freeze_decision`
> 日期：`2026-06-08`
> 评审目标：`shared_pre_split`
> 上游输入：
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`
> - `docs/rd/pencil-design-source-packet.md`
> - `DESIGN.md`

## 1. 冻结结论

- `freeze_decision`: `frozen_shared_for_split`
- `high_fidelity_freeze_status`: `not_evaluated`
- `review_requirement_status`: `passed`
- `next_skill`: `flutter-rd-module-splitter`

本次评审结论为：共享 / 公共层设计已经具备进入模块拆分的冻结条件。

## 2. 评审依据

### 2.1 业务与用户目标

已明确：

- 产品是恢复优先、任务优先的作息行为管理工具
- 目标用户是长期晚睡、希望主动调整作息的年轻成人
- 首屏第一任务必须是“今晚行动”

### 2.2 平台与目标面

已冻结：

- `platform_baseline`: `ios_hig`
- `platform_identifier`: `ios_device`

### 2.3 共享视觉方向

已冻结：

- 冷静、克制、低压迫、略带编辑感
- 非医疗、非打卡、非高压效率工具
- 主 CTA 为安静邀请型
- 图表、商业入口、历史摘要不得压过主任务

### 2.4 共享公共组件

已冻结的共享组件家族：

- `Status Bar Component`
- `Shared Tab Bar`
- `Primary Action Card`
- `Summary Card`
- `Recovery Card`
- 全局主按钮、设置行、状态标签规则

### 2.5 共享壳层

已冻结：

- `Today`
- `Calendar`
- `Bedtime`
- `Insights`
- `Profile`

`Onboarding` 不属于该共享壳层。

### 2.6 冻结合同文件

已存在且具备可消费的冻结前置产物：

- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`

### 2.7 结构化设计源

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

- `global-design-guidelines.md`
- `light-theme-freeze.yaml`
- `dark-theme-freeze.yaml`
- `DESIGN.md`
- `pencil-design-source-packet.md`

## 5. immutable_items

- 首页首屏任务优先级必须是“今晚行动”高于结果摘要与商业入口
- 五个主 tab 的顺序、名称和主语义不可在模块阶段被改写
- 主 CTA 必须保持安静邀请型，而不是命令型
- 标题、正文、标签三层字体层级不可在下游被重新发明
- 冷静、低压迫、非医疗、非游戏化的产品气质不可被改写

## 6. allowed_engineering_adjustments

- 轻阴影和轻材质感可在 Flutter 实现中进一步简化
- 热力图、趋势柱和设置列表可按 Flutter 能力工程化重建
- 字体可映射到同气质系统字体栈，但不可回退到普通廉价默认风格
- 不改变层级与语义前提下，可压缩局部装饰细节

## 7. approval_record

- 用户确认记录：
  - `确认冻结合同`
- 确认日期：
  - `2026-06-08`
- 结论：
  - 共享冻结输入已获显式批准

## 8. 进入下一阶段的边界

本次冻结只授权：

- 进入 `flutter-rd-module-splitter`
- 以共享冻结结果为前提生成模块索引与模块 `impl.md`

本次冻结不授权：

- 直接进入模块实现
- 直接进入架构或代码阶段
- 在模块阶段重写共享组件规则、壳层规则或全局 CTA 层级
