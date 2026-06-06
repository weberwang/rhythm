import 'package:flutter/material.dart';

/// 汇总 bedtime 显示层的冻结样式 token，避免多组件各自漂移。
class BedtimePageStyle {
  /// 私有构造，避免误实例化。
  const BedtimePageStyle._();

  /// 参考冻结图的暖白底色。
  static const Color pageBackground = Color(0xFFFFFCF7);

  /// 统一深墨色标题。
  static const Color ink = Color(0xFF103946);

  /// 常规正文的灰蓝色。
  static const Color body = Color(0xFF62737B);

  /// 主强调青绿色。
  static const Color accent = Color(0xFF168A92);

  /// 柔和边框色。
  static const Color stroke = Color(0xFFE1EBED);

  /// 冷色光晕。
  static const Color mist = Color(0xFFEAF5F7);

  /// 暖色光晕。
  static const Color blush = Color(0xFFFFEAE2);

  /// 风格稿使用的衬线字族。
  static const String serifFontFamily = 'Georgia';

  /// 页面主标题样式。
  static TextStyle pageTitle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 31,
      height: 1,
      fontWeight: FontWeight.w500,
      color: ink,
      letterSpacing: -0.9,
    );
  }

  /// 页面副标题样式。
  static TextStyle pageSubtitle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 17,
      height: 1.4,
      color: body,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.1,
    );
  }

  /// 倒计时环内的大数字样式。
  static TextStyle countdownValue(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 56,
      height: 0.92,
      color: accent,
      fontWeight: FontWeight.w500,
      letterSpacing: -1.6,
    );
  }

  /// 倒计时环内的短标签样式。
  static TextStyle countdownLabel(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 18,
      height: 1.1,
      color: accent,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
    );
  }

  /// 页面分区标题样式。
  static TextStyle sectionTitle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 25,
      height: 1.08,
      color: ink,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.6,
    );
  }

  /// 大卡片标题样式。
  static TextStyle cardTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontFamily: serifFontFamily,
      fontSize: 21,
      height: 1.12,
      color: ink,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.4,
    );
  }

  /// 卡片正文样式。
  static TextStyle bodyText(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      height: 1.45,
      color: body,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.08,
    );
  }

  /// 统一卡片圆角。
  static BorderRadius get cardRadius => BorderRadius.circular(30);

  /// 统一大卡片阴影。
  static List<BoxShadow> get cardShadow => const [
    BoxShadow(color: Color(0x120C3340), blurRadius: 26, offset: Offset(0, 14)),
    BoxShadow(color: Color(0x08FFFFFF), blurRadius: 10, offset: Offset(0, 1)),
  ];
}
