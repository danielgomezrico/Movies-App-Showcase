import 'package:flutter/material.dart';
import 'package:movie_flutter/api/api.dart';
import 'package:movie_flutter/common/database/database.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/common/custom_theme.dart';

Future<void> main() async {
  Api.setup(CommonModule.config().apiBaseUrl());
  await Database.initialize(CommonModule.storages());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = CommonModule.router();

    return MaterialApp(
      title: 'Movies App',
      theme: CustomTheme.light,
      navigatorKey: router.navigatorKey,
      initialRoute: router.initialRoute,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
