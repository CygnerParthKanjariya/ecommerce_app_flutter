import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';

abstract class DashboardRemoteDataSource {

}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
    final ApiClient client;


   DashboardRemoteDataSourceImpl({
      required this.client
    });

}