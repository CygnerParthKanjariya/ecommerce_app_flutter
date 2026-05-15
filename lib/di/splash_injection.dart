import '../features/splash/presentation/splash/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> splashInjection(GetIt sl) async {
  // Page - Splash
  // Bloc
  sl.registerFactory(() => SplashBloc(checkSessionUseCase: sl()));
}