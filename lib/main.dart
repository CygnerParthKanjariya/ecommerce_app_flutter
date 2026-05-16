import 'package:flutter/material.dart';
import 'features/products/presentation/products/bloc/products_bloc.dart';
import 'features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'features/auth/presentation/register/bloc/register_bloc.dart';
import 'features/auth/presentation/login/bloc/login_bloc.dart';
import 'features/splash/presentation/splash/bloc/splash_bloc.dart';
import 'core/util/theme.dart';
import 'di/injection_container.dart' as di;
import 'core/navigation/route_view.dart';
import 'core/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
      MultiBlocProvider(
        providers: [
        BlocProvider<ProductsBloc>(create: (context) => di.sl<ProductsBloc>(),),

        BlocProvider<DashboardBloc>(create: (context) => di.sl<DashboardBloc>(),),

        BlocProvider<RegisterBloc>(create: (context) => di.sl<RegisterBloc>(),),

        BlocProvider<LoginBloc>(create: (context) => di.sl<LoginBloc>(),),

        BlocProvider<SplashBloc>(create: (context) => di.sl<SplashBloc>(),),

          //here
        ],
        child: const MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: Routes.splash.path,
      onGenerateRoute: (settings) {
        return Routes.values
            .firstWhere((route) => route.path == settings.name)
            .route(settings);
      },
    );
  }
}

