import 'package:flutter/material.dart';
import 'package:nzoapp/controllers/AuthentificationCtrl.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../../utils/Routes.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required GlobalKey<FormState> formKey});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override

  Map<String, String> fieldErrors = {};
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ConfirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
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
      "nom": nameController.text,
      "prenom": prenomController.text,
      "tel": phoneController.text,
      "role": "proprietaire",
      "email": emailController.text,
      "password": passwordController.text,
      "password_confirmation": passwordController.text,
    };
    var ctrl = context.read<AuthentificationCtrl>();
    print("Voici les donnees $userData");
    var res = await ctrl.register(userData);
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
                  "Inscription réussie !",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, Routes.logInScreenRoute);
      });
    } else {
      passwordController.clear();
      ConfirmPasswordController.clear();

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

      // String errorMessage = "Une erreur s'est produite";
      // if (res.isException == true) {
      //   errorMessage = res.errorMsg ?? errorMessage;
      // } else if (res.data != null && res.data?['errorList'] != null) {
      //   Map<String, dynamic> errorList = res.data?['errorList'];
      //   errorMessage = errorList.entries.map((e) => "${e.key}: ${e.value.join(', ')}").join('\n');
      // } else if (res.data != null && res.data?['message'] != null) {
      //   errorMessage = res.data?['message'];
      // }
      //
      // showMsg(context, false, errorMessage);
    }
  }
  Widget build(BuildContext context) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre votre nom';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Nom",
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(Icons.drive_file_rename_outline),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: prenomController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre votre prenom';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Prenom",
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(Icons.drive_file_rename_outline),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre votre email';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Adresse email",
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(Icons.mail_rounded),
                ), errorText: fieldErrors['email'],
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre numéro de telephone';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Numéro de téléphone",
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre mot de passe';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Mot de passe",
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(Icons.password),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: ConfirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirmer le mot de passe';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Confirmer le mot de passe",
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(Icons.password),
                ), errorText: fieldErrors['password'],
              ),
            ),
            const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("S'inscrire"),
            ),
          ],
        ),
      );
    }
  }
