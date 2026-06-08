---
version: alpha
name: Rhythm Quiet Order Design System
description: A quiet, ordered mobile design system for helping late-sleep users read last-night drift clearly, recover without shame, and return to tonight's rhythm through one calm next step.
colors:
  primary: "#718C74"
  on-primary: "#F8F6F1"
  secondary: "#7F8983"
  tertiary: "#C99A61"
  surface: "#F6F2EA"
  on-surface: "#1F2622"
  surface-container: "#FCF9F3"
  outline: "#E5DDD0"
  success: "#718C74"
  warning: "#C99A61"
  error: "#D48672"
  info: "#99A4AA"
typography:
  display-lg:
    fontFamily: "Source Serif 4, Noto Serif SC, Georgia, serif"
    fontSize: 56px
    fontWeight: "600"
    lineHeight: 62px
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
  md: 18px
  lg: 28px
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
  card-result:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.lg}"
    padding: "{spacing.xl}"
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

Rhythm is not a medical dashboard and not a dreamy sleep-content product. It is a behavior-reset tool for people who stay up too late and need one calm, readable path back to rhythm. The system should feel quiet, ordered, warm-light, and trustworthy. It should lower shame, lower noise, and let the user understand last night before deciding what to do tonight.

The selected direction is `静夜秩序`. Its defining experience is not novelty, but composure: generous whitespace, strong large-type moments, restrained containers, and one clearly guided reading order. The interface should feel like a premium personal routine system with editorial calm, not like a data console, not like a wellness fantasy, and not like a productivity punishment tool.

## Colors

The palette is bright, warm-neutral, and low-pressure. Page surfaces stay in porcelain off-white and soft stone tones rather than cool clinical gray or dreamy purple. Sage green is the primary action and stability color. Amber expresses slight drift or caution. Desaturated coral marks meaningful lateness or recovery need. Gray-blue exists only as a neutral support color for partial, missing, or secondary information.

Contrast should be strongest between the main reading statement and the surrounding surface, then between the primary CTA and the page body. Color must never be the only state signal. Every warning, recovery, success, and partial-data moment must also include plain-language explanation or icon support.

## Typography

Typography carries much of the system's identity. The user should feel the hierarchy before they consciously read it. Large result statements may use a refined serif display voice, especially when explaining drift, time offset, or the single most important outcome from last night. The rest of the product should remain highly readable and implementation-friendly through a clean iOS-native sans rhythm.

Display type is reserved for one focal statement per screen. Headline and title tiers organize page structure. Body copy stays short, direct, and emotionally steady. Labels, chips, and tab text should feel compact, precise, and quiet rather than decorative.

## Layout

The layout system is phone-first and vertically sequenced. Each primary screen should read as one guided stack with one dominant focal block and only a few supporting regions. The design should not depend on equal-weight card grids or multi-axis dashboard logic. Whitespace should carry most grouping work, with containers added only when semantic separation or tactile focus is needed.

The shared shell must remain recognizable across Today, Calendar, Bedtime, Insights, and Profile, but the shell is not the hero. On the main Today path, the first screen should let the user understand three things in order:

1. what happened last night
2. what tonight's target is
3. what the next gentle step should be

The page should feel settled and breathable even when multiple cards are present.

## Elevation & Depth

Depth is quiet and tactile. Containers may separate from the page through subtle value shifts, faint outline contrast, and very light shadow, but never through glossy lift, blur spectacle, or floating card drama. The visual system should feel premium because it is disciplined, not because it is ornamented.

When emphasis is needed, prefer spacing, scale, and typographic contrast before adding more depth. Result cards, target cards, and recovery cards may feel slightly more substantial than secondary lists, but the entire app should still read as one calm surface family.

## Shapes

Shape language is soft and unforced. Primary content cards use generous rounded corners. Inputs and secondary action rows use medium rounding. Chips and buttons can lean pill-shaped when they express invitation or state. No element should feel sharp, aggressive, or over-rounded for effect.

Icons should be fine-lined, calm, and precise. They should support interpretation, not become decorative mascots. Corners, icon geometry, and navigation surfaces must belong to one family so the product feels intentionally composed.

## Components

The most important shared component family is the result-first summary stack:

