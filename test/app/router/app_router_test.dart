import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/router/app_router.dart';

void main() {
  group('AppRouter 页面过渡', () {
    test('一级 tab 页面使用无过渡页面', () {
      final page = buildTabRootPage(
        key: const ValueKey<String>('today'),
        child: const SizedBox(),
      );

      expect(page, isA<NoTransitionPage<void>>());
    });

    test('二级页面使用 iOS 风格页面', () {
      final page = buildSecondaryPage(
        key: const ValueKey<String>('profile-data-access'),
        child: const SizedBox(),
      );

      expect(page, isA<CupertinoPage<void>>());
    });
  });
}
