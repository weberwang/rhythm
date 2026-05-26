# Calendar Mood Paper Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为日历页的有标签日期增加“情绪纸片”视觉层，同时保持热力底色继续表达与目标时间的偏差。

**Architecture:** 先在领域层建立 `标签 -> 主情绪` 的稳定规则，再把情绪结果并入 `CalendarDaySummary`，最后由热力图组件叠加纸片样式，并让详情弹层复用同一主情绪颜色。样式实现拆成独立 widget 和样式解析器，避免在 `CalendarHeatmap` 与详情弹层里重复写视觉判断。

**Tech Stack:** Flutter, flutter_test, hooks_riverpod, flutter_riverpod, go_router, intl

---

## 文件结构

### 新建文件

- `lib/features/calendar/domain/calendar_day_mood.dart`
作用：定义首页情绪纸片所需的主情绪枚举。

- `lib/features/calendar/domain/calendar_mood_rules.dart`
作用：承接 `tags -> primaryMood / hasSecondaryMood` 的纯规则映射。

- `lib/features/calendar/presentation/widgets/calendar_mood_style.dart`
作用：集中解析情绪纸片的颜色、旋转角度、透明度和第二层纸边样式。

- `lib/features/calendar/presentation/widgets/calendar_mood_paper.dart`
作用：渲染单个日期格内部的纸片层，不承接业务判断。

- `test/features/calendar/calendar_mood_rules_test.dart`
作用：锁定默认标签、自定义标签、多标签优先级和未命中标签回退规则。

- `test/features/calendar/calendar_heatmap_test.dart`
作用：锁定热力格在无标签、单标签、多标签下的纸片显示行为。

### 修改文件

- `lib/app/theme/app_theme_tokens.dart`
作用：集中沉淀情绪纸片所需的亮暗主题语义色。

- `lib/features/calendar/domain/calendar_day_summary.dart`
作用：把 `primaryMood` 和 `hasSecondaryMood` 纳入单日摘要契约。

- `lib/features/calendar/domain/calendar_heatmap_rules.dart`
作用：在生成日摘要时统一计算情绪结果，避免显示层临时推导。

- `lib/features/calendar/presentation/widgets/calendar_heatmap.dart`
作用：把日期格改为“热力底色 + 纸片层 + 日期数字”的稳定层级。

- `lib/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart`
作用：让详情弹层复用主情绪色，保持首页与详情一致。

- `test/features/calendar/calendar_controller_test.dart`
作用：验证标签会被聚合进日摘要的情绪字段。

- `test/features/calendar/calendar_page_test.dart`
作用：验证页面级状态下的纸片可见性。

- `test/features/calendar/calendar_interaction_flow_test.dart`
作用：更新构造夹具，保证新字段接线后交互测试继续稳定。

- `test/features/calendar/calendar_page_analytics_flow_test.dart`
作用：更新构造夹具，避免 `CalendarDaySummary` 扩展后测试失配。

- `test/features/calendar/calendar_day_detail_sheet_test.dart`
作用：验证详情弹层的情绪导条与无情绪回退状态。

---

### Task 1: 建立情绪枚举与标签归类规则

**Files:**
- Create: `lib/features/calendar/domain/calendar_day_mood.dart`
- Create: `lib/features/calendar/domain/calendar_mood_rules.dart`
- Test: `test/features/calendar/calendar_mood_rules_test.dart`

- [x] **Step 1: 先写失败测试，锁定默认标签、多标签优先级和未命中标签回退**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_mood_rules.dart';

void main() {
  test('刷手机和聚会同时存在时优先落到空耗主情绪，并标记第二情绪', () {
    final result = CalendarMoodRules.resolve(
      const <String>['刷手机', '聚会'],
    );

    expect(result.primaryMood, CalendarDayMood.drained);
    expect(result.hasSecondaryMood, isTrue);
  });

  test('加班和游戏同时存在时优先落到烦躁主情绪', () {
    final result = CalendarMoodRules.resolve(
      const <String>['加班', '游戏'],
    );

    expect(result.primaryMood, CalendarDayMood.restless);
    expect(result.hasSecondaryMood, isTrue);
  });

  test('未命中的自定义标签不会生成首页情绪纸片', () {
    final result = CalendarMoodRules.resolve(
      const <String>['临时备注'],
    );

    expect(result.primaryMood, isNull);
    expect(result.hasSecondaryMood, isFalse);
  });
}
```

- [x] **Step 2: 运行规则测试，确认当前缺口**

Run: `flutter test test/features/calendar/calendar_mood_rules_test.dart -r expanded`
Expected: FAIL，提示 `calendar_day_mood.dart` 或 `CalendarMoodRules.resolve` 尚不存在

- [x] **Step 3: 用最小实现补齐情绪枚举和规则解析**

```dart
/// 表示首页日历纸片要表达的主情绪。
enum CalendarDayMood {
  calm,
  restless,
  drained,
  excited,
}

