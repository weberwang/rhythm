---
version: alpha
name: Rhythm Design System
description: A calm, recovery-first mobile design system for helping late-sleep users return to rhythm through clear nightly action, gentle next-day feedback, and low-pressure recovery guidance.
colors:
  primary: "#2F6B7A"
  on-primary: "#F7FBFC"
  secondary: "#6F8490"
  tertiary: "#C88B4A"
  surface: "#F5F8FA"
  on-surface: "#18242B"
  surface-container: "#FCFEFF"
  outline: "#D9E4EA"
  success: "#5F8F78"
  warning: "#C88B4A"
  error: "#C96E66"
  info: "#7A93A0"
typography:
  display-lg:
    fontFamily: "SF Pro Display, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 52px
    fontWeight: "700"
    lineHeight: 58px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: "SF Pro Display, PingFang SC, Inter, system-ui, sans-serif"
    fontSize: 30px
    fontWeight: "650"
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

Rhythm is not a medical dashboard and not a soothing content app. It is a recovery-first behavior tool that helps the user understand one thing quickly: what to do tonight to return to rhythm. The design system must feel calm, clear, lightly editorial, and quietly productized. It should guide, not judge. It should reduce friction, not dramatize failure.

Across screens, the system must preserve one stable impression: the product is helping the user complete a gentle recovery task with confidence. Visual polish serves task clarity. Decorative flair never outranks the main task path.

## Colors

The palette is bright, cool, and low-pressure. Surfaces stay in cool white and mist gray-blue tones. The main accent is mineral teal, used for primary actions and selected navigation states. Warm amber appears only as a supportive caution signal. Coral-red is reserved for meaningful late-sleep recovery flags and must stay restrained.

Contrast must stay strongest between task text and surface, then between the primary CTA and the rest of the screen. State color never stands alone as meaning. Every state must also carry a text label, icon cue, or explanatory line. The system must avoid neon, AI-purple gradients, alarm red dominance, and warm lifestyle beige as primary page mood.

## Typography

Typography should feel crisp, composed, and readable under fatigue. Headline styles create focus, but never become theatrical. Display type is used sparingly, usually once per screen or major section. Body copy should stay short, clean, and neutral in tone. Labels and chips should feel precise and compact rather than decorative.

The first screen of the main journey should rely on strong hierarchy instead of large volumes of copy. Primary task text should read in one quick pass. Secondary explanation should support action, not delay it.

## Layout

The layout system is phone-first and vertically guided. Most screens should have one dominant reading direction and one primary job. The page rhythm should come from generous vertical spacing, one clear focus block, and only a small number of supporting regions. Card-over-card stacking should be minimized. Whitespace should do as much grouping work as containers.

The shared shell must stay recognizable across the main navigation surfaces. The global shell includes five primary destinations: Today, Calendar, Bedtime, Insights, and Profile. This shell should feel clearly productized but visually secondary to the main content of each screen. On the Today screen, the main nightly action must be the clear first-screen anchor in the first 3 seconds.

## Elevation & Depth

Depth is restrained and soft. The system should feel layered through spacing, light outline contrast, and subtle surface separation rather than heavy shadows or glass effects. Cards may feel lifted slightly from the page, but never as glossy floating panels. Depth exists to clarify hierarchy, not to create spectacle.

When emphasis is needed, prefer surface separation, scale, and spacing over strong blur or deep shadow. The interface should feel modern and tactile without becoming ornamental.

## Shapes

Shape language is soft, rounded, and consistent. Primary cards use large rounded corners. Inputs and navigation surfaces use medium rounding. Chips and primary action buttons lean pill-shaped. The system should never mix sharp, pill, and exaggerated rounded forms without a clear structural reason.

Icons should inherit the same calm geometry: readable, modern, lightly softened, and not aggressive. Corners, chip shapes, and shell elements should belong to one family so the system feels intentionally designed rather than assembled from unrelated parts.

## Components

Primary action cards are the most important shared component family. They carry tonight's target, the current recommendation, and the main invitation to act. These cards must dominate the first screen without feeling heavy or punishing. Secondary summary cards are quieter, thinner, and more editorial. They support reflection, not urgency.

