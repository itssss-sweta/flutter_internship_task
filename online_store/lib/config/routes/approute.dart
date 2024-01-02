import 'package:flutter/material.dart';
import 'package:online_store/config/routes/route.dart';
import 'package:online_store/features/detailpage.dart/presentation/ui/detailscreen.dart';
import 'package:online_store/features/homepage.dart/presentation/ui/categoryscreen.dart';
import 'package:online_store/features/homepage.dart/presentation/ui/homescreen.dart';

class AppRoute {
  Route? ongenerateRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        }
      //TODO:correction needed
      case Routes.categoryScreen:
        {
          return MaterialPageRoute(
            builder: (context) => CategoryScreen(category: argument as String),
          );
        }
      case Routes.detailScreen:
        {
          return MaterialPageRoute(
            builder: (context) => const DetailPage(),
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        }
    }
  }
}
