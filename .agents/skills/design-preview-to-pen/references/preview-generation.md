# Preview Generation

## Tool Policy

- Use `image_gen` for preview creation.
- Generate one to three options in a round.
- Change one major design variable per round.
- Keep each round labeled clearly: `preview-v1`, `preview-v2`, `preview-v3`.

## Prompt Scaffold

Structure prompts in this order:

1. `Use case`
2. `Asset type`
3. `Primary request`
4. `Subject`
5. `Style or medium`
6. `Composition and framing`
7. `Color palette`
8. `Typography or text rules`
9. `Constraints`
10. `Avoid`

## Iteration Policy

- If the user is choosing a direction, maximize contrast between options.
- If the user is refining one direction, keep the layout stable and change one detail.
- If text fidelity matters, keep text sparse in the preview and rebuild final copy in Pencil.
- If transparency is needed later, note that during freeze and generate isolated assets separately instead of expecting the preview to serve as the final transparent source.

## Output Summary

After every generation round, summarize:

- what changed
- what stayed fixed
- which option is recommended
- what decision is needed from the user
