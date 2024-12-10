import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzoapp/models/user.dart';
import 'package:nzoapp/utils/Routes.dart';
import 'package:nzoapp/utils/user_preferences.dart';
import 'package:nzoapp/widgets/appbar_widget.dart';
import 'package:nzoapp/widgets/button_widget.dart';
import 'package:nzoapp/widgets/numbers_widget.dart';
import 'package:nzoapp/widgets/profile_widget.dart';
import 'package:provider/provider.dart';

import '../../controllers/AuthentificationCtrl.dart';
import '../../utils/StockageKeys.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GetStorage stockage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 10),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 10),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildSettingsButton(),
          buildPersonalInfoButton(),
          buildLogoutButton(),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        "${stockage.read(StockageKeys.userKey)['nom']} ${stockage.read(StockageKeys.userKey)['prenom']}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        "${stockage.read(StockageKeys.userKey)['email']}",
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );

  Widget buildSettingsButton() => ListTile(
    title: Text('Settings'),
    leading: Icon(Icons.settings),
    onTap: () {

    },
  );

  Widget buildPersonalInfoButton() => ListTile(
    title: Text('Personal Information'),
    leading: Icon(Icons.person),
    onTap: () {

    },
  );

  Widget buildLogoutButton() => ListTile(
    title: Text('Logout'),
    leading: Icon(Icons.logout, color: Colors.red),
    onTap: () {
      var auth = context.read<AuthentificationCtrl>();
      auth.logout({});
      stockage.erase();
      Navigator.pushNamed(context, Routes.logInScreenRoute);
    },
  );
}