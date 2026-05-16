import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/splash.dart';
import '../repositories/splash_repository.dart';

class SplashUseCase implements UseCase<Splash, NoParams> {
  final SplashRepository repository;

   const SplashUseCase(this.repository);

  @override
  Future<Either<Failure, Splash>> call(NoParams params) async {
    // TODO: implement call
     throw UnimplementedError();
  }
}
