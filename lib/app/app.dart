import 'package:flutter/material.dart';
import 'package:news_app/app/router.dart';
import 'package:news_app/app/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'News App',
      routerConfig: router,

      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