/// 聚合首页纸片所需的最小情绪结果。
class CalendarMoodSelection {
  const CalendarMoodSelection({
    required this.primaryMood,
    required this.hasSecondaryMood,
  });

  final CalendarDayMood? primaryMood;
  final bool hasSecondaryMood;
}

class CalendarMoodRules {
  const CalendarMoodRules._();

  static const Map<CalendarDayMood, int> _priority = <CalendarDayMood, int>{
    CalendarDayMood.restless: 4,
    CalendarDayMood.drained: 3,
    CalendarDayMood.excited: 2,
    CalendarDayMood.calm: 1,
  };

  static CalendarMoodSelection resolve(List<String> tags) {
    final moods = tags
        .map(_mapTagToMood)
        .whereType<CalendarDayMood>()
        .toSet()
        .toList(growable: false);
    if (moods.isEmpty) {
      return const CalendarMoodSelection(
        primaryMood: null,
        hasSecondaryMood: false,
      );
    }

    moods.sort(
      (left, right) => _priority[right]!.compareTo(_priority[left]!),
    );
    return CalendarMoodSelection(
      primaryMood: moods.first,
      hasSecondaryMood: moods.length > 1,
    );
  }

  static CalendarDayMood? _mapTagToMood(String rawTag) {
    final tag = rawTag.trim();
    if (tag.isEmpty) {
      return null;
    }
    if (const <String>{'加班', '情绪', '时差', '焦虑', '压力'}.contains(tag)) {
      return CalendarDayMood.restless;
    }
    if (const <String>{'刷手机', '追剧', '发呆', '没精神'}.contains(tag)) {
      return CalendarDayMood.drained;
    }
    if (const <String>{'游戏', '聚会', '聊天', '开心'}.contains(tag)) {
      return CalendarDayMood.excited;
    }
    if (const <String>{'阅读', '放松', '收心', '按计划'}.contains(tag)) {
      return CalendarDayMood.calm;
    }
    return null;
  }
}
```

- [x] **Step 4: 再跑规则测试，确认归类口径稳定**

Run: `flutter test test/features/calendar/calendar_mood_rules_test.dart -r expanded`
Expected: PASS

- [ ] **Step 5: 提交情绪规则基础层（按 AGENTS 统一收口流程延后）**

```bash
git add lib/features/calendar/domain/calendar_day_mood.dart lib/features/calendar/domain/calendar_mood_rules.dart test/features/calendar/calendar_mood_rules_test.dart
git commit -m "feat: add calendar mood rules"
```

### Task 2: 把情绪结果并入单日摘要契约

**Files:**
- Modify: `lib/features/calendar/domain/calendar_day_summary.dart`
- Modify: `lib/features/calendar/domain/calendar_heatmap_rules.dart`
- Modify: `test/features/calendar/calendar_controller_test.dart`
- Modify: `test/features/calendar/calendar_page_test.dart`
- Modify: `test/features/calendar/calendar_interaction_flow_test.dart`
- Modify: `test/features/calendar/calendar_page_analytics_flow_test.dart`
- Modify: `test/features/calendar/calendar_day_detail_sheet_test.dart`

- [x] **Step 1: 先写失败测试，锁定已保存标签会生成主情绪和第二层标记**

```dart
test('控制器会把已保存标签映射成主情绪和叠层标记', () async {
  final repository = InMemorySleepDelayTagRepository();
  await repository.saveTags(
    recordDate: DateTime.utc(2026, 5, 24),
    tags: const <String>['加班', '游戏'],
  );

  final container = ProviderContainer(
    overrides: [
      sleepDelayTagRepositoryProvider.overrideWithValue(repository),
      goalScheduleSettingsRepositoryProvider.overrideWithValue(
        TestGoalScheduleSettingsRepository(settings),
      ),
      recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
        (ref) async => const <EffectiveSleepRecord>[],
      ),
      timeContextProvider.overrideWithValue(
        TimeContext(
          now: DateTime.utc(2026, 5, 24, 20),
          timezoneName: 'Asia/Shanghai',
        ),
      ),
    ],
  );
  addTearDown(container.dispose);

  final state = await container.read(calendarControllerProvider.future);
  final day = state.monthSummary!.days.firstWhere(
    (item) => item.date == DateTime.utc(2026, 5, 24),
  );

  expect(day.primaryMood, CalendarDayMood.restless);
  expect(day.hasSecondaryMood, isTrue);
});
```

- [x] **Step 2: 运行控制器测试，确认摘要契约仍缺少情绪字段**

Run: `flutter test test/features/calendar/calendar_controller_test.dart -r expanded`
Expected: FAIL，提示 `primaryMood` / `hasSecondaryMood` 未定义

- [x] **Step 3: 扩展 `CalendarDaySummary` 和摘要生成规则，并同步更新所有构造夹具**

```dart
class CalendarDaySummary {
  const CalendarDaySummary({
    required this.date,
    required this.record,
    required this.sleepOffsetMinutes,
    required this.heatLevel,
    required this.tags,
    required this.primaryMood,
    required this.hasSecondaryMood,
  });

