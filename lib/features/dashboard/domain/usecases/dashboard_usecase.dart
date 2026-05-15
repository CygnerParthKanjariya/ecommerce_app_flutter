import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dashboard.dart';
import '../repositories/dashboard_repository.dart';

class DashboardUseCase implements UseCase<Dashboard, Params> {
  final DashboardRepository repository;

   const DashboardUseCase(this.repository);

  @override
  Future<Either<Failure, Dashboard>> call(Params params) async {
    // TODO: implement call
     throw UnimplementedError();
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
