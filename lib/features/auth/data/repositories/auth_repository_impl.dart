import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {

      final AuthRemoteDataSource remoteDataSource;
      final NetworkInfo networkInfo;

      AuthRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

}