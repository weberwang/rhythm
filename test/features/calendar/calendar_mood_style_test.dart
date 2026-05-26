import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_mood_style.dart';

void main() {
  test('情绪纸片样式会按亮暗模式切换色值，并保持足够可见度', () {
    final lightStyle = resolveCalendarMoodStyleFromTokens(
      AppThemeTokens.light,
      CalendarDayMood.drained,
    );
    final darkStyle = resolveCalendarMoodStyleFromTokens(
      AppThemeTokens.dark,
      CalendarDayMood.drained,
    );

    expect(darkStyle.opacity, greaterThan(lightStyle.opacity));
    expect(lightStyle.opacity, greaterThanOrEqualTo(0.68));
    expect(darkStyle.opacity, greaterThanOrEqualTo(0.84));
    expect(darkStyle.edgeColor.computeLuminance(), greaterThan(0.6));
  });
}
