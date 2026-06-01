import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_filter_bar.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 验证日历筛选胶囊在暗色主题下不再回落到浅色常量底色。
void main() {
  testWidgets('暗色主题下筛选胶囊使用主题扩展配色', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: CalendarFilterBar(
                l10n: AppLocalizations.of(context),
                tokens: AppThemeTokens.dark,
                activeFilter: const CalendarFilter(),
                onOpenFilter: () {},
              ),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    final selectedPill = tester.widget<Ink>(
      find.byKey(const Key('calendar-filter-pill-sleepTime')),
    );
    final selectedDecoration = selectedPill.decoration! as BoxDecoration;
    expect(
      selectedDecoration.color,
      AppTheme.dark()
          .extension<RhythmChipThemeExtension>()!
          .selectedBackgroundColor,
    );

    final unselectedPill = tester.widget<Ink>(
      find.byKey(const Key('calendar-filter-pill-stability')),
    );
    final unselectedDecoration = unselectedPill.decoration! as BoxDecoration;
    expect(
      unselectedDecoration.color,
      AppTheme.dark().extension<RhythmChipThemeExtension>()!.backgroundColor,
    );
  });
}
