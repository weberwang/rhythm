import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 描述当前应用对 Supabase 的启动结果，供同步链路决定是否进入本地优先模式。
class SupabaseBootstrapState {
  /// 创建 Supabase 启动状态。
  const SupabaseBootstrapState({
    required this.configured,
    required this.initialized,
    required this.syncEnabled,
    this.errorMessage,
  });

  /// 当前构建是否提供了 Supabase 所需的 URL 和公钥。
  final bool configured;

  /// 当前进程内是否已完成 `Supabase.initialize`。
  final bool initialized;

  /// 当前环境是否允许真正执行云端同步读写。
  final bool syncEnabled;

  /// 若启动失败，则记录可读错误摘要，便于展示层降级说明。
  final String? errorMessage;
}

/// 提供 Supabase 启动结果，默认回退到“未配置”的本地优先模式。
final supabaseBootstrapStateProvider = Provider<SupabaseBootstrapState>((ref) {
  return const SupabaseBootstrapState(
    configured: false,
    initialized: false,
    syncEnabled: false,
  );
});

/// 在应用启动阶段按环境变量初始化 Supabase；缺少配置时直接保持本地优先模式。
Future<SupabaseBootstrapState> initializeSupabaseBootstrap() async {
  const url = String.fromEnvironment('SUPABASE_URL');
  const publishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  const fallbackAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  const syncEnabledFlag = String.fromEnvironment('SUPABASE_SYNC_ENABLED');
  final key = publishableKey.isNotEmpty ? publishableKey : fallbackAnonKey;
  if (url.isEmpty || key.isEmpty) {
    return const SupabaseBootstrapState(
      configured: false,
      initialized: false,
      syncEnabled: false,
    );
  }

  try {
    await Supabase.initialize(
      url: url,
      anonKey: key,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
    return SupabaseBootstrapState(
      configured: true,
      initialized: true,
      syncEnabled: syncEnabledFlag.toLowerCase() == 'true',
    );
  } catch (error) {
    return SupabaseBootstrapState(
      configured: true,
      initialized: false,
      syncEnabled: false,
      errorMessage: error.toString(),
    );
  }
}
