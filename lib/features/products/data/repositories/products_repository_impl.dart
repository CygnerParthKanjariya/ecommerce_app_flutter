import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/products.dart';
import 'package:ecommerce_app/features/products/domain/usecases/products_usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {

      final ProductsRemoteDataSource remoteDataSource;
      final NetworkInfo networkInfo;

      ProductsRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Products>>> getProducts(ProductParams params) async {
    return await remoteDataSource.getProducts(params);
  }

}