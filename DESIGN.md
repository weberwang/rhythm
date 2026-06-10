---
version: alpha
name: Rhythm Rhythm Rail Design System
description: A calm, schedule-centric mobile design system for helping late-sleep users read last-night rhythm clearly, protect tonight's plan, and move through one practical wind-down path without shame.
colors:
  primary: "#5E8A6C"
  on-primary: "#F8F5EE"
  secondary: "#6F8077"
  tertiary: "#D0A05F"
  surface: "#F7F4EC"
  on-surface: "#1F2A24"
  surface-container: "#FCFAF4"
  outline: "#E6DED1"
  success: "#5E8A6C"
  warning: "#D0A05F"
  error: "#D98972"
  info: "#9EA8A3"
typography:
  display-lg:
    fontFamily: "SF Pro Display, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 54px
    fontWeight: "650"
    lineHeight: 60px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: "SF Pro Display, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 30px
    fontWeight: "620"
    lineHeight: 38px
    letterSpacing: -0.01em
  title-md:
    fontFamily: "SF Pro Display, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 20px
    fontWeight: "600"
    lineHeight: 28px
  body-md:
    fontFamily: "SF Pro Text, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 16px
    fontWeight: "400"
    lineHeight: 24px
  body-sm:
    fontFamily: "SF Pro Text, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 14px
    fontWeight: "400"
    lineHeight: 20px
  label-sm:
    fontFamily: "SF Pro Text, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 12px
    fontWeight: "600"
    lineHeight: 16px
rounded:
  sm: 8px
  md: 16px
  lg: 24px
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  xxl: 56px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.body-md}"
    rounded: "{rounded.full}"
    padding: "{spacing.md}"
  card-default:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.lg}"
    padding: "{spacing.lg}"
  card-summary:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.lg}"
    padding: "{spacing.xl}"
  card-timeline:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.md}"
    padding: "{spacing.md}"
  chip-status:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    padding: "{spacing.sm}"
  shell-tab:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.secondary}"
    activeTextColor: "{colors.primary}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.md}"
  input-default:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.md}"
    padding: "{spacing.md}"
---

## Overview

Rhythm is not a medical dashboard, not a dreamy sleep-content product, and not a punitive productivity tracker. It is a calm behavior-navigation system for users who stay up too late and need a readable path back to rhythm. The product should feel precise, quiet, and practical first, then warm and supportive second.

The selected direction is `Rhythm Rail`. Its defining quality is structured calm: a strong top summary, clear time windows, gentle schedule rails, and a predictable next action. The interface should help users understand what happened last night, what tonight's plan is, and where they are in the evening sequence without making the product feel clinical or over-designed.

The frozen base design viewport for this cycle is `390 x 844 px`. No page should be reduced below that baseline to fit more content. When density pressure appears, solve it through hierarchy, disclosure, or staged reveal rather than compressed spacing.

## Colors

The palette is bright, warm-neutral, and schedule-oriented. The page surface stays in porcelain and soft paper tones, not cool gray, dark charcoal, or dreamy lavender. Sage green is the primary structure and action color. Amber marks caution, threshold moments, and planning emphasis. Desaturated coral is reserved for lateness, recovery need, or meaningful deviation. Neutral gray-green supports secondary labels, partial data, and quiet guidance.

Contrast should be strongest on:

- the main top summary
- tonight's target window
- the primary action or next schedule step

Color must never be the only signal for status. Every success, warning, recovery, missing-data, and delay state must also use copy or icon reinforcement.

## Typography

Typography in this system should feel confident and clean rather than poetic or decorative. The interface is organized by precision and readability. Large summary figures, time ranges, and page-level statements may scale up strongly, but they should remain crisp and product-like rather than editorially dramatic.

Display text is reserved for:

- the main page title
- a large summary number or time window
- one high-priority statement when the screen needs it

Body and label styles should stay highly readable on mobile, with enough rhythm to support stacked schedules, trend summaries, and settings rows. Labels should feel exact and steady, never playful.

## Layout

The layout system is phone-first, vertical, and sequence-driven. This product should not feel like a dashboard of equal-weight cards. The screen should usually read in one guided order:

1. what happened last night
2. what tonight's plan is
3. what the user should do next
4. what the recent rhythm trend suggests

Use whitespace and vertical sequencing first. Use containers where semantic grouping matters. Use cards as grouped surfaces, not as decoration. Avoid cards inside cards and avoid breaking one guided story into too many visually equivalent blocks.

The shared shell must stay recognizable across Today, Calendar, Bedtime, Insights, and Profile, but the shell must remain quieter than the page's primary task content.

