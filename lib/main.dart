import 'package:dashboard/routes/app_routes.dart';
import 'package:dashboard/screens/home_screen.dart';
import 'package:dashboard/themes/light.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
