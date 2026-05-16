import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/products.dart';
import '../usecases/products_usecase.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Products>>> getProducts(ProductParams params);
}