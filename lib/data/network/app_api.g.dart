part of 'app_api.dart';

class _AppServicesClient implements AppServicesClient {
  _AppServicesClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://mostafamohamed869.wiremockapi.cloud';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationResponse> login(email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<AuthenticationResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options, '/customers/login',
        queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
        final value = AuthenticationResponse.fromJson(_result.data!);
        return value;
  }
  
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
}