import 'package:flutter/material.dart';

/// 统一承接 calendar 页面高保真还原所需的视觉常量与文字层级。
class CalendarPageStyle {
  /// 私有构造，避免误实例化。
  const CalendarPageStyle._();

  /// 页面顶部的暖色铺底，承接冻结图的轻柔背景。
  static const Color pageTopTint = Color(0xFFFFFCF7);

  /// 头部左侧柔光。
  static const Color headerGlow = Color(0x14EEDCCB);

  /// 热力图附近的次级冷色柔光。
  static const Color secondaryGlow = Color(0x164FC0C4);

  /// 主文字深墨绿色。
  static const Color ink = Color(0xFF123844);

  /// 常规正文灰蓝色。
  static const Color body = Color(0xFF5F6F78);

  /// 统一卡片描边色。
  static const Color stroke = Color(0xFFE2ECEF);

  /// 热力图接近目标的浅青色。
  static const Color onTargetFill = Color(0xFFE5F4F2);

  /// 热力图轻微偏移的浅蓝青色。
  static const Color slightDelayFill = Color(0xFFD7EFF0);

  /// 热力图明显偏移的浅珊瑚色。
  static const Color majorDelayFill = Color(0xFFFFEEE7);

  /// 热力图部分数据的温和米色。
  static const Color partialFill = Color(0xFFF4EFE4);

  /// 选中态主色。
  static const Color selectedFill = Color(0xFF446ED7);

  /// 选中态文字色。
  static const Color selectedForeground = Color(0xFFFFFFFF);

  /// 统一衬线字体族，保持编辑感。
  static const String serifFontFamily = 'Georgia';

  /// 页面统一圆角。
  static BorderRadius get cardRadius => BorderRadius.circular(30);

  /// 页面统一阴影，保持轻浮起感而不过厚。
  static List<BoxShadow> get cardShadow => const [
    BoxShadow(color: Color(0x100F2F39), blurRadius: 30, offset: Offset(0, 14)),
    BoxShadow(color: Color(0x08FFFFFF), blurRadius: 10, offset: Offset(0, 1)),
  ];

  /// 品牌字标使用轻衬线，避免标题落成普通列表页。
  static TextStyle brandWordmark(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 31,
      height: 1,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.78,
    );
  }

  /// 月份标题需要成为首屏主焦点。
  static TextStyle monthTitle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 33,
      height: 1.02,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.8,
    );
  }

  /// 摘要卡副标题使用稍大的正文，承接主解释。
  static TextStyle summaryBody(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 16.5,
      color: body,
      fontWeight: FontWeight.w400,
      height: 1.38,
      letterSpacing: -0.08,
    );
  }

  /// 指标数值采用更强展示属性。
  static TextStyle metricValue(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 23,
      color: color ?? ink,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.42,
    );
  }

  /// 指标标签保持克制，避免与数值争抢视线。
  static TextStyle metricLabel(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 15,
      color: body,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.06,
      height: 1.28,
    );
  }

  /// 星期标题保持高可读轻大写风格。
  static TextStyle weekdayLabel(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      color: body.withValues(alpha: 0.82),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    );
  }

  /// 热力图日期数字需要比偏移值更先被看到。
  static TextStyle heatmapDay(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: color ?? ink,
      letterSpacing: -0.22,
    );
  }

  /// 热力图偏移文案缩小一级，避免压住日期层级。
  static TextStyle heatmapOffset(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 12.5,
      fontWeight: FontWeight.w500,
      color: color ?? body,
      letterSpacing: -0.04,
    );
  }

  /// 详情卡日期标题继续使用衬线系统，和月度标题形成呼应。
  static TextStyle detailTitle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 28,
      height: 1.06,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.56,
    );
  }

  /// 详情卡主解释强调色更接近主题主色。
  static TextStyle detailAccent(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF2A959E),
      letterSpacing: -0.14,
    );
  }

  /// 详情卡字段标签压低存在感，突出数值。
  static TextStyle detailLabel(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 14.5,
      color: body,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.05,
    );
  }

  /// 详情卡字段值维持较强展示属性。
  static TextStyle detailValue(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 19,
      color: ink,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
    );
  }
}
