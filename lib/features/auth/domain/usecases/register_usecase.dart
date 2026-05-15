import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/register.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<Register, Params> {
  final AuthRepository repository;

   const RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, Register>> call(Params params) async {
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
