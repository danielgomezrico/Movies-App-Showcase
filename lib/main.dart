import 'package:flutter/material.dart';
import 'package:movie_flutter/common/di/modules.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = CommonModule.router();

    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      navigatorKey: router.navigatorKey,
      initialRoute: router.initialRoute,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
