
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/categories.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<Category>>> getCategories(params);
}