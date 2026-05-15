import 'package:flutter/material.dart';
import '../../../../../core/navigation/goto.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../di/injection_container.dart';
import '../../../../auth/domain/usecases/logout_usecase.dart';
import '../../../../../core/usecases/usecase.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () async {
              await sl<LogoutUseCase>().call(NoParams());
              if (context.mounted) {
                context.pushAndRemoveUntil(Routes.login);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(child: Text("Dashboard")),
    );
  }
}
