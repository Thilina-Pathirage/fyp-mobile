import 'package:flutter/material.dart';
import 'package:fyp_mobile/screens/home_screen.dart';
import 'package:fyp_mobile/themes/colors.dart';

import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eudaimonia Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.primaryColor,
        ),
        textTheme: ThemeData().textTheme.apply(
              fontFamily: 'Poppins',
            ),
      ),
      initialRoute: '/login',
      onGenerateRoute: Routes.generateRoute,
    );

  }
}
