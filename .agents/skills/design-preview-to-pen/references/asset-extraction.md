# Asset Extraction

## Classification First

Do not extract by canvas region alone. Classify each element:

- `布局元素`: rebuild structurally in Pencil
- `文本`: retype in Pencil
- `图标`: redraw, re-generate, or replace with cleaner sources
- `插图`: isolate as image assets when they carry style information
- `背景纹理`: keep as raster only if Pencil structure would be wasteful

## Extraction Rules

- Prefer source regeneration over low-resolution bitmap crops.
- Prefer transparent illustration assets for floating decorative pieces.
- Prefer redraw for icons that need crisp scaling.
- Keep one asset manifest row per exported or regenerated asset.

## Asset Manifest Fields

- `名称`
- `类型`
- `来源`
- `处理方式`
- `透明需求`
- `目标位置`
- `备注`

## Do Not

- Do not flatten text into exported images.
- Do not mix icon and illustration handling into one rule.
- Do not reuse an approved preview as the only source of all final assets.
