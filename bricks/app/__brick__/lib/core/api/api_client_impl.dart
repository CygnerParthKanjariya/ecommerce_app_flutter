import 'package:mason_bricks/core/api/api_client.dart';
import 'package:mason_bricks/core/api/apis.dart';
import 'package:mason_bricks/core/api/response.dart';

class ApiClientImpl extends ApiClient {
  @override
  Future<Response<T>> get<T>({
    required Apis api,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required T Function(dynamic json) parseResponse,
  }) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> post<T>({
    required Apis api,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    required T Function(dynamic json) parseResponse,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