  final DateTime date;
  final EffectiveSleepRecord? record;
  final int? sleepOffsetMinutes;
  final CalendarHeatLevel heatLevel;
  final List<String> tags;
  final CalendarDayMood? primaryMood;
  final bool hasSecondaryMood;
}

static CalendarDaySummary buildDaySummary({
  required DateTime date,
  required EffectiveSleepRecord? record,
  required GoalScheduleSettings settings,
  required List<String> tags,
}) {
  final mood = CalendarMoodRules.resolve(tags);
  final heatLevel = record == null
      ? CalendarHeatLevel.noRecord
      : _resolveHeatLevel(
          offsetMinutes: record.fellAsleepAt.difference(
            DateTime.utc(
              date.year,
              date.month,
              date.day,
              settings.targetBedtimeMinutes ~/ 60,
              settings.targetBedtimeMinutes % 60,
            ),
          ).inMinutes,
          lateThresholdMinutes: settings.lateThresholdMinutes,
        );

  return CalendarDaySummary(
    date: date,
    record: record,
    sleepOffsetMinutes: record == null
        ? null
        : record.fellAsleepAt.difference(
            DateTime.utc(
              date.year,
              date.month,
              date.day,
              settings.targetBedtimeMinutes ~/ 60,
              settings.targetBedtimeMinutes % 60,
            ),
          ).inMinutes,
    heatLevel: heatLevel,
    tags: tags,
    primaryMood: mood.primaryMood,
    hasSecondaryMood: mood.hasSecondaryMood,
  );
}
```

同步把所有测试夹具里的 `CalendarDaySummary(...)` 构造改成显式传入：

```dart
CalendarDaySummary(
  date: DateTime.utc(2026, 5, 24),
  record: _buildRecord(),
  sleepOffsetMinutes: 50,
  heatLevel: CalendarHeatLevel.late,
  tags: const <String>['刷手机'],
  primaryMood: CalendarDayMood.drained,
  hasSecondaryMood: false,
);
```

- [x] **Step 4: 运行摘要相关测试，确认新字段已经贯穿现有夹具**

Run: `flutter test test/features/calendar/calendar_controller_test.dart test/features/calendar/calendar_page_test.dart test/features/calendar/calendar_interaction_flow_test.dart test/features/calendar/calendar_page_analytics_flow_test.dart test/features/calendar/calendar_day_detail_sheet_test.dart -r expanded`
Expected: PASS

- [ ] **Step 5: 提交摘要契约扩展（按 AGENTS 统一收口流程延后）**

```bash
git add lib/features/calendar/domain/calendar_day_summary.dart lib/features/calendar/domain/calendar_heatmap_rules.dart test/features/calendar/calendar_controller_test.dart test/features/calendar/calendar_page_test.dart test/features/calendar/calendar_interaction_flow_test.dart test/features/calendar/calendar_page_analytics_flow_test.dart test/features/calendar/calendar_day_detail_sheet_test.dart
git commit -m "feat: carry mood data into calendar summaries"
```

### Task 3: 渲染情绪纸片并接入热力图

**Files:**
- Modify: `lib/app/theme/app_theme_tokens.dart`
- Create: `lib/features/calendar/presentation/widgets/calendar_mood_style.dart`
- Create: `lib/features/calendar/presentation/widgets/calendar_mood_paper.dart`
- Modify: `lib/features/calendar/presentation/widgets/calendar_heatmap.dart`
- Create: `test/features/calendar/calendar_heatmap_test.dart`
- Modify: `test/features/calendar/calendar_page_test.dart`

- [x] **Step 1: 先写失败测试，锁定无标签、单标签、多标签三种纸片表现**

```dart
testWidgets('有主情绪的日期格会渲染纸片，多标签时露出第二层纸边', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CalendarHeatmap(
          days: <CalendarDaySummary>[
            CalendarDaySummary(
              date: DateTime.utc(2026, 5, 1),
              record: null,
              sleepOffsetMinutes: null,
              heatLevel: CalendarHeatLevel.noRecord,
              tags: const <String>[],
              primaryMood: null,
              hasSecondaryMood: false,
            ),
            CalendarDaySummary(
              date: DateTime.utc(2026, 5, 2),
              record: null,
              sleepOffsetMinutes: 40,
              heatLevel: CalendarHeatLevel.late,
              tags: const <String>['加班', '游戏'],
              primaryMood: CalendarDayMood.restless,
              hasSecondaryMood: true,
            ),
          ],
          onTapDay: (_) {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('calendar-mood-paper-2')), findsOneWidget);
  expect(find.byKey(const Key('calendar-mood-paper-secondary-2')), findsOneWidget);
  expect(find.byKey(const Key('calendar-mood-paper-1')), findsNothing);
});

