import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../domain/entities/onboarding_account_connection_result.dart';
import '../../domain/gateways/onboarding_account_gateway.dart';

/// 用平台登录 SDK 承接 onboarding 账号入口，并把异常折叠为稳定业务结果。
class DeviceOnboardingAccountGateway implements OnboardingAccountGateway {
  /// 创建账号适配器。
  DeviceOnboardingAccountGateway({GoogleSignIn? googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;

  @override
  Future<OnboardingAccountConnectionResult> signIn(
    OnboardingAccountProvider provider,
  ) {
    return switch (provider) {
      OnboardingAccountProvider.apple => _signInWithApple(),
      OnboardingAccountProvider.google => _signInWithGoogle(),
    };
  }

  /// 在 Apple 平台执行真实登录；对不支持或缺少 Web 参数的平台直接给出降级结果。
  Future<OnboardingAccountConnectionResult> _signInWithApple() async {
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.iOS &&
            defaultTargetPlatform != TargetPlatform.macOS)) {
      return const OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.apple,
        status: OnboardingAccountConnectionStatus.unavailable,
      );
    }

    final available = await SignInWithApple.isAvailable();
    if (!available) {
      return const OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.apple,
        status: OnboardingAccountConnectionStatus.unavailable,
      );
    }

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final displayName = [
        credential.givenName,
        credential.familyName,
      ].whereType<String>().where((value) => value.isNotEmpty).join(' ').trim();

      return OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.apple,
        status: OnboardingAccountConnectionStatus.success,
        displayName: displayName.isEmpty ? null : displayName,
        email: credential.email,
      );
    } on SignInWithAppleAuthorizationException catch (error) {
      final status = switch (error.code) {
        AuthorizationErrorCode.canceled =>
          OnboardingAccountConnectionStatus.cancelled,
        AuthorizationErrorCode.notInteractive ||
        AuthorizationErrorCode.failed ||
        AuthorizationErrorCode.invalidResponse ||
        AuthorizationErrorCode.notHandled ||
        AuthorizationErrorCode.credentialImport ||
        AuthorizationErrorCode.credentialExport ||
        AuthorizationErrorCode.matchedExcludedCredential ||
        AuthorizationErrorCode.unknown =>
          OnboardingAccountConnectionStatus.failed,
      };

      return OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.apple,
        status: status,
      );
    } on SignInWithAppleNotSupportedException {
      return const OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.apple,
        status: OnboardingAccountConnectionStatus.unavailable,
      );
    } catch (_) {
      return const OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.apple,
        status: OnboardingAccountConnectionStatus.failed,
      );
    }
  }

  /// 在支持的平台执行 Google 交互式认证；失败与取消统一映射成可消费结果。
  Future<OnboardingAccountConnectionResult> _signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      if (!_googleSignIn.supportsAuthenticate()) {
        return const OnboardingAccountConnectionResult(
          provider: OnboardingAccountProvider.google,
          status: OnboardingAccountConnectionStatus.unavailable,
        );
      }

      final account = await _googleSignIn.authenticate();
      return OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.google,
        status: OnboardingAccountConnectionStatus.success,
        displayName: account.displayName,
        email: account.email,
      );
    } on UnsupportedError {
      return const OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.google,
        status: OnboardingAccountConnectionStatus.unavailable,
      );
    } on GoogleSignInException catch (error) {
      final status = switch (error.code) {
        GoogleSignInExceptionCode.canceled ||
        GoogleSignInExceptionCode.interrupted =>
          OnboardingAccountConnectionStatus.cancelled,
        GoogleSignInExceptionCode.uiUnavailable =>
          OnboardingAccountConnectionStatus.unavailable,
        GoogleSignInExceptionCode.providerConfigurationError ||
        GoogleSignInExceptionCode.clientConfigurationError ||
        GoogleSignInExceptionCode.unknownError =>
          OnboardingAccountConnectionStatus.failed,
        _ => OnboardingAccountConnectionStatus.failed,
      };

      return OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.google,
        status: status,
      );
    } catch (_) {
      return const OnboardingAccountConnectionResult(
        provider: OnboardingAccountProvider.google,
        status: OnboardingAccountConnectionStatus.failed,
      );
    }
  }
}
