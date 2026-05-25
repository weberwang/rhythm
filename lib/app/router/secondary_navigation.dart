import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// 统一封装二级页导航语义，避免误用 `go` 直接覆盖返回栈。
extension SecondaryNavigationContext on BuildContext {
  /// 二级详情页、设置页统一使用 push，保留来源页的返回路径。
  Future<T?> pushSecondary<T extends Object?>(String location) {
    return push<T>(location);
  }

  /// 二级页退出时优先返回来源页；若当前页是直达打开，则回退到兜底一级页。
  void popSecondaryOrGo(String fallbackLocation) {
    final router = GoRouter.of(this);
    if (router.canPop()) {
      pop();
      return;
    }
    go(fallbackLocation);
  }
}
