import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {

      final DashboardRemoteDataSource remoteDataSource;
      final NetworkInfo networkInfo;

      DashboardRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

}