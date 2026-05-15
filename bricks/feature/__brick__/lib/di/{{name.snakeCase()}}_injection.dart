import '../features/{{name.snakeCase()}}/presentation/{{page.snakeCase()}}/bloc/{{page.snakeCase()}}_bloc.dart';
import '../features/{{name.snakeCase()}}/domain/usecases/{{page.snakeCase()}}_usecase.dart';
import '../features/{{name.snakeCase()}}/data/datasources/{{name.snakeCase()}}_remote_data_source.dart';
import '../features/{{name.snakeCase()}}/data/repositories/{{name.snakeCase()}}_repository_impl.dart';
import '../features/{{name.snakeCase()}}/domain/repositories/{{name.snakeCase()}}_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> {{name.camelCase()}}Injection(GetIt sl) async {

  // Features - {{name.pascalCase()}}
  // Repository
  sl.registerLazySingleton<{{name.pascalCase()}}Repository>(
        () => {{name.pascalCase()}}RepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<{{name.pascalCase()}}RemoteDataSource>(
        () => {{name.pascalCase()}}RemoteDataSourceImpl(client: sl()),
  );

  // Page - {{page.pascalCase()}}
  // Bloc
  sl.registerFactory(() => {{page.pascalCase()}}Bloc(usecase: sl()));
  // Use cases
  sl.registerLazySingleton(() => {{page.pascalCase()}}UseCase(sl()));
}