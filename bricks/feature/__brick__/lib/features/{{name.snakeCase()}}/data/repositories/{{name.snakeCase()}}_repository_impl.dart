import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/{{name.snakeCase()}}_repository.dart';
import '../datasources/{{name.snakeCase()}}_remote_data_source.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {

      final {{name.pascalCase()}}RemoteDataSource remoteDataSource;
      final NetworkInfo networkInfo;

      {{name.pascalCase()}}RepositoryImpl({required this.remoteDataSource,required this.networkInfo});

}