- result statement cards
- tonight target cards
- recovery guidance cards
- quiet primary action buttons

Result cards must carry the emotional weight of the system without becoming dramatic. They explain drift clearly, preserve dignity, and open the path to recovery. Target cards should feel more structured and practical. Recovery cards should feel supportive, not promotional. Trend and insight cards should be lighter, more secondary, and never visually outrank the first-screen reading path.

Buttons should feel invitational rather than commanding. Their presence should be obvious, but their tone should remain calm. Bottom navigation is a stable public component family and must remain consistent across all main tabs. Inputs, settings rows, and filters should feel light, low-friction, and native to the same quiet system.

## Task Priorities

The highest-priority task on the main user journey is to help the user calmly read last night and then move into tonight's next step. The first-screen hierarchy on the Today surface should always privilege:

1. last night's core result
2. tonight's target bedtime and wind-down frame
3. recovery guidance or immediate next action
4. lightweight trend awareness
5. secondary navigation, monetization, or settings entry

No chart, paywall cue, historical archive, or decorative device treatment may outrank the first-screen result statement. The user should understand the outcome quickly and then feel invited into the next action, not interrupted by analytics or commercial prompts.

## Interaction & Feedback

Feedback must feel predictable, gentle, and immediate. Tap and press states should confirm readiness without flashing. Loading states should resemble the final structure and preserve the reading order. Success should feel steady and reassuring. Warning should feel attentive, not punishing. Error should keep the user moving with a next action, not just explain failure.

Motion should remain restrained and meaningful. It may support continuity between sections, sheets, and shell transitions, but it should never create theatrical emphasis. State changes in bedtime mode, permission prompts, and recovery actions should feel smooth and controlled, especially at night.

## Responsive Strategy

The primary validation surface is iPhone-class mobile. The system is optimized for single-hand scanning, bottom navigation reliability, comfortable vertical rhythm, and fast first-screen comprehension under fatigue. Tablet may expand whitespace and container width, but it must not invent a second visual language. Desktop is not the defining composition target for this product.

Visually locked relationships include:

- the result-first reading order on Today
- the dominant countdown or state-selection block on Bedtime
- the quiet summary-first posture on Insights
- the shared shell and primary card family

Flexible regions include trend previews, list density, support notes, and deeper configuration groupings.

## States & Edge Cases

Every critical screen must intentionally support ideal, loading, empty, partial-data, disabled, success, warning, error, permission-denied, premium-locked, long-content, short-content, and slow-network situations. These states must preserve the core reading order instead of collapsing into generic placeholders.

When data is missing or delayed, the product should say so plainly and keep a usable next step alive. When a user slept late, the system should prioritize recovery explanation over shame. When content grows long, the first-screen focal statement and core next action must survive. When content is short, the interface should still feel complete, grounded, and deliberate.

## Content & Tone

The voice is calm, clear, and non-medical. It should sound like a composed guide that helps the user face reality without punishment. The product does not dramatize lateness and does not perform therapy. CTA language should feel like a quiet invitation such as “start wind-down” or “protect your evening,” not an order or challenge.

Naming must stay stable across screens and states. Shared component names and state names should reflect real usage situations: last night, tonight's target, recovery summary, trend note, permission needed, partial sync, premium locked. Copy should reduce shame and increase clarity in both good nights and rough nights.

## Do's and Don'ts

- Do preserve the result-first hierarchy on the main Today path.
- Do keep the shell, card families, status chips, and navigation visually consistent across screens.
- Do use whitespace and typography before decoration to create hierarchy.
- Do keep warning and recovery states warm, clear, and non-punitive.
- Do design empty, loading, partial-data, error, and locked states as first-class experiences.
- Do keep the visual system light-mode calm by default and avoid decorative darkness as identity.
- Don't turn the app into a medical dashboard or data console.
- Don't let charts, metrics, or monetization compete with the first-screen reading path.
- Don't fall back to blue-purple dream gradients, glossy glassmorphism, or heavy wellness cliches.
- Don't let page-local styling break the shared shell, shared CTA posture, or shared card family.
- Don't rely on color alone to explain lateness, recovery need, or sync problems.
- Don't let responsive adaptation become a different product language.
