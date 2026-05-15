import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/splash.dart';
import '../repositories/splash_repository.dart';

class SplashUseCase implements UseCase<Splash, Params> {
  final SplashRepository repository;

   const SplashUseCase(this.repository);

  @override
  Future<Either<Failure, Splash>> call(Params params) async {
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
