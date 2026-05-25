# Profile Preferences Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在【我的】页新增语言与主题切换，并让偏好立即全局生效且持久化到本地。

**Architecture:** 新增 `preferences` feature 管理应用级显示偏好，使用 `shared_preferences` 做本地持久化，使用 Riverpod provider 将偏好派生为 `Locale?` 与 `ThemeMode` 提供给 `RhythmApp`。显示层只新增一个偏好卡片，不直接接触存储细节。

**Tech Stack:** Flutter, hooks_riverpod, riverpod_annotation, freezed, shared_preferences, flutter_test

---

### Task 1: 建立偏好领域模型与仓储测试

**Files:**
- Create: `lib/features/preferences/domain/app_locale_preference.dart`
- Create: `lib/features/preferences/domain/app_theme_preference.dart`
- Create: `lib/features/preferences/domain/app_preferences.dart`
- Create: `lib/features/preferences/domain/app_preferences_repository.dart`
- Create: `test/features/preferences/data/shared_preferences_app_preferences_repository_test.dart`

- [ ] **Step 1: 写失败测试**

```dart
test('未保存偏好时返回跟随系统默认值', () async {
  SharedPreferences.setMockInitialValues(<String, Object?>{});
  final preferences = await SharedPreferences.getInstance();
  final repository = SharedPreferencesAppPreferencesRepository(preferences);

  final restored = await repository.read();

  expect(restored, AppPreferences.fallback());
});

test('保存后会恢复语言与主题偏好', () async {
  SharedPreferences.setMockInitialValues(<String, Object?>{});
  final preferences = await SharedPreferences.getInstance();
  final repository = SharedPreferencesAppPreferencesRepository(preferences);
  const expected = AppPreferences(
    localePreference: AppLocalePreference.english,
    themePreference: AppThemePreference.dark,
  );

  await repository.save(expected);
  final restored = await repository.read();

  expect(restored, expected);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `flutter test test/features/preferences/data/shared_preferences_app_preferences_repository_test.dart`

Expected: FAIL，提示 `SharedPreferencesAppPreferencesRepository` 或 `AppPreferences` 尚未定义。

- [ ] **Step 3: 编写最小实现**

```dart
enum AppLocalePreference { system, simplifiedChinese, english }

enum AppThemePreference { system, light, dark }

@freezed
abstract class AppPreferences with _$AppPreferences {
  const factory AppPreferences({
    @Default(AppLocalePreference.system)
    AppLocalePreference localePreference,
    @Default(AppThemePreference.system)
    AppThemePreference themePreference,
  }) = _AppPreferences;

  factory AppPreferences.fallback() => const AppPreferences();
}

abstract class AppPreferencesRepository {
  Future<AppPreferences> read();
  Future<void> save(AppPreferences preferences);
}
```

- [ ] **Step 4: 再补仓储实现并回到绿色**

```dart
class SharedPreferencesAppPreferencesRepository
    implements AppPreferencesRepository {
  SharedPreferencesAppPreferencesRepository(this._sharedPreferences);

  static const localeKey = 'app_preferences.locale';
  static const themeKey = 'app_preferences.theme';

  final SharedPreferences _sharedPreferences;

  @override
  Future<AppPreferences> read() async {
    return AppPreferences(
      localePreference: AppLocalePreference.values.byName(
        _sharedPreferences.getString(localeKey) ?? AppLocalePreference.system.name,
      ),
      themePreference: AppThemePreference.values.byName(
        _sharedPreferences.getString(themeKey) ?? AppThemePreference.system.name,
      ),
    );
  }

  @override
  Future<void> save(AppPreferences preferences) async {
    await _sharedPreferences.setString(
      localeKey,
      preferences.localePreference.name,
    );
    await _sharedPreferences.setString(
      themeKey,
      preferences.themePreference.name,
    );
  }
}
```

- [ ] **Step 5: 运行测试确认通过**

Run: `flutter test test/features/preferences/data/shared_preferences_app_preferences_repository_test.dart`

Expected: PASS

- [ ] **Step 6: 提交**

```bash
git add lib/features/preferences/domain lib/features/preferences/data test/features/preferences/data
git commit -m "feat: add app preferences repository"
```

### Task 2: 建立应用层 provider、派生逻辑与失败回滚测试

**Files:**
- Create: `lib/features/preferences/application/app_preferences_providers.dart`
- Create: `test/features/preferences/application/app_preferences_providers_test.dart`
- Modify: `lib/app/bootstrap/launch_state_provider.dart`

- [ ] **Step 1: 写失败测试**

```dart
test('切换语言时会立即更新 locale provider', () async {
  final container = createPreferencesContainer();

  await container
      .read(appPreferencesControllerProvider.notifier)
      .updateLocale(AppLocalePreference.english);

  expect(
    container.read(appLocaleProvider),
    const Locale('en'),
  );
});

