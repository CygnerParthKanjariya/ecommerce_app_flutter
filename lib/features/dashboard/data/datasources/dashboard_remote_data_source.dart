import 'dart:convert';
import 'package:dartz/dartz.dart';

import '../../../../core/api/apis.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/categories.dart';
import '../models/categories_model.dart';

abstract class DashboardRemoteDataSource {
  Future<Either<Failure, List<Category>>> getCategories(params);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient client;

  DashboardRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, List<Category>>> getCategories(params) async {
    try {
      final response = await client.get<List<Category>>(
        api: Apis.categories,
        parseResponse: (json) {
          if (json == null) return <Category>[];

          final list = json as List;
          return list.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();
        },
      );

      if (response.status == 200) {
        return right(response.data!);
      } else {
        return left(ServerFailure(message: 'Something went wrong'));
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