Buttons should feel inviting rather than commanding. Primary buttons are soft but clear, with strong contrast and comfortable tappable area. Secondary actions should recede without becoming hidden. Chips, tags, and state markers should stay compact and semantically clear.

Bottom navigation is a shared public component family and must remain visually consistent across Today, Calendar, Bedtime, Insights, and Profile. Activated tabs use accent color and typography hierarchy, not loud fills or badge-like treatment. Inputs, forms, and setting rows should feel quiet, legible, and low-friction.

## Task Priorities

The highest-priority task in the product is obvious on the main path: help the user understand what to do tonight. On the Today surface, the first-screen hierarchy must always privilege:

1. tonight's target and main next step
2. last night's outcome summary
3. recovery guidance
4. lightweight trend awareness
5. secondary settings or monetization entry

No chart, paywall cue, historical summary, or decorative asset may outrank the nightly action path. In the first 3 seconds, the user should know what the product wants them to do now, not just what happened before.

## Interaction & Feedback

Feedback must feel predictable, gentle, and immediate. Tap, press, focus, loading, success, warning, and error responses should all belong to one calm feedback language. Buttons should show tactile readiness. Loading states should resemble their final structure rather than generic spinners. Success should feel reassuring, not celebratory. Error states should guide recovery, not scold.

Motion should be restrained and purposeful. It may support continuity between shell, sheets, and transitions, but it should never slow the main task. The product should avoid theatrical transitions, bouncing cards, or intense overlay effects. Disabled and locked states must remain readable and honest.

## Responsive Strategy

The primary target surface is iPhone-class mobile. The system is optimized for single-hand scanning, short vertical sections, clear bottom navigation, and legible tap targets. Tablet adaptation may expand breathing room and column width, but it must not create a second visual language. Desktop is not a primary delivery surface in the current product direction and should not define the default composition.

Regions that may flex responsively include trend previews, summary density, and settings grouping. Regions that should stay visually locked include the first-screen CTA posture, the shared shell identity, the primary card family, and the hierarchy between action, summary, and recovery guidance.

## States & Edge Cases

Every critical screen must intentionally handle ideal, empty, loading, error, permission-denied, partial-data, disabled, locked, long-content, short-content, and slow-network conditions. First-use empty states should reassure the user and keep the main next step alive. Permission-denied states should explain value clearly without blocking the whole product. Partial data states must remain useful rather than collapsing into generic fallback text.

When content grows long, the system should preserve the main action and critical metadata first, then collapse or truncate secondary detail. When content is short, the interface should not feel hollow or unfinished. Slow-network and sync-failure states must still preserve a local-first sense of continuity.

## Content & Tone

The writing tone is calm, clear, and non-medical. The product speaks like a composed guide, not a disciplinarian, therapist, or data monitor. CTA language should feel like a gentle invitation in both confident and recovery moments. Error and recovery language should help the user continue, not heighten guilt.

Naming should stay consistent across shared components and states. Shared component names should be task-oriented and legible. Shared state names should reflect real user situations such as loading, permission missing, recovery needed, premium locked, or partially synced. Copy tone must remain consistent across the primary path, recovery path, and support surfaces.

## Do's and Don'ts

- Do preserve the first-screen priority of tonight's action above all other content.
- Do keep the shared shell, shared card families, shared chips, and shared navigation visually consistent.
- Do keep state feedback calm, readable, and supportive.
- Do design for empty, partial, slow, and failed states as first-class scenarios.
- Do keep the accent palette cool, restrained, and semantically meaningful.
- Do let whitespace and hierarchy do more work than decoration.
- Don't turn the product into a medical dashboard.
- Don't let charts, metrics, or monetization compete with the main nightly action.
- Don't introduce loud gradients, neon glows, or punitive warning language.
- Don't create page-specific local styles that contradict the shared shell or component families.
- Don't rely on color alone to communicate state.
- Don't let responsive adaptation invent a second visual language.
