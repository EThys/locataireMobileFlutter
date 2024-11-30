import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzoapp/route/route_constants.dart';
import 'package:nzoapp/route/router.dart' as router;
import 'package:nzoapp/theme/app_theme.dart';

import 'apps/MonApplication.dart';


void main() async {
  await GetStorage.init();
 runApp(MonApplication());
}


// Thanks for using our template. You are using the free version of the template.
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Shop Template by The Flutter Way',
//       theme: AppTheme.lightTheme(context),
//       // Dark theme is inclided in the Full template
//       themeMode: ThemeMode.light,
//       onGenerateRoute: router.generateRoute,
//       initialRoute: onbordingScreenRoute,
//     );
//   }
// }
