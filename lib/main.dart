import 'package:dashboard/routes/app_routes.dart';
import 'package:dashboard/themes/light.dart';
import 'package:dashboard/utils/expense_provider.dart';
import 'package:dashboard/utils/provider_state_management.dart';
import 'package:dashboard/utils/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProviderStateManagement(),),
          ChangeNotifierProvider(create: (context) => TaskProvider(),),
          ChangeNotifierProvider(create: (context) => ExpenseProvider(),)
        ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dashboard App',
      darkTheme: ThemeData.dark(),
      theme: lightTheme,
      routerConfig: AppRoutes().appRoute,
    );
  }
}
