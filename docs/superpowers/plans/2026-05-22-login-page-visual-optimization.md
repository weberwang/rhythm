# Login Page Visual Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rework the `pen/app.pen` login screen so third-party login becomes the primary first-screen action while keeping Rhythm's quiet visual identity.

**Architecture:** Modify the existing `qJLKu` login screen in place inside the `.pen` document. Reduce the visual weight of the hero area, collapse phone login into a secondary path, move trust copy below the primary login actions, and verify the result with screenshots instead of code tests.

**Tech Stack:** Pencil MCP, `.pen` design document, screenshot verification

---

### Task 1: Update Login Screen Hierarchy

**Files:**
- Modify: `E:\Projects\flutter\rhythm\pen\app.pen`
- Spec: `E:\Projects\flutter\rhythm\docs\superpowers\specs\2026-05-22-login-page-visual-optimization-design.md`

- [ ] **Step 1: Inspect the current login screen nodes**

Read the existing top-level screen and its main sections:

```text
qJLKu  登录页
WG96S  欢迎插画区
BHyq2  文案区
eGWxW  登录方式卡片
qTQLD  其他方式区
mp8sP  价值提示卡
```

- [ ] **Step 2: Reduce hero visual weight**

Update the hero area so it keeps the brand mood but stops competing with the login action:

- shrink the decorative illustration region
- keep one brand badge and one short headline
- remove or simplify floating promo-like details

- [ ] **Step 3: Promote Apple and Google to the primary action area**

Turn the current third-party buttons into the first major interactive block below the headline:

- move them above any phone-login content
- make them equal-sized primary actions
- give Apple the strongest filled treatment
- keep Google clearly visible with a lighter treatment

- [ ] **Step 4: Demote phone login**

Replace the expanded phone verification block with a secondary entry such as:

- a secondary button labeled `使用手机号登录`
- or a collapsed row that implies a deeper next step

- [ ] **Step 5: Replace the value card with trust copy**

Remove the promotional `首周免费` style messaging and replace it with:

- one shared agreement line for all login methods
- one short trust sentence about sync and routine data

- [ ] **Step 6: Capture a screenshot and compare against the spec**

Use Pencil screenshot output to confirm:

- the first focal point is the Apple/Google action group
- the hero no longer dominates the page
- the phone path is visible but secondary
- promo tone is gone from the first screen

- [ ] **Step 7: Commit only after user chooses a git action**

Do not run `git add`, `git commit`, or `git push` until the user selects `仅提交`、`提交并推送`、`忽略`.
