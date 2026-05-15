import 'dart:convert';

class Response<T> {
  final int status;
  final T? data;
  final String message;
  final Map? error;

  const Response({
    required this.status,
    required this.data,
    required this.message,
    required this.error,
  });

  factory Response.fromJson(
    Map<String, dynamic> json,
    T? Function(dynamic json) parseResponse,
  ) {
    return Response(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: json['data']==null?null:parseResponse(json['data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "status": status,
      "message": message,
      "error": error,
      "data": jsonEncode(data),
    };
  }
}
