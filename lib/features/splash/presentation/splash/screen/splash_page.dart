import 'package:ecommerce_app/core/navigation/goto.dart';
import 'package:ecommerce_app/core/navigation/routes.dart';
import 'package:flutter/material.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      context.pushAndRemoveUntil(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This is Splash Screen",
          style: TextStyle(fontSize: 25, fontWeight: .bold, color: Colors.redAccent),
        ),
      ),
    );
  }
}
