import 'package:flutter/material.dart';
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
      title: '{{name.titleCase()}}',
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

