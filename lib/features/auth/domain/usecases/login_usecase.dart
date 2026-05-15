import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<Login, Params> {
  final AuthRepository repository;

   const LoginUseCase(this.repository);

  @override
  Future<Either<Failure, Login>> call(Params params) async {
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
