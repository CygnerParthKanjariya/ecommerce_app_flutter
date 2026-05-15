import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await localDataSource.login(email, password);
      await localDataSource.cacheSession(userModel);
      return Right(userModel);
    } on ServerException {
      return const Left(AuthFailure('Invalid email or password'));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(String name, String email, String password) async {
    try {
      final userModel = await localDataSource.register(name, email, password);
      await localDataSource.cacheSession(userModel);
      return Right(userModel);
    } on ServerException {
      return const Left(AuthFailure('Email already exists'));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> checkSession() async {
    try {
      final userModel = await localDataSource.getCachedSession();
      return Right(userModel);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearSession();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}