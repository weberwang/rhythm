# Rhythm Stitch 效果图基线重建设计

> 日期：2026-06-07
> 主题：在现有 Stitch 项目中按效果图基线重建设计稿
> 上游输入：
> - `docs/rd/today-page.png`
> - `docs/rd/onboarding-page.png`
> - `docs/rd/bedtime-page.png`
> - `docs/rd/calendar-page.png`
> - `docs/rd/insights-page.png`
> - `docs/rd/profile-settings-page.png`
> - 用户确认“设计稿已经删除，重新用效果图作为基线来实现 stitch 设计稿”

## 1. 目标

本说明用于明确：在现有 Stitch 项目 `9392137754454631344` 中，重新建立一套以本地效果图为唯一视觉标准的 Stitch 设计稿。

本次目标：

- 以 6 张本地效果图作为唯一视觉基线
- 在现有 Stitch 项目中重新生成对应 screen
- 明确放弃把上一轮 HIG 重构变体作为当前实现基线
- 让后续 freeze、Flutter 对齐和实现说明只引用这轮重建稿

本次不做：

- 不继续沿用上一轮 HIG-first 重构方向
- 不以“更原生 iOS”为优先改写效果图结构
- 不在当前阶段主动加入未体现在效果图中的设计优化

## 2. 用户确认的关键决策

本轮已确认：

- 效果图是唯一视觉标准
- 上一轮 HIG 重构变体不再作为当前设计基线
- 继续使用现有 Stitch 项目，而不是新建项目
- 在现有项目中新增一套新的重建稿，而不是要求物理删除全部历史稿

## 3. 唯一基线定义

本轮唯一视觉基线是以下 6 张本地效果图：

- `docs/rd/today-page.png`
- `docs/rd/onboarding-page.png`
- `docs/rd/bedtime-page.png`
- `docs/rd/calendar-page.png`
- `docs/rd/insights-page.png`
- `docs/rd/profile-settings-page.png`

这些图在本轮的含义不是“参考风格”，而是：

- 结构基线
- 信息层级基线
- 视觉重心基线
- 控件组合基线
- 文案承载位基线

除非 Stitch 自身生成能力存在客观限制，否则不应主动偏离这些效果图的设计方向。

## 4. 实施策略

### 4.1 项目策略

继续使用现有 Stitch 项目：

- `projects/9392137754454631344`

理由：

- 保留现有项目内共享设计系统资产与上下文
- 降低重新建项目的额外成本
- 便于和历史稿对照
- 便于在同一项目内重新指定“当前有效候选稿”

### 4.2 screen 策略

本轮不依赖“旧稿编辑后等价替换”的方式作为唯一方案，而是优先：

- 在当前项目中新生成一套 effect-image rebuild screen
- 再通过文档重映射，把这套新稿定义为当前有效设计稿

这样做的原因：

- Stitch 的编辑结果不稳定，容易保留旧结构残影
- 重新生成更容易贴近新的唯一基线
- 文档可清楚区分“历史稿”和“当前稿”

## 5. 页面级要求

### 5.1 Today

- 必须以 `docs/rd/today-page.png` 为唯一视觉标准
- 保持首页以今晚行动主卡为唯一主重心
- 保持原图中的主卡、昨晚结果摘要、恢复建议、趋势预告顺序和视觉关系
- 不因为 HIG 偏好而主动压缩原图中的编辑感表达

### 5.2 Onboarding

- 必须以 `docs/rd/onboarding-page.png` 为唯一视觉标准
- 保持品牌引导页的构图、留白和 CTA 气质
- 不主动改造成更“原生启动页”的功能化结构

### 5.3 Bedtime

- 必须以 `docs/rd/bedtime-page.png` 为唯一视觉标准
- 保持单任务聚焦感、情绪状态选择和主 CTA 的原始布局关系
- 不主动替换为更标准的 segmented control 语义

### 5.4 Calendar

- 必须以 `docs/rd/calendar-page.png` 为唯一视觉标准
- 保持原图的月视图、总览卡、图例和摘要构图
- 不主动加入额外符号系统或状态辅助编码

### 5.5 Insights

- 必须以 `docs/rd/insights-page.png` 为唯一视觉标准
- 保持原图的大块周摘要、关键洞察和次级洞察关系
- 不主动把页面改成完全原生化报表页

### 5.6 Profile

- 必须以 `docs/rd/profile-settings-page.png` 为唯一视觉标准
- 保持顶部账户卡、设置分组和会员同步卡的原始关系
- 不主动改造成标准 iOS settings 的纯列表结构

## 6. 文档与状态回写

完成重建后，需要同步做以下回写：

- 在 `docs/rd/stitch-design-source-packet.md` 中新增本轮重建稿映射
- 明确声明“当前有效设计基线”已切换为 effect-image rebuild screen
- 明确上一轮 HIG 变体只保留为历史痕迹，不再作为当前 freeze 候选默认对象

## 7. 成功标准

- 现有 Stitch 项目中存在一套新的 6 页面重建稿
- 这套重建稿逐页以本地效果图为唯一视觉标准
- 文档中清楚区分历史稿、HIG 变体和当前有效稿
- 后续 freeze gate 能够明确引用这轮重建稿，而不是含混地混用多个来源

## 8. 风险与约束

- Stitch 可能保留项目内已有设计系统风格，因此新稿未必像逐像素临摹
- 如果生成能力无法完整复现原图，需要在结果层面记录偏差，而不是擅自改写“基线是谁”
- 当前工具集没有明确的物理删除 screen 能力，因此历史稿只能通过文档降级为失效参考

## 9. 下一步

本说明确认后，下一步按以下顺序执行：

1. 在现有 Stitch 项目中逐页重建 6 张 screen
2. 记录新 screen ID、截图文件与 html 文件
3. 回写 `stitch-design-source-packet.md`
4. 把这轮重建稿标记为当前有效设计基线

## 10. 自检结论

已检查以下事项：

- 已明确“唯一视觉标准”是谁
- 已明确不再以 HIG 变体为当前默认基线
- 已明确继续使用现有 Stitch 项目
- 已明确本轮目标是“重建当前稿”，不是“追溯解释旧稿”
