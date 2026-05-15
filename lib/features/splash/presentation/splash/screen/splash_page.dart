import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/goto.dart';
import '../../../../../core/navigation/routes.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToLogin) {
          context.pushAndRemoveUntil(Routes.login);
        } else if (state is SplashNavigateToDashboard) {
          context.pushAndRemoveUntil(Routes.dashboard);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4F46E5), Color(0xff9333EA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 100,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
