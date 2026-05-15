import '../features/auth/presentation/login/bloc/login_bloc.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/data/datasources/auth_local_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/check_session_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import 'package:get_it/get_it.dart';
import '../features/auth/presentation/register/bloc/register_bloc.dart';
import '../features/auth/domain/usecases/register_usecase.dart';
import '../core/database/database_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> authInjection(GetIt sl) async {
  // Core / External dependencies needed for Auth
  if (!sl.isRegistered<DatabaseHelper>()) {
    sl.registerLazySingleton(() => DatabaseHelper.instance);
  }
  if (!sl.isRegistered<FlutterSecureStorage>()) {
    sl.registerLazySingleton(() => const FlutterSecureStorage());
  }

  // Features - Auth
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      databaseHelper: sl(),
      secureStorage: sl(),
    ),
  );

  // Page - Login
  // Bloc
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Page - Register
  // Bloc
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Additional Use Cases
  sl.registerLazySingleton(() => CheckSessionUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
}