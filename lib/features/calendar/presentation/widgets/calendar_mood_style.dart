import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';

/// 日历情绪纸片的视觉参数。
class CalendarMoodStyle {
  /// 创建日历情绪纸片样式参数。
  const CalendarMoodStyle({
    required this.fillColor,
    required this.edgeColor,
    required this.rotationRadians,
    required this.widthFactor,
    required this.heightFactor,
    required this.opacity,
  });

  /// 主纸片颜色。
  final Color fillColor;

  /// 第二层纸边和详情导条使用的强调色。
  final Color edgeColor;

  /// 纸片旋转弧度。
  final double rotationRadians;

  /// 相对日期格宽度的纸片宽度比例。
  final double widthFactor;

  /// 相对日期格高度的纸片高度比例。
  final double heightFactor;

  /// 情绪纸片基础透明度。
  final double opacity;
}

/// 解析情绪对应的纸片样式，保证首页和详情复用同一套视觉语义。
CalendarMoodStyle resolveCalendarMoodStyle(
  BuildContext context,
  CalendarDayMood mood,
) {
  final tokens = Theme.of(context).brightness == Brightness.dark
      ? AppThemeTokens.dark
      : AppThemeTokens.light;
  return resolveCalendarMoodStyleFromTokens(tokens, mood);
}

/// 基于明确的主题 token 解析纸片样式，方便亮暗主题单独验证。
CalendarMoodStyle resolveCalendarMoodStyleFromTokens(
  AppThemeTokens tokens,
  CalendarDayMood mood,
) {
  switch (mood) {
    case CalendarDayMood.calm:
      return CalendarMoodStyle(
        fillColor: tokens.moodCalmPaper,
        edgeColor: tokens.brightness == Brightness.dark
            ? const Color(0xFFB9D8B7)
            : const Color(0xFF4F7B5A),
        rotationRadians: 0,
        widthFactor: 0.5,
        heightFactor: 0.23,
        opacity: tokens.brightness == Brightness.dark ? 0.88 : 0.74,
      );
    case CalendarDayMood.restless:
      return CalendarMoodStyle(
        fillColor: tokens.moodRestlessPaper,
        edgeColor: tokens.brightness == Brightness.dark
            ? const Color(0xFFF0C978)
            : const Color(0xFFB77A19),
        rotationRadians: 3 * math.pi / 180,
        widthFactor: 0.44,
        heightFactor: 0.2,
        opacity: tokens.brightness == Brightness.dark ? 0.9 : 0.78,
      );
    case CalendarDayMood.drained:
      return CalendarMoodStyle(
        fillColor: tokens.moodDrainedPaper,
        edgeColor: tokens.brightness == Brightness.dark
            ? const Color(0xFFE2D5CB)
            : const Color(0xFF8C7768),
        rotationRadians: -2 * math.pi / 180,
        widthFactor: 0.46,
        heightFactor: 0.18,
        opacity: tokens.brightness == Brightness.dark ? 0.84 : 0.7,
      );
    case CalendarDayMood.excited:
      return CalendarMoodStyle(
        fillColor: tokens.moodExcitedPaper,
        edgeColor: tokens.brightness == Brightness.dark
            ? const Color(0xFFF0B2A0)
            : const Color(0xFFC66C50),
        rotationRadians: -3 * math.pi / 180,
        widthFactor: 0.48,
        heightFactor: 0.22,
        opacity: tokens.brightness == Brightness.dark ? 0.9 : 0.76,
      );
  }
}
