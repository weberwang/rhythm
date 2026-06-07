# Rhythm Today 壳层统一修图设计

## 目标

将 [today-page.png](/D:/Projects/Flutter/rhythm/docs/rd/today-page.png) 统一到其他壳层页当前已经采用的设备呈现与导航合同，消除共享壳层规范校验阻塞。

## 本次范围

- 只重生成 `docs/rd/today-page.png`
- 不修改 `onboarding-page`
- 不重做 `calendar / bedtime / insights / profile-settings`

## 锁定决策

- 以其他壳层页当前样式为准，不以 `today-page` 现状为准
- 统一设备外框、顶部状态区、整体截图构图
- 统一底部导航合同：
  - tab 顺序固定为 `Today / Calendar / Bedtime / Insights / Profile`
  - `Today` 使用太阳语义图标
  - 激活态延续其他壳层页当前的轻强调样式

## 保留项

- 首页仍保持“今晚行动主卡”为唯一首屏重心
- 保留 `today-page` 当前的信息层级：主行动卡、昨晚结果摘要、恢复建议、趋势预告
- 保持 light mode、偏冷清醒、低压迫、非仪表盘化的共享方向

## 成功标准

- `today-page` 与 `calendar / bedtime / insights / profile-settings` 的设备呈现语言一致
- `Today` tab 的图标语义与其他壳层页一致
- 不牺牲首页主卡 dominance
