# Rhythm Stitch Shared Design Master

## 基本信息

- 设计源适配器：`stitch`
- Stitch 项目模式：`existing`
- Stitch 项目 ID：`7107477570523131437`
- Stitch 设计系统资产：`assets/f3ea82f0764442039cbf2a516710dd77`
- 关联根级设计约束：[DESIGN.md](/E:/Projects/flutter/rhythm/DESIGN.md)
- 最终确认视觉基线：[rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png)
- 设计设备预设：[design-device-preset.md](/E:/Projects/flutter/rhythm/docs/project/rd/design-device-preset.md)

## 冻结范围

- 共享 theme system
- shared public shell
- shared public component families
- shared interaction principles

本阶段不包含模块页面设计，也不授权任何模块级页面细化冻结。

## 共享设计主包摘要

- 主页面保持单列长页结构，围绕“睡眠窗口 -> wind-down -> recovery -> this week”顺序展开。
- 视觉风格以暖白背景、深绿色主文字、浅边框大卡片为核心，不采用高噪音插画风或重装饰疗愈风。
- CTA 强调通过信息位置、文字颜色和层级完成，不依赖大面积实体按钮。
- 共享组件必须围绕卡片、行项目、状态胶囊、周视图圆点、统计摘要条复用。
- 当前冻结验证面为 iPhone 真机视角。

## 结构化设计源约束

- Stitch 只能序列化、验证和扩展已确认的共享设计主包，不能重新发明方向。
- 所有下游实现、结构恢复和文档冻结都必须以本主包、[global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md) 与主题冻结文件为唯一上游依据。
- 若后续任一设计产物与最终确认效果图冲突，以最终确认效果图和根级 [DESIGN.md](/E:/Projects/flutter/rhythm/DESIGN.md) 为准。
