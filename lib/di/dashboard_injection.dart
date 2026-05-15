import '../features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import '../features/dashboard/domain/usecases/dashboard_usecase.dart';
import '../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:get_it/get_it.dart';


Future<void> dashboardInjection(GetIt sl) async {

  // Features - Dashboard
  // Repository
  sl.registerLazySingleton<DashboardRepository>(
        () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
        () => DashboardRemoteDataSourceImpl(client: sl()),
  );

  // Page - Dashboard
  // Bloc
  sl.registerFactory(() => DashboardBloc(usecase: sl()));
  // Use cases
  sl.registerLazySingleton(() => DashboardUseCase(sl()));
}