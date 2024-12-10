import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzoapp/controllers/LocataireCtrl.dart';
import 'package:nzoapp/controllers/ProprieteCtrl.dart';
import '../controllers/AuthentificationCtrl.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/Routes.dart';
import '../utils/RoutesManager.dart';
import '../utils/StockageKeys.dart';

class MonApplication extends StatelessWidget {
  var _stockage = GetStorage();

  @override
  Widget build(BuildContext context) {
    bool isFirstLaunch = _stockage.read(StockageKeys.firstLaunchKey) ?? true;
    var token = _stockage.read(StockageKeys.tokenKey);

    if (isFirstLaunch) {
      _stockage.write(StockageKeys.firstLaunchKey, false);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthentificationCtrl(stockage: _stockage)),
        ChangeNotifierProvider(create: (_) => LocataireCtrl(stockage: _stockage)),
        ChangeNotifierProvider(create: (_) => ProprieteCtrl(stockage: _stockage)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.route,
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        initialRoute: isFirstLaunch ? Routes.onbordingScreenRoute : (token != null ? Routes.homeRoute : Routes.logInScreenRoute),
      ),
    );
  }
}