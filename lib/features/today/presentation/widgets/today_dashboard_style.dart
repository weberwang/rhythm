import 'package:flutter/material.dart';

/// 汇总 today 页面视觉常量，避免多文件各自漂移出不同样式。
class TodayDashboardStyle {
  /// 私有构造，避免误实例化。
  const TodayDashboardStyle._();

  /// 页面顶部暖色氛围底色。
  static const Color pageTopTint = Color(0xFFFFFCF7);

  /// 页头左上角柔光。
  static const Color headerGlow = Color(0x14EEDCCB);

  /// 页面右侧次级冷色柔光。
  static const Color secondaryGlow = Color(0x164FC0C4);

  /// 主标题深墨绿色。
  static const Color ink = Color(0xFF123844);

  /// 常规正文灰蓝色。
  static const Color body = Color(0xFF5F6F78);

  /// 高级卡片边框色。
  static const Color cardStroke = Color(0xFFE2ECEF);

  /// 今晚目标卡的冷色底。
  static const Color goalTint = Color(0xFFF1F8FB);

  /// 恢复建议卡的浅绿色底。
  static const Color recoveryTint = Color(0xFFF3FAF6);

  /// 快捷记录的强调橙色。
  static const Color recordAccent = Color(0xFFFF835D);

  /// 趋势折线主色。
  static const Color trendLine = Color(0xFF168A92);

  /// 趋势选中日底色。
  static const Color trendDayFill = Color(0xFFDFF1F2);

  /// 仿效果图的衬线字族。
  static const String serifFontFamily = 'Georgia';

  /// 品牌字标比正文衬线更轻更舒展，避免落成沉重报纸感。
  static TextStyle brandWordmark(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 29,
      height: 1,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.78,
    );
  }

  /// 统一卡片圆角，保证整页材质一致。
  static BorderRadius get cardRadius => BorderRadius.circular(30);

  /// 页头欢迎语使用衬线字形，强调“今日首页”的编辑感。
  static TextStyle heroTitle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 25,
      height: 1.08,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.6,
    );
  }

  /// 页头副标题比卡片正文略大，接近效果图里的首屏引导强度。
  static TextStyle heroBody(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 17,
      color: body,
      fontWeight: FontWeight.w400,
      height: 1.42,
      letterSpacing: -0.12,
    );
  }

  /// 卡片主标题同样使用衬线字形，形成和效果图一致的主次对比。
  static TextStyle cardHeadline(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 27,
      height: 1.08,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.5,
    );
  }

  /// 次级卡片标题稍降字号，但维持同一衬线系统。
  static TextStyle cardTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 23,
      height: 1.12,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.34,
    );
  }

  /// 卡片正文保持清晰阅读密度，避免被装饰气氛吞掉信息。
  static TextStyle bodyText(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 16.5,
      color: body,
      fontWeight: FontWeight.w400,
      height: 1.46,
      letterSpacing: -0.08,
    );
  }

  /// 小节标签沿用高对比大写风格，承接效果图的信息锚点。
  static TextStyle sectionLabel(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w700,
      fontSize: 12.5,
      letterSpacing: 1.35,
    );
  }

  /// 分数环中的主数字需要明显大于其他时间数字，形成首屏绝对焦点。
  static TextStyle scoreValue(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 46,
      color: ink,
      fontWeight: FontWeight.w500,
      height: 0.84,
      letterSpacing: -1,
    );
  }

  /// 分数环内的状态短词保持清爽，不和数值争夺焦点。
  static TextStyle scoreLabel(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 16,
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.08,
    );
  }

  /// 卡片内的主时间值沿用衬线，并保留更强的展示属性。
  static TextStyle timeValue(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 31,
      fontWeight: FontWeight.w500,
      color: ink,
      height: 0.94,
      letterSpacing: -0.78,
    );
  }

  /// 提醒时间等次级数字用无衬线收口，和主 bedtime 形成材质对比。
  static TextStyle supportValue(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 18.5,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.2,
    );
  }

  /// 次级标签统一压低存在感，让主值先被看到。
  static TextStyle supportLabel(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 15.5,
      color: body,
      fontWeight: FontWeight.w400,
      height: 1.3,
      letterSpacing: -0.08,
    );
  }

  /// 指标数值略紧凑，避免底部三列区域显得笨重。
  static TextStyle metricValue(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 17.5,
      color: ink,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.18,
    );
  }

  /// 指标标签作为说明文字，需要更轻、更稳的字色与字重。
  static TextStyle metricLabel(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 15,
      color: body,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.06,
    );
  }

  /// 趋势右上角和折线上方的分值字重与标题错开，避免上半区过重。
  static TextStyle trendValue(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 15.5,
      color: ink,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.08,
    );
  }

  /// 趋势日期标签用更克制的正文级字体。
  static TextStyle trendDay(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 15,
      color: body,
      fontWeight: FontWeight.w400,
    );
  }

  /// 选中日期需要更紧凑更实一点，才有胶囊选中态的“钉住”感。
  static TextStyle trendDaySelected(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 15,
      color: ink,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.08,
    );
  }

  /// 统一卡片阴影，既有悬浮感，又不让页面变成厚重电商卡片。
  static List<BoxShadow> get cardShadow => const [
    BoxShadow(color: Color(0x100F2F39), blurRadius: 30, offset: Offset(0, 14)),
    BoxShadow(color: Color(0x08FFFFFF), blurRadius: 10, offset: Offset(0, 1)),
  ];
}
