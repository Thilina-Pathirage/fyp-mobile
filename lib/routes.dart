import 'package:flutter/material.dart';
import 'package:fyp_mobile/screens/complaints_screen.dart';
import 'package:fyp_mobile/screens/home_screen.dart';
import 'package:fyp_mobile/screens/leaves_screen.dart';
import 'package:fyp_mobile/screens/login_screen.dart';
import 'package:fyp_mobile/screens/survey_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/leaves':
        return MaterialPageRoute(builder: (_) => const LeavesScreen());
      case '/complaints':
        return MaterialPageRoute(builder: (_) => const ComplaintsScreen());
      case '/survey':
        return MaterialPageRoute(builder: (_) => const SurveyScreen());
      case '/loading':
        return MaterialPageRoute(builder: (_) => const SurveyScreen());

      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
