import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../core/api/api_client.dart';
import '../core/api/api_client_impl.dart';
import '../core/network/network_info.dart';

import 'splash_injection.dart';
import 'auth_injection.dart';
import 'dashboard_injection.dart';
final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
// Features - will call all feature injection methods
  await initFeatures();
}

// This method will dynamically call all feature injections
Future<void> initFeatures() async {
  final featureInitializers = {

    // Will be populated by Mason
    'splash': splashInjection,
  'auth': authInjection,
  'dashboard': dashboardInjection,
};

  // Call each feature's injection method
  for (final initialize in featureInitializers.values) {
    await initialize(sl);
  }
}