testWidgets('页面级 ready 状态会把带标签日期渲染为情绪纸片', (tester) async {
  await pumpPage(tester, state: _readyState());

  expect(find.byType(CalendarMoodPaper), findsOneWidget);
});
```

- [x] **Step 2: 运行热力图测试，确认纸片层尚未实现**

Run: `flutter test test/features/calendar/calendar_heatmap_test.dart -r expanded`
Expected: FAIL，提示找不到纸片 key 或 `CalendarMoodPaper` 组件

- [x] **Step 3: 实现主题语义色、纸片样式解析器和热力图叠层**

```dart
class AppThemeTokens {
  const AppThemeTokens({
    required this.brightness,
    required this.seed,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceInverse,
    required this.primary,
    required this.primaryMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.divider,
    required this.warning,
    required this.warningSurface,
    required this.danger,
    required this.dangerSurface,
    required this.success,
    required this.successSurface,
    required this.moodCalmPaper,
    required this.moodRestlessPaper,
    required this.moodDrainedPaper,
    required this.moodExcitedPaper,
  });

  final Color moodCalmPaper;
  final Color moodRestlessPaper;
  final Color moodDrainedPaper;
  final Color moodExcitedPaper;
}
```

```dart
class CalendarMoodPaper extends StatelessWidget {
  const CalendarMoodPaper({
    super.key,
    required this.day,
  });

  final CalendarDaySummary day;

