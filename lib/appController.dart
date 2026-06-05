import 'package:flutter/material.dart';
import 'package:modulo_a2_v1/pages/homePage.dart';
import 'package:modulo_a2_v1/pages/loginPage.dart';
import 'package:modulo_a2_v1/pages/questPage.dart';
import 'package:modulo_a2_v1/pages/sobrePage.dart';
import 'package:modulo_a2_v1/pages/splashPage.dart';
import 'package:modulo_a2_v1/services/apiService.dart';

class AppController extends StatelessWidget {
  final ApiService api;

  const AppController({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/splash') {
          return MaterialPageRoute(
            builder: (_) => SplashScreen(api: api),
          );
        }
        if (settings.name == '/login') {
          return MaterialPageRoute(
            builder: (_) => LoginPage(api: api),
          );
        }
        if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (_) => HomePage(api: api),
          );
        }
        if (settings.name == '/sobre') {
          return MaterialPageRoute(builder: (_) => SobrePage());
        }
        if (settings.name == '/quest') {
          return MaterialPageRoute(builder: (_) => QuestPage(api: api,));
        }
        return null;
      },
      initialRoute: '/splash',
    );
  }
}
