import '../features/products/presentation/products/bloc/products_bloc.dart';
import '../features/products/domain/usecases/products_usecase.dart';
import '../features/products/data/datasources/products_remote_data_source.dart';
import '../features/products/data/repositories/products_repository_impl.dart';
import '../features/products/domain/repositories/products_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> productsInjection(GetIt sl) async {

  // Features - Products
  // Repository
  sl.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
        () => ProductsRemoteDataSourceImpl(client: sl()),
  );

  // Page - Products
  // Bloc
  sl.registerFactory(() => ProductsBloc(usecase: sl()));
  // Use cases
  sl.registerLazySingleton(() => ProductsUseCase(sl()));
}