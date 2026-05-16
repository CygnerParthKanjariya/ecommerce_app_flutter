import 'package:ecommerce_app/core/storage/session/sesssion.dart';
import 'package:flutter/material.dart';
import '../../../../../core/navigation/goto.dart';
import '../../../../../core/navigation/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Future.delayed(Duration(seconds: 3), () async {
      if (await SessionManager.isLoggedIn()) {
        context.pushAndRemoveUntil(Routes.dashboard);
      } else {
        context.pushAndRemoveUntil(Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("assets/splash_image.png")));
  }
}
