import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/data/models/products_model.dart';
import 'package:ecommerce_app/features/products/domain/usecases/products_usecase.dart';

import '../../../../core/api/apis.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/products.dart';

abstract class ProductsRemoteDataSource {
  Future<Either<Failure, List<Products>>> getProducts(ProductParams params);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiClient client;

  ProductsRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, List<Products>>> getProducts(ProductParams params) async {
    // try {
      final response = await client.get<List<Products>>(
        api: (Apis.categories.productsByCategory(params.endpoint)) as Apis,
        parseResponse: (json) {
          if (json == null) return <Products>[];

          final list = json as List;
          return list.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>)).toList();
        },
      );

      if (response.status == 200) {
        return right(response.data!);
      } else {
        return left(ServerFailure(message: 'Something went wrong'));
      }
    // } catch (e) {
    //   return left(ServerFailure(message: e.toString()));
    // }
  }
}
