import 'package:ecommerce_app/core/api/response.dart';
import 'api_client.dart';
import 'apis.dart';

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
