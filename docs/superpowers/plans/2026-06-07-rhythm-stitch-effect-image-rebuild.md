# Rhythm Stitch Effect-Image Rebuild Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在现有 Stitch 项目 `9392137754454631344` 中，基于 6 张本地效果图重新生成一套新的设计稿，并把它们回写为当前有效的 Stitch 设计基线。

**Architecture:** 继续使用现有 Stitch 项目，不依赖上一轮 HIG 重构变体，也不要求物理删除历史 screen。执行时逐页用效果图作为唯一视觉标准生成新 screen，再通过文档回写把这些新稿定义为当前有效候选稿，旧稿仅保留为历史痕迹。

**Tech Stack:** Stitch MCP (`generate_screen_from_text` / `get_screen` / `list_screens`)、本地设计文档 `docs/rd/*.md`、本地效果图 `docs/rd/*.png`

---

### Task 1: 锁定唯一视觉基线与输出边界

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\superpowers\specs\2026-06-07-rhythm-stitch-effect-image-rebuild-design.md`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\today-page.png`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\onboarding-page.png`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\bedtime-page.png`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\calendar-page.png`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\insights-page.png`
- Read: `D:\Projects\Flutter\rhythm\docs\rd\profile-settings-page.png`

- [ ] **Step 1: 复核本轮唯一基线定义**

确认以下结论仍然成立：

```text
唯一视觉标准：
- docs/rd/today-page.png
- docs/rd/onboarding-page.png
- docs/rd/bedtime-page.png
- docs/rd/calendar-page.png
- docs/rd/insights-page.png
- docs/rd/profile-settings-page.png

排除项：
- 不以 2026-06-07 HIG 重构变体作为当前实现基线
- 不主动为原生化而重写效果图布局
```

- [ ] **Step 2: 锁定本轮输出命名约定**

执行时所有新稿统一使用如下标题模式：

```text
Today - Effect Image Rebuild
Onboarding - Effect Image Rebuild
Bedtime - Effect Image Rebuild
Calendar - Effect Image Rebuild
Insights - Effect Image Rebuild
Profile - Effect Image Rebuild
```

- [ ] **Step 3: 明确验证口径**

每张新稿生成后必须验证：

```text
1. get_screen 可读取 screen_id
2. screenshot 文件名已返回
3. html 文件名已返回
4. 视觉方向与对应效果图一致，没有误回到 HIG-first 原生重构风格
```

### Task 2: 重建 Today 稿

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\today-page.png`
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 按效果图生成 Today 新稿**

调用 Stitch 生成新 screen，prompt 需要明确：

```text
以 docs/rd/today-page.png 为唯一视觉标准重建 Today 页面。
保留今晚行动主卡为唯一首屏重心，保留昨晚结果摘要、恢复建议、趋势预告的结构与视觉关系。
不要改造成更原生 iOS 的 HIG-first 版本，不要主动压缩海报感或编辑感表达。
输出标题：Today - Effect Image Rebuild
```

- [ ] **Step 2: 读取新 screen 并记录产物**

验证返回：

```text
- screen_id
- screenshot 文件名
- html 文件名
- 标题为 Today - Effect Image Rebuild
```

- [ ] **Step 3: 记录 Today 重建映射**

准备写入：

```markdown
| `today-page` | `docs/rd/today-page.png` | `<new_screen_id>` | `Today - Effect Image Rebuild` | `<screenshot_name>` | `<html_name>` |
```

### Task 3: 重建 Onboarding 稿

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\onboarding-page.png`
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 按效果图生成 Onboarding 新稿**

调用 Stitch 生成新 screen，prompt 需要明确：

```text
以 docs/rd/onboarding-page.png 为唯一视觉标准重建 Onboarding 页面。
保留品牌引导页的构图、留白和 CTA 气质，不要主动改造成更原生的启动页结构。
不要添加底部导航。
输出标题：Onboarding - Effect Image Rebuild
```

- [ ] **Step 2: 读取新 screen 并记录产物**

验证返回：

```text
- screen_id
- screenshot 文件名
- html 文件名
- 标题为 Onboarding - Effect Image Rebuild
```

- [ ] **Step 3: 记录 Onboarding 重建映射**

准备写入：

```markdown
| `onboarding-page` | `docs/rd/onboarding-page.png` | `<new_screen_id>` | `Onboarding - Effect Image Rebuild` | `<screenshot_name>` | `<html_name>` |
```

### Task 4: 重建 Bedtime 稿

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\bedtime-page.png`
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 按效果图生成 Bedtime 新稿**

调用 Stitch 生成新 screen，prompt 需要明确：

```text
以 docs/rd/bedtime-page.png 为唯一视觉标准重建 Bedtime 页面。
保留单任务聚焦、状态选择与主 CTA 的原始布局关系。
不要主动替换为原生 segmented control 语义，不要切到 HIG-first 功能页风格。
输出标题：Bedtime - Effect Image Rebuild
```

- [ ] **Step 2: 读取新 screen 并记录产物**

验证返回：

```text
- screen_id
- screenshot 文件名
- html 文件名
- 标题为 Bedtime - Effect Image Rebuild
```

- [ ] **Step 3: 记录 Bedtime 重建映射**

准备写入：

```markdown
| `bedtime-page` | `docs/rd/bedtime-page.png` | `<new_screen_id>` | `Bedtime - Effect Image Rebuild` | `<screenshot_name>` | `<html_name>` |
```

### Task 5: 重建 Calendar 稿

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\calendar-page.png`
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 按效果图生成 Calendar 新稿**

