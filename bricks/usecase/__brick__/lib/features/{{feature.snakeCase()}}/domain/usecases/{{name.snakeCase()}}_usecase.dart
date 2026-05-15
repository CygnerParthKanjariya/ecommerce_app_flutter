import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/{{page.snakeCase()}}.dart';
import '../repositories/{{feature.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}UseCase implements UseCase<{{page.pascalCase()}}, Params> {
  final {{feature.pascalCase()}}Repository repository;

   const {{name.pascalCase()}}UseCase(this.repository);

  @override
  Future<Either<Failure, {{page.pascalCase()}}>> call(Params params) async {
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
