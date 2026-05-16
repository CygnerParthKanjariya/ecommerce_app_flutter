import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/categories.dart';
import '../entities/dashboard.dart';
import '../repositories/dashboard_repository.dart';

class GetCategoriesUseCase implements UseCase<List<Category>, NoParams> {
  final DashboardRepository repository;

   const GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
   return await repository.getCategories(params);
  }
}