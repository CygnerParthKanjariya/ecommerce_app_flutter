import '../features/auth/presentation/login/bloc/login_bloc.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import '../features/auth/presentation/register/bloc/register_bloc.dart';
import '../features/auth/domain/usecases/register_usecase.dart';


Future<void> authInjection(GetIt sl) async {

  // Features - Auth
  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(), // Add NetworkInfo dependency
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // Page - Login
  // Bloc
  sl.registerFactory(() => LoginBloc(usecase: sl()));
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));


    // Page - Register
    // Bloc
    sl.registerFactory(() => RegisterBloc(usecase: sl()));
    // Use cases
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    }