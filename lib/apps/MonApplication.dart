import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/AuthentificationCtrl.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/Routes.dart';
import '../utils/RoutesManager.dart';
import '../utils/StockageKeys.dart';
//import 'package:alice/alice.dart';
//Alice alice = Alice( showNotification: true);

class MonApplication extends StatelessWidget {
  var _stockage = GetStorage();
  @override
  Widget build(BuildContext context) {

    var token=_stockage.read(StockageKeys.tokenKey);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthentificationCtrl(stockage:_stockage)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.route,
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        initialRoute: Routes.onbordingScreenRoute,
      ),
    );
  }
}
