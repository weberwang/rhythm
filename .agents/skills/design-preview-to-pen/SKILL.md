---
name: design-preview-to-pen
description: Use when a user wants a gated design workflow that first discusses preview-image requirements, then generates one or more preview comps, waits for explicit approval, extracts approved illustrations or icons, and finally rebuilds the chosen direction in Pencil `.pen` with MCP. Trigger on requests such as "先出预览图再复刻到 Pencil", preview-to-Pencil workflows, asset slicing after approval, or pixel-accurate Pencil restoration from an approved mockup.
---

# Design Preview To Pen

## Overview

Run a strict stage-gated workflow for design production: clarify the brief, generate preview directions, freeze one approved direction, split reusable assets, and only then rebuild the design in Pencil. Bias toward maintainable Pencil structure and reusable assets, not a one-off flattened mockup.

## Quick Start

- If the user only wants visual exploration, stop after preview generation and do not enter Pencil.
- If the user already has an approved preview, skip discovery loops and start from the freeze record plus asset plan.
- If the user wants direct Pencil editing without preview exploration, use a Pencil-focused skill instead of this one.
- If the Pencil desktop app is not connected, complete the pre-Pencil phases and stop before any MCP read or write call.

## Workflow

1. Clarify the preview brief and freeze success criteria.
2. Generate preview candidates with a controlled prompt set.
3. Wait for explicit user approval and record the frozen direction.
4. Build an asset extraction plan before touching Pencil.
5. Extract, regenerate, or redraw assets by type instead of blindly slicing everything.
6. Rebuild the approved direction in Pencil with variables first and sections second.
7. Compare the Pencil result against the approved preview and close remaining gaps.

## Phase Rules

### 1. Brief And Gates

- Read `references/brief-and-gates.md`.
- Lock the page type, audience, platform, visual direction, illustration posture, icon posture, and fidelity target.
- Produce a concise brief pack before generating any preview:
  - `目标`
  - `页面范围`
  - `风格关键词`
  - `禁止项`
  - `验收标准`
- Ask for approval when the brief still contains multiple plausible directions.

### 2. Preview Generation

- Read `references/preview-generation.md`.
- Use `image_gen` for preview comps and keep the prompt set stable across iterations.
- Generate one to three directions at a time. Change one major variable per round: layout, palette, illustration language, or density.
- Treat preview comps as communication artifacts, not as final production assets.
- After each round, summarize the deltas between options and ask the user to choose, merge, or revise.

### 3. Approval Freeze

- Do not continue on implied approval. Wait for an explicit user decision.
- Convert the chosen direction into a freeze record:
  - `采用版本`
  - `必须一致项`
  - `允许工程化调整项`
  - `是否允许图标重绘`
  - `是否允许插图重生成透明素材`
- If the user wants a hybrid of multiple previews, freeze that hybrid explicitly before asset work.

### 4. Asset Extraction

- Read `references/asset-extraction.md`.
- Classify every visual element before extraction:
  - `文本与布局`: rebuild in Pencil, never flatten into a slice
  - `图标`: prefer vector redraw or clean re-generation, not bitmap crop
  - `插图`: generate or extract as isolated transparent assets when needed
  - `纹理/背景`: export as raster only when Pencil structure cannot express them cleanly
- Keep an asset manifest with final filenames, source, replacement strategy, and where each asset will be placed in Pencil.

### 5. Pencil Rebuild

- Read `references/pencil-rebuild.md`.
- Before any other Pencil operation, call `pencil.get_editor_state(include_schema: true)`.
- If the Pencil app is disconnected, state the blocker clearly and stop the workflow at the preparation boundary.
- Rebuild in this order:
  1. page or frame skeleton
  2. design variables
  3. structural sections
  4. text and controls
  5. illustrations and icons
  6. decorative details
- Prefer `set_variables` before large `batch_design` passes so spacing, color, and typography stay maintainable.

### 6. Visual Parity Review

- Read `references/acceptance-checklist.md`.
- Use `snapshot_layout` for structure checks and `get_screenshot` only after a meaningful section or full page is ready.
- Review parity against the approved preview, not against an older draft.
- Close gaps in a controlled order: layout first, typography second, color and materials third, asset fit last.

## Hard Rules

- Do not extract assets or write to Pencil before explicit user approval of a preview direction.
- Do not treat a flattened preview as the final production artifact.
- Do not crop bitmap icons from a preview when a redraw or vector-safe replacement is practical.
- Do not rebuild an entire page as one image unless the user explicitly accepts a non-editable result.
- Do not call Pencil tools other than `get_editor_state(include_schema: true)` before the schema is loaded.
- Do not hide the Pencil connection blocker; surface it immediately when the app is unavailable.
- Do not claim parity without comparing against the approved preview.

## Deliverables

Every substantial result should leave these artifacts in the conversation:

- `需求摘要`
- `预览图方案说明`
- `确认冻结单`
- `素材清单`
- `Pencil 复刻进度`
- `差异与修正清单`

## References

- Read `references/brief-and-gates.md` for the discovery checklist, freeze contract, and handoff gates.
- Read `references/preview-generation.md` for prompt structure, iteration policy, and preview naming.
- Read `references/asset-extraction.md` for asset classification and extraction strategy.
- Read `references/pencil-rebuild.md` for the Pencil MCP sequence, rebuild order, and connection fallback.
- Read `references/acceptance-checklist.md` for parity review and final acceptance criteria.
