import '../../../../core/network/network_info.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_remote_data_source.dart';

class SplashRepositoryImpl implements SplashRepository {

      final SplashRemoteDataSource remoteDataSource;
      final NetworkInfo networkInfo;

      SplashRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

}