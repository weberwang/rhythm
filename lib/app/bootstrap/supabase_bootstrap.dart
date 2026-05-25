import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 描述应用启动阶段对 Supabase 的初始化结果与同步身份状态。
class SupabaseBootstrapState {
  /// 创建 Supabase 启动状态。
  const SupabaseBootstrapState({
    required this.configured,
    required this.initialized,
    required this.syncEnabled,
    required this.signedIn,
    required this.isAnonymous,
    this.userId,
    this.errorMessage,
  });

  /// 当前环境是否提供了 Supabase 启动所需的 URL 与发布密钥。
  final bool configured;

  /// 当前进程内是否已完成 `Supabase.initialize`。
  final bool initialized;

  /// 当前环境是否允许执行远端同步读写。
  final bool syncEnabled;

  /// 当前是否已持有可用的云端身份。
  final bool signedIn;

  /// 当前云端身份是否为匿名身份。
  final bool isAnonymous;

  /// 当前云端身份对应的用户 ID；未登录时为空。
  final String? userId;

  /// 启动失败时的错误摘要，供展示层说明降级原因。
  final String? errorMessage;
}

/// 提供 Supabase 启动结果，默认回退到未配置的本地优先模式。
final supabaseBootstrapStateProvider = Provider<SupabaseBootstrapState>((ref) {
  return const SupabaseBootstrapState(
    configured: false,
    initialized: false,
    syncEnabled: false,
    signedIn: false,
    isAnonymous: false,
  );
});

/// 抽象 Supabase 鉴权最小能力，便于测试验证匿名登录决策。
abstract class SupabaseBootstrapAuth {
  /// 当前是否已持有会话。
  bool get hasSession;

  /// 当前是否已拥有可用身份。
  bool get isSignedIn;

  /// 当前身份是否为匿名身份。
  bool get isAnonymous;

  /// 当前身份的用户 ID；未登录时为空。
  String? get userId;

  /// 在无会话且允许同步时补建匿名会话。
  Future<void> signInAnonymously();
}

/// 适配 Supabase 官方鉴权客户端到启动流程使用的最小接口。
class SupabaseClientBootstrapAuth implements SupabaseBootstrapAuth {
  /// 创建基于官方鉴权客户端的启动鉴权适配器。
  SupabaseClientBootstrapAuth({required GoTrueClient auth}) : _auth = auth;

  final GoTrueClient _auth;

  @override
  bool get hasSession => _auth.currentSession != null;

  @override
  bool get isSignedIn => _auth.currentSession != null || _auth.currentUser != null;

  @override
  bool get isAnonymous => _auth.currentUser?.isAnonymous ?? false;

  @override
  String? get userId => _auth.currentUser?.id;

  @override
  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }
}

/// 在应用启动阶段按环境变量初始化 Supabase；缺少配置时保持本地优先模式。
Future<SupabaseBootstrapState> initializeSupabaseBootstrap() async {
  const url = String.fromEnvironment('SUPABASE_URL');
  const publishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  const syncEnabledFlag = String.fromEnvironment('SUPABASE_SYNC_ENABLED');

  return _initializeSupabaseBootstrapInternal(
    url: url,
    publishableKey: publishableKey,
    syncEnabled: syncEnabledFlag.toLowerCase() == 'true',
    initializeClient: () async {
      // 当前锁定的 supabase_flutter 版本仍使用 anonKey 参数，这里仅复用发布密钥的值，不再保留旧环境变量回退。
      await Supabase.initialize(
        url: url,
        anonKey: publishableKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );
      return SupabaseClientBootstrapAuth(auth: Supabase.instance.client.auth);
    },
  );
}

/// 提供测试使用的启动初始化入口，便于注入假鉴权对象验证匿名登录流程。
Future<SupabaseBootstrapState> initializeSupabaseBootstrapForTest({
  required String url,
  required String publishableKey,
  required bool syncEnabled,
  required SupabaseBootstrapAuth auth,
}) {
  return _initializeSupabaseBootstrapInternal(
    url: url,
    publishableKey: publishableKey,
    syncEnabled: syncEnabled,
    initializeClient: () async => auth,
  );
}

/// 统一封装启动时的配置判断、SDK 初始化与匿名身份补建逻辑。
Future<SupabaseBootstrapState> _initializeSupabaseBootstrapInternal({
  required String url,
  required String publishableKey,
  required bool syncEnabled,
  required Future<SupabaseBootstrapAuth> Function() initializeClient,
}) async {
  if (url.isEmpty || publishableKey.isEmpty) {
    return const SupabaseBootstrapState(
      configured: false,
      initialized: false,
      syncEnabled: false,
      signedIn: false,
      isAnonymous: false,
    );
  }

  try {
    final auth = await initializeClient();
    // 只有真正启用同步时才补建匿名身份，避免本地优先模式也触发云端会话。
    if (syncEnabled && !auth.hasSession) {
      await auth.signInAnonymously();
    }

    return SupabaseBootstrapState(
      configured: true,
      initialized: true,
      syncEnabled: syncEnabled,
      signedIn: auth.isSignedIn,
      isAnonymous: auth.isAnonymous,
      userId: auth.userId,
    );
  } catch (error) {
    return SupabaseBootstrapState(
      configured: true,
      initialized: false,
      syncEnabled: false,
      signedIn: false,
      isAnonymous: false,
      errorMessage: error.toString(),
    );
  }
}
