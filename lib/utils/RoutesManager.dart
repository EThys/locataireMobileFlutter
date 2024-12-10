import 'package:flutter/material.dart';
import 'package:nzoapp/screens/auth/views/login_screen.dart';
import 'package:nzoapp/screens/auth/views/signup_screen.dart';
import 'package:nzoapp/screens/locataire/views/components/TenantSignUpForm.dart';
import 'package:nzoapp/screens/locataire/views/tenantSignUp_screen.dart';
import 'package:nzoapp/screens/navBar/views/components/main_nav.dart';
import 'package:nzoapp/screens/onbording/views/onbording_screnn.dart';
import 'package:nzoapp/screens/propriety/Propriety_screen.dart';
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
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_)=>MainNav());
      case Routes.locataireRoute:
        return MaterialPageRoute(builder: (_)=>TenantSignUpScreen());
      case Routes.proprieteRoute:
        return MaterialPageRoute(builder: (_)=>ProprietyScreen());
      default:
        return MaterialPageRoute(builder: (_) =>OnBordingScreen());
    }
  }
}