test('保存失败时会回滚到旧偏好', () async {
  final container = ProviderContainer(
    overrides: [
      appPreferencesRepositoryProvider.overrideWithValue(
        ThrowingAppPreferencesRepository(),
      ),
    ],
  );

  await expectLater(
    container
        .read(appPreferencesControllerProvider.notifier)
        .updateTheme(AppThemePreference.dark),
    throwsA(isA<AppPreferencesSaveException>()),
  );
  expect(
    container.read(appPreferencesControllerProvider),
    AppPreferences.fallback(),
  );
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `flutter test test/features/preferences/application/app_preferences_providers_test.dart`

Expected: FAIL，提示 provider 或 controller 尚未定义。

- [ ] **Step 3: 写最小应用层实现**

```dart
@riverpod
AppPreferencesRepository appPreferencesRepository(Ref ref) {
  return SharedPreferencesAppPreferencesRepository(
    ref.watch(sharedPreferencesProvider),
  );
}

@riverpod
class AppPreferencesController extends _$AppPreferencesController {
  @override
  AppPreferences build() {
    return ref.watch(appPreferencesRepositoryProvider).read();
  }

  Future<void> updateLocale(AppLocalePreference preference) async {
    final previous = state;
    final next = state.copyWith(localePreference: preference);
    state = next;
    await ref.read(appPreferencesRepositoryProvider).save(next);
  }
}

@riverpod
Locale? appLocale(Ref ref) => switch (
      ref.watch(appPreferencesControllerProvider).localePreference
    ) {
      AppLocalePreference.system => null,
      AppLocalePreference.simplifiedChinese => const Locale('zh'),
      AppLocalePreference.english => const Locale('en'),
    };

@riverpod
ThemeMode appThemeMode(Ref ref) => switch (
      ref.watch(appPreferencesControllerProvider).themePreference
    ) {
      AppThemePreference.system => ThemeMode.system,
      AppThemePreference.light => ThemeMode.light,
      AppThemePreference.dark => ThemeMode.dark,
    };
```

- [ ] **Step 4: 补齐失败回滚与错误类型**

```dart
class AppPreferencesSaveException implements Exception {
  const AppPreferencesSaveException();
}

Future<void> _persist(AppPreferences previous, AppPreferences next) async {
  try {
    await ref.read(appPreferencesRepositoryProvider).save(next);
  } catch (_) {
    state = previous;
    throw const AppPreferencesSaveException();
  }
}
```

- [ ] **Step 5: 运行测试确认通过**

Run: `flutter test test/features/preferences/application/app_preferences_providers_test.dart`

Expected: PASS

- [ ] **Step 6: 提交**

```bash
git add lib/features/preferences/application lib/app/bootstrap/launch_state_provider.dart test/features/preferences/application
git commit -m "feat: add app preferences providers"
```

### Task 3: 改造根应用消费全局偏好并补应用级测试

**Files:**
- Modify: `lib/app/rhythm_app.dart`
- Create: `test/app/rhythm_app_preferences_test.dart`

- [ ] **Step 1: 写失败测试**

```dart
testWidgets('根应用会应用英语和深色主题偏好', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appLocaleProvider.overrideWith((ref) => const Locale('en')),
        appThemeModeProvider.overrideWith((ref) => ThemeMode.dark),
      ],
      child: const RhythmApp(),
    ),
  );
  await tester.pump();

  final materialApp = tester.widget<MaterialApp>(
    find.byType(MaterialApp),
  );
  expect(materialApp.locale, const Locale('en'));
  expect(materialApp.themeMode, ThemeMode.dark);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `flutter test test/app/rhythm_app_preferences_test.dart`

Expected: FAIL，提示 `RhythmApp` 仍固定使用系统主题或未挂接 `locale`。

- [ ] **Step 3: 写最小实现**

```dart
class RhythmApp extends HookConsumerWidget {
  const RhythmApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      locale: locale,
      themeMode: themeMode,
      // 其他配置保持不变
    );
  }
}
```

- [ ] **Step 4: 运行测试确认通过**

Run: `flutter test test/app/rhythm_app_preferences_test.dart`

Expected: PASS

- [ ] **Step 5: 提交**

```bash
git add lib/app/rhythm_app.dart test/app/rhythm_app_preferences_test.dart
git commit -m "feat: wire app preferences into root app"
```

### Task 4: 在我的页新增偏好设置卡片并补交互测试

**Files:**
- Modify: `lib/features/profile/presentation/profile_page.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`
- Modify: `test/features/profile/presentation/profile_page_test.dart`
- Create: `test/features/profile/presentation/profile_preferences_card_test.dart`

- [ ] **Step 1: 写失败测试**

```dart
testWidgets('我的页展示偏好设置卡片并默认显示跟随系统', (tester) async {
  await pumpProfilePage(tester);

  expect(find.text('偏好设置'), findsOneWidget);
  expect(find.text('语言'), findsOneWidget);
  expect(find.text('主题'), findsOneWidget);
  expect(find.text('跟随系统'), findsNWidgets(2));
});

