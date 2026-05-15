import 'package:mason_bricks/core/api/response.dart';

import 'apis.dart';

abstract class ApiClient {
  Future<Response<T>> get<T>({
    required Apis api,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required T Function(dynamic json) parseResponse,
  });


  Future<Response<T>> post<T>({
    required Apis api,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    required T Function(dynamic json) parseResponse,
  });
}