  @override
  Widget build(BuildContext context) {
    final mood = day.primaryMood;
    if (mood == null) {
      return const SizedBox.shrink();
    }

    final style = resolveCalendarMoodStyle(context, mood);
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final paperWidth = constraints.maxWidth * 0.46;
          final paperHeight = constraints.maxHeight * 0.22;
          final paperColor = day.hasRecord
              ? style.fillColor
              : style.fillColor.withOpacity(0.55);
          return Stack(
            children: [
              Positioned(
                right: constraints.maxWidth * 0.12,
                bottom: constraints.maxHeight * 0.12,
                child: Transform.rotate(
                  angle: style.rotationRadians,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (day.hasSecondaryMood)
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            key: Key('calendar-mood-paper-secondary-${day.date.day}'),
                            width: paperWidth * 0.78,
                            height: 3,
                            decoration: BoxDecoration(
                              color: style.edgeColor,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      Container(
                        key: Key('calendar-mood-paper-${day.date.day}'),
                        width: paperWidth,
                        height: paperHeight,
                        decoration: BoxDecoration(
                          color: paperColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

```dart
return Container(
  decoration: BoxDecoration(
    color: _resolveCellColor(context, day.heatLevel),
    borderRadius: BorderRadius.circular(10),
  ),
  child: InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: () => onTapDay(day),
    child: Stack(
      children: [
        CalendarMoodPaper(day: day),
        Align(
          alignment: const Alignment(0, -0.12),
          child: Text(
            '${day.date.day}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    ),
  ),
);
```

- [x] **Step 4: 跑热力图与页面测试，确认纸片只出现在有情绪的日期格**

Run: `flutter test test/features/calendar/calendar_heatmap_test.dart test/features/calendar/calendar_page_test.dart -r expanded`
Expected: PASS

- [ ] **Step 5: 提交情绪纸片显示层（按 AGENTS 统一收口流程延后）**

```bash
git add lib/app/theme/app_theme_tokens.dart lib/features/calendar/presentation/widgets/calendar_mood_style.dart lib/features/calendar/presentation/widgets/calendar_mood_paper.dart lib/features/calendar/presentation/widgets/calendar_heatmap.dart test/features/calendar/calendar_heatmap_test.dart test/features/calendar/calendar_page_test.dart
git commit -m "feat: render mood paper on calendar heatmap"
```

### Task 4: 让详情弹层复用主情绪视觉线索

**Files:**
- Modify: `lib/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart`
- Modify: `test/features/calendar/calendar_day_detail_sheet_test.dart`

- [x] **Step 1: 先写失败测试，锁定有主情绪时显示导条、无主情绪时不显示**

```dart
testWidgets('详情弹层会复用主情绪导条', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('zh'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: CalendarDayDetailSheet(
          summary: CalendarDaySummary(
            date: DateTime.utc(2026, 5, 24),
            record: _buildRecord(),
            sleepOffsetMinutes: 50,
            heatLevel: CalendarHeatLevel.late,
            tags: const <String>['刷手机'],
            primaryMood: CalendarDayMood.drained,
            hasSecondaryMood: false,
          ),
          onAddTag: () {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('calendar-day-mood-accent')), findsOneWidget);
});
```

- [x] **Step 2: 运行详情测试，确认导条尚未接入**

Run: `flutter test test/features/calendar/calendar_day_detail_sheet_test.dart -r expanded`
Expected: FAIL，提示找不到 `calendar-day-mood-accent`

- [x] **Step 3: 在详情标题上方加入主情绪导条，并复用同一套样式解析器**

```dart
final mood = summary.primaryMood;

if (mood != null) ...[
  Container(
    key: const Key('calendar-day-mood-accent'),
    width: 44,
    height: 6,
    decoration: BoxDecoration(
      color: resolveCalendarMoodStyle(context, mood).edgeColor,
      borderRadius: BorderRadius.circular(999),
    ),
  ),
  const SizedBox(height: 12),
]
```

- [x] **Step 4: 再跑详情测试，确认首页与详情的主情绪已对齐**

Run: `flutter test test/features/calendar/calendar_day_detail_sheet_test.dart -r expanded`
Expected: PASS

- [ ] **Step 5: 提交详情一致性改动（按 AGENTS 统一收口流程延后）**

```bash
git add lib/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart test/features/calendar/calendar_day_detail_sheet_test.dart
git commit -m "feat: reuse mood accent in calendar detail sheet"
```

### Task 5: 回归日历专项测试并做影响面检查

**Files:**
- Modify: `docs/superpowers/plans/2026-05-25-calendar-mood-paper.md`

- [x] **Step 1: 跑完整日历专项测试，确认领域、页面、交互链路全部回归**

Run: `flutter test test/features/calendar -r expanded`
Expected: PASS

- [ ] **Step 2: 跑全量测试，确认没有引入跨 feature 编译回归**

Run: `flutter test -r expanded`
Expected: PASS；如果仍只失败在与本任务无关的 `profilePreferences*` 本地化缺口，先记录为现有工作区阻塞，再和分支 owner 对齐后处理

- [ ] **Step 3: 运行 GitNexus 变更检测，确认影响范围只落在预期符号**

Use MCP: `detect_changes(scope: "all", repo: "rhythm")`
Expected: 受影响符号集中在 `CalendarDaySummary`、`CalendarHeatmapRules`、`CalendarHeatmap`、`CalendarDayDetailSheet`、新增情绪规则/纸片组件及对应测试

- [ ] **Step 4: 按用户选择执行 git 收口**

```bash
git add lib/app/theme/app_theme_tokens.dart lib/features/calendar test/features/calendar docs/superpowers/specs/2026-05-25-calendar-mood-paper-design.md docs/superpowers/plans/2026-05-25-calendar-mood-paper.md
git commit -m "feat: add calendar mood paper"
```
