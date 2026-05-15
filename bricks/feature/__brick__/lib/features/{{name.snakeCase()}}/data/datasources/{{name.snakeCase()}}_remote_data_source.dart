import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';

abstract class {{name.pascalCase()}}RemoteDataSource {

}

class {{name.pascalCase()}}RemoteDataSourceImpl implements {{name.pascalCase()}}RemoteDataSource {
    final ApiClient client;


   {{name.pascalCase()}}RemoteDataSourceImpl({
      required this.client
    });

}