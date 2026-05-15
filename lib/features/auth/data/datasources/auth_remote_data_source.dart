import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';

abstract class AuthRemoteDataSource {

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
    final ApiClient client;


   AuthRemoteDataSourceImpl({
      required this.client
    });

}