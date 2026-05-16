import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce_app/core/api/response.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../network/network_info.dart';
import 'api_client.dart';
import 'apis.dart';

class ApiClientImpl extends ApiClient {
  late final dio.Dio _dio;

  ApiClientImpl() {
    final options = dio.BaseOptions(
      connectTimeout: const Duration(minutes: 50),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
      },
    );

    _dio = dio.Dio(options);

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }
  }

  Response<T> _createNetworkErrorResponse<T>(String message) {
    return Response(status: 0, data: null, message: message, error: null);
  }

  @override
  Future<Response<T>> get<T>({
    required Apis api,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required T Function(dynamic json) parseResponse,
  }) async {
    final isConnected = await GetIt.I.get<NetworkInfo>().isConnected;
    if (!isConnected) {
      return _createNetworkErrorResponse("No internet connection. Please check your network.");
    }
    try {
      final response = await _dio.get(
        api.url,
        queryParameters: queryParameters,
        options: dio.Options(headers: headers),
      );
      final parsedData = parseResponse(
        response.data.runtimeType == String
            ? jsonDecode(response.data)
            : response.data,
      );

      return Response<T>(
        status: response.statusCode ?? 0,
        data: parsedData,
        message: response.statusMessage ?? "",
        error: null,
      );
    }on dio.DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;

        return Response.fromJson(
          data is String ? jsonDecode(data) : data,
          parseResponse,
        );
      } else {
        return Response(
          status: 0,
          data: null,
          message: e.message ?? "Unknown error",
          error: null,
        );
      }
    }
  }

  @override
  Future<Response<T>> post<T>({
    required Apis api,
    Map<String, dynamic>? params,
    Map<String, String>? files,
    Map<String, String>? headers,
    required T Function(dynamic json) parseResponse,
  }) async {
    final isConnected = await GetIt.I.get<NetworkInfo>().isConnected;
    if (!isConnected) {
      return _createNetworkErrorResponse("No internet connection. Please check your network.");
    }
    try {
      Map<String, dynamic> formMap = {};
      if (params != null) {
        formMap.addAll(params);
      }
      if (files != null) {
        for (var entry in files.entries) {
          formMap[entry.key] = await dio.MultipartFile.fromFile(
            entry.value,
            filename: entry.value.split('/').last,
          );
        }
      }
      final formData = dio.FormData.fromMap(formMap);

      final response = await _dio.post(
        api.url,
        data: formData,
        options: dio.Options(headers: headers),
      );
      return Response.fromJson(
        response.data.runtimeType == String ? jsonDecode(response.data) : response.data,
        parseResponse,
      );
    }on dio.DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;

        return Response.fromJson(
          data is String ? jsonDecode(data) : data,
          parseResponse,
        );
      } else {
        return Response(
          status: 0,
          data: null,
          message: e.message ?? "Unknown error",
          error: null,
        );
      }
    }
  }
}
