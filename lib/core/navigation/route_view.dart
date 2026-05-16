import '../../features/products/presentation/products/screen/products_page.dart';
import '../../features/dashboard/presentation/dashboard/screen/dashboard_page.dart';
import '../../features/auth/presentation/register/screen/register_page.dart';
import '../../features/auth/presentation/login/screen/login_page.dart';
import '../../features/splash/presentation/splash/screen/splash_page.dart';
import 'routes.dart';
import 'package:flutter/material.dart';

extension RouteView on Routes {
  MaterialPageRoute route(RouteSettings settings) {
    Widget page;
    switch (this) {
      case Routes.splash:
        page = const SplashPage();
        break;
    
        case Routes.login:
            page = const LoginPage();
            break;
        

        case Routes.register:
            page = const RegisterPage();
            break;
        

        case Routes.dashboard:
            page = const DashboardPage();
            break;
        

        case Routes.products:
            page = const ProductsPage();
            break;
        
}
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }
}
