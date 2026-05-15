import '../features/splash/presentation/splash/bloc/splash_bloc.dart';
import '../features/splash/domain/usecases/splash_usecase.dart';
import '../features/splash/data/datasources/splash_remote_data_source.dart';
import '../features/splash/data/repositories/splash_repository_impl.dart';
import '../features/splash/domain/repositories/splash_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> splashInjection(GetIt sl) async {

  // Features - Splash
  // Repository
  sl.registerLazySingleton<SplashRepository>(
        () => SplashRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<SplashRemoteDataSource>(
        () => SplashRemoteDataSourceImpl(client: sl()),
  );

  // Page - Splash
  // Bloc
  sl.registerFactory(() => SplashBloc(usecase: sl()));
  // Use cases
  sl.registerLazySingleton(() => SplashUseCase(sl()));
}