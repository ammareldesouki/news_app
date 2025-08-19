
import 'package:flutter/material.dart';
import 'package:news_app/core/route/route_name.dart';
import 'package:news_app/features/home/presentation/pages/home_screen.dart';
import 'package:news_app/features/splash/presentation/pages/splash.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );



      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );



      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
