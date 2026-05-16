import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/products.dart';
import '../repositories/products_repository.dart';

class ProductsUseCase implements UseCase<List<Products>, ProductParams> {
  final ProductsRepository repository;

   const ProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Products>>> call(ProductParams params) async {
    return await repository.getProducts(params);
  }
}

class ProductParams extends Equatable {
  final String endpoint;

  const ProductParams({required this.endpoint});

  @override
  List<Object> get props => [endpoint];
}