调用 Stitch 生成新 screen，prompt 需要明确：

```text
以 docs/rd/calendar-page.png 为唯一视觉标准重建 Calendar 页面。
保留总览卡、月视图、图例和摘要卡的原始构图。
不要主动增加 HIG-first 的额外状态符号系统或重新功能化布局。
输出标题：Calendar - Effect Image Rebuild
```

- [ ] **Step 2: 读取新 screen 并记录产物**

验证返回：

```text
- screen_id
- screenshot 文件名
- html 文件名
- 标题为 Calendar - Effect Image Rebuild
```

- [ ] **Step 3: 记录 Calendar 重建映射**

准备写入：

```markdown
| `calendar-page` | `docs/rd/calendar-page.png` | `<new_screen_id>` | `Calendar - Effect Image Rebuild` | `<screenshot_name>` | `<html_name>` |
```

### Task 6: 重建 Insights 稿

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\insights-page.png`
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 按效果图生成 Insights 新稿**

调用 Stitch 生成新 screen，prompt 需要明确：

```text
以 docs/rd/insights-page.png 为唯一视觉标准重建 Insights 页面。
保留周摘要大卡、关键洞察、次级洞察的原始视觉关系。
不要主动把页面改造成完全原生化的报表页。
输出标题：Insights - Effect Image Rebuild
```

- [ ] **Step 2: 读取新 screen 并记录产物**

验证返回：

```text
- screen_id
- screenshot 文件名
- html 文件名
- 标题为 Insights - Effect Image Rebuild
```

- [ ] **Step 3: 记录 Insights 重建映射**

准备写入：

```markdown
| `insights-page` | `docs/rd/insights-page.png` | `<new_screen_id>` | `Insights - Effect Image Rebuild` | `<screenshot_name>` | `<html_name>` |
```

### Task 7: 重建 Profile 稿

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\profile-settings-page.png`
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 按效果图生成 Profile 新稿**

调用 Stitch 生成新 screen，prompt 需要明确：

```text
以 docs/rd/profile-settings-page.png 为唯一视觉标准重建 Profile 页面。
保留顶部账户卡、设置分组和会员同步卡的原始关系。
不要主动改造成标准 iOS settings 的纯列表结构。
输出标题：Profile - Effect Image Rebuild
```

- [ ] **Step 2: 读取新 screen 并记录产物**

验证返回：

```text
- screen_id
- screenshot 文件名
- html 文件名
- 标题为 Profile - Effect Image Rebuild
```

- [ ] **Step 3: 记录 Profile 重建映射**

准备写入：

```markdown
| `profile-settings-page` | `docs/rd/profile-settings-page.png` | `<new_screen_id>` | `Profile - Effect Image Rebuild` | `<screenshot_name>` | `<html_name>` |
```

### Task 8: 回写设计源包并切换当前有效基线

**Files:**
- Modify: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 新增 effect-image rebuild 映射区块**

把 6 张新稿写成单独区块，结构如下：

```markdown
## 2026-06-07 Effect Image Rebuild

本轮在现有 Stitch 项目中，按本地效果图唯一基线重新生成了一套 screen。

| page_id | effect_image | rebuild_screen_id | rebuild_title | screenshot_name | html_name |
| --- | --- | --- | --- | --- | --- |
| ... |
```

- [ ] **Step 2: 明确当前有效设计基线已切换**

补充以下结论：

```markdown
- 当前有效设计基线：本节 effect-image rebuild screen
- HIG 重构变体：仅保留为历史痕迹，不再作为当前默认 freeze 候选
- 第一轮原始 Stitch screen：仅保留为历史映射，不再作为当前默认实现来源
```

- [ ] **Step 3: 核对文档自洽性**

人工核对以下点：

```text
1. 是否仍把 HIG 变体写成“当前有效”
2. 是否仍把第一轮原始稿写成“当前候选”
3. 是否把本轮唯一基线写成了“效果图 + HIG”混合口径
```

### Task 9: 完成结果复核

**Files:**
- Read: `D:\Projects\Flutter\rhythm\docs\rd\stitch-design-source-packet.md`

- [ ] **Step 1: 核对 6 张重建稿是否都可读取**

逐个检查：

```text
Today / Onboarding / Bedtime / Calendar / Insights / Profile
```

必须都能通过 `get_screen` 读取。

- [ ] **Step 2: 核对基线声明是否唯一**

最终口径必须是：

```text
当前 Stitch 设计稿以本地效果图为唯一视觉标准重建完成。
```

- [ ] **Step 3: 准备交付说明**

交付时必须说明：

```text
1. 新重建稿的 6 个 screen_id
2. 当前有效基线已切换
3. 历史稿仍在项目里，但不再是当前默认稿
4. 本轮未进行 git 提交，等待用户选择
```

