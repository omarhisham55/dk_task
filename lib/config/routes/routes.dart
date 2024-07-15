import 'package:dakahlia_task/core/utils/strings.dart';
import 'package:dakahlia_task/features/authentication/presentation/pages/login_page.dart';
import 'package:dakahlia_task/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String auth = '/';
  static const String homePage = '/home';
  Routes._();

  factory Routes() => Routes._();
  Map<String, Route Function(RouteSettings settings)> get allRoutes => {
        auth: (settings) => MaterialPageRoute(
              builder: (context) => const LoginPage(),
              settings: settings,
            ),
        homePage: (settings) => MaterialPageRoute(
              builder: (context) => const HomePage(),
              settings: settings,
            ),
      };

  Route undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            AppStrings.undefinedRoute,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}

class OnGenerateRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    final route = Routes().allRoutes[settings.name];
    if (route != null) return route(settings);
    return Routes().undefinedRoute();
  }
}
