import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../../controllers/AuthentificationCtrl.dart';
import '../../../../utils/Routes.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _obscureText = true;
  final TextEditingController identifiantController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, String> fieldErrors = {};

  Future<void> _submitForm() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState?.validate() ?? false) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    Map<String, dynamic> userData = {
      "identifiant": identifiantController.text,
      "password": passwordController.text,
    };
    var ctrl = context.read<AuthentificationCtrl>();
    print("Voici les donnees $userData");
    var res = await ctrl.login(userData);
    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pop();

    print("MAMADOUUUUU ${res.success}");
    print("MAMADOUUUUU ${res.success.runtimeType}");

    if (res.success == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: purpleColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.thumb_up, color: Colors.white, size: 60),
                SizedBox(height: 20),
                Text(
                  "Connexion réussie !",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, Routes.homeRoute);
      });
    } else {
      passwordController.clear();
      setState(() {
        fieldErrors.clear();
        if (res.data != null && res.data?['errorList'] != null) {
          Map<String, dynamic> errorList = res.data?['errorList'];
          errorList.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              fieldErrors[key] = value.first.toString();
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (email) {
              // Email
            },
            controller: identifiantController,
            validator: emaildValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Adresse Email",
              prefixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.mail_rounded),
              ),errorText: fieldErrors['identifiant'],
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            onSaved: (pass) {
              // Password
            },
            validator: passwordValidator.call,
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: "Mot de passe",
              prefixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.password),
              ),errorText: fieldErrors['password'],
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Se connecter"),
          ),
        ],
      ),
    );
  }
}