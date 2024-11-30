import 'package:flutter/material.dart';
import 'package:nzoapp/screens/auth/views/login_screen.dart';
import 'package:nzoapp/screens/auth/views/signup_screen.dart';
import 'package:nzoapp/screens/onbording/views/onbording_screnn.dart';
import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
      case Routes.onbordingScreenRoute:
        return MaterialPageRoute(builder: (_) => OnBordingScreen());
        case Routes.logInScreenRoute:
      return MaterialPageRoute(builder: (_)=>LoginScreen());
      case Routes.signUpScreenRoute:
        return MaterialPageRoute(builder: (_)=>SignUpScreen());
      default:
        return MaterialPageRoute(builder: (_) =>OnBordingScreen());
    }
  }
}
