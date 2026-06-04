// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhythm_rest_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _RhythmRestApi implements RhythmRestApi {
  _RhythmRestApi(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露统一 REST 客户端提供者，让后续 feature 只复用同一网络宿主。

@ProviderFor(rhythmRestApi)
const rhythmRestApiProvider = RhythmRestApiProvider._();

/// 暴露统一 REST 客户端提供者，让后续 feature 只复用同一网络宿主。

final class RhythmRestApiProvider
    extends $FunctionalProvider<RhythmRestApi, RhythmRestApi, RhythmRestApi>
    with $Provider<RhythmRestApi> {
  /// 暴露统一 REST 客户端提供者，让后续 feature 只复用同一网络宿主。
  const RhythmRestApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rhythmRestApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rhythmRestApiHash();

  @$internal
  @override
  $ProviderElement<RhythmRestApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RhythmRestApi create(Ref ref) {
    return rhythmRestApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RhythmRestApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RhythmRestApi>(value),
    );
  }
}

String _$rhythmRestApiHash() => r'b577d16042f8db20da02a028eec3da9b2bad2417';