testWidgets('切换为 English 后当前页立即刷新英文文案', (tester) async {
  await pumpRhythmApp(tester, onboardingCompleted: true);
  await tester.tap(find.text('English'));
  await tester.pumpAndSettle();

  expect(find.text('Me'), findsWidgets);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `flutter test test/features/profile/presentation/profile_page_test.dart test/features/profile/presentation/profile_preferences_card_test.dart`

Expected: FAIL，提示卡片文案或交互控件尚不存在。

- [ ] **Step 3: 写最小实现**

```dart
class _ProfilePreferencesCard extends HookConsumerWidget {
  const _ProfilePreferencesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(appPreferencesControllerProvider);
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        _PreferenceSegment<AppLocalePreference>(...),
        _PreferenceSegment<AppThemePreference>(...),
      ],
    );
  }
}
```

- [ ] **Step 4: 补失败提示与中文注释**

```dart
ref.listen<AppPreferencesError?>(appPreferencesErrorProvider, (previous, next) {
  if (next == null) {
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(l10n.profilePreferencesSaveFailed)),
  );
});
```

- [ ] **Step 5: 生成国际化代码**

Run: `flutter gen-l10n`

Expected: 成功生成新的 `AppLocalizations` 访问器。

- [ ] **Step 6: 运行相关测试确认通过**

Run: `flutter test test/features/preferences/data/shared_preferences_app_preferences_repository_test.dart test/features/preferences/application/app_preferences_providers_test.dart test/app/rhythm_app_preferences_test.dart test/features/profile/presentation/profile_page_test.dart test/features/profile/presentation/profile_preferences_card_test.dart`

Expected: PASS

- [ ] **Step 7: 提交**

```bash
git add lib/features/profile/presentation/profile_page.dart lib/l10n/app_en.arb lib/l10n/app_zh.arb test/features/profile/presentation
git commit -m "feat: add profile preferences controls"
```