## Elevation & Depth

Depth is restrained and structural. Surfaces may separate through soft tonal contrast, a faint outline, and extremely light shadow, but not through glassmorphism, glossy lift, or theatrical blur. Premium quality here comes from order and proportion, not spectacle.

When emphasis is needed, prefer:

- larger time or result scale
- stronger alignment
- cleaner grouping
- slightly warmer or cooler semantic tint

Do not use depth to make every block feel equally important.

## Shapes

Shape language is soft, practical, and reliable. Main summary cards and grouped timeline containers should use generous rounded corners. Secondary rows, settings items, and compact action containers should use medium rounding. Chips and CTAs may become pill-shaped when they express readiness or status.

The geometry should feel stable, not playful. Corners, icon stroke weight, and navigation shapes must belong to the same family so the product reads like one coherent planning system.

## Components

The most important shared component families are:

- summary cards for last-night result and tonight plan
- timeline or schedule-rail rows
- calm primary CTA buttons
- compact status chips
- weekly rhythm summary surfaces
- quiet bottom navigation

Summary cards should explain rather than impress. Timeline rows should feel ordered, tappable, and lightweight. Weekly rhythm summaries should stay secondary to the immediate action path. Inputs, settings rows, and filters should feel native, low-friction, and consistent with the same quiet structure system.

## Task Priorities

The highest-priority task is not "see all data." It is helping the user calmly read last night and move into tonight's plan without confusion.

The first 3 seconds on the main Today journey must make these things obvious:

1. last night's outcome or current sleep status
2. tonight's target sleep window or wind-down timing
3. the next concrete step in the evening path

Charts, long history, settings, monetization, and secondary insights must not outrank the first-screen task path.

## Interaction & Feedback

Feedback should feel immediate, quiet, and dependable. Tap states should confirm intent without flashing. Loading states should preserve the same reading order as the final content. Success should feel steady. Warning should feel attentive. Error should preserve motion toward a next step instead of stopping at diagnosis.

Motion, when used, should help with:

- timeline continuity
- sheet and panel transitions
- state confirmation
- reducing perceived friction in the bedtime path

Motion must not delay bedtime actions or distract from the page's reading order.

## Responsive Strategy

The design is frozen around an iPhone-class base viewport of `390 x 844 px`. Tablet may add whitespace and widen grouped surfaces, but must not invent a second design language. Desktop is not a primary composition target for this product and should not define layout behavior.

Visually locked relationships include:

- the top summary-first order on Today
- the main schedule window and evening progression logic
- the shared shell, summary cards, timeline rows, and primary CTA posture

Flexible regions include:

- trend preview density
- list length handling
- secondary metadata placement
- deeper configuration grouping in settings-heavy pages

## States & Edge Cases

Every critical screen must support:

- ideal
- loading
- empty
- partial-data
- disabled
- success
- warning
- error
- permission-denied
- premium-locked
- long-content
- short-content
- slow-network

When data is missing or delayed, the product must say so plainly and preserve a useful next step. When the user slept late, the product should prioritize recovery explanation or tonight-plan protection over shame. When content grows long, the top summary, tonight plan, and primary CTA must remain intact. When content is short, the screen should still feel complete and intentional.

## Content & Tone

The voice is calm, direct, and non-medical. It should sound like a composed guide that helps the user protect rhythm through small, practical choices. The product does not dramatize lateness, does not imitate therapy, and does not talk like a punishment system.

CTA language should feel practical and gentle, for example:

- start wind-down
- protect tonight's window
- keep your rhythm
- view recovery plan

Naming should stay stable across screens and states. Shared names should reflect real usage situations: last night, tonight plan, sleep window, wind-down, partial sync, recovery note, premium locked.

## Do's and Don'ts

- Do preserve the summary-first reading order on the main Today path.
- Do keep time windows, rails, and next steps clearer than charts or promotions.
- Do use whitespace and grouping before decoration to create hierarchy.
- Do keep the shared shell, summary cards, timeline rows, and CTA posture consistent across screens.
- Do design all major data, permission, loading, and recovery states explicitly.
- Do keep the visual system in light mode by default for this workflow.
- Don't turn the app into a medical dashboard, quantified-self console, or dreamy wellness fantasy.
- Don't let charts, historical depth, or paywall prompts outrank tonight's plan.
- Don't fall back to blue-purple gradients, glossy glass, or ornamental lifestyle styling.
- Don't compress spacing or collapse hierarchy to fit more content below the frozen base viewport.
- Don't let page-local styling break the shared shell, shared card family, or shared timeline language.
- Don't rely on color alone to express lateness, caution, or recovery need.
