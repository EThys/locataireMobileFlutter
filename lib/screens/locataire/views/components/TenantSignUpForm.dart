import 'package:flutter/material.dart';
import 'package:nzoapp/controllers/LocataireCtrl.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';
import '../../../../../utils/Routes.dart';

class TenantSignUpForm extends StatefulWidget {
  const TenantSignUpForm({super.key, required GlobalKey<FormState> formKey});

  @override
  State<TenantSignUpForm> createState() => _TenantSignUpFormState();
}

class _TenantSignUpFormState extends State<TenantSignUpForm> {
  Map<String, String> fieldErrors = {};
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ConfirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    Map<String, dynamic> userData = {
      "nom": nameController.text,
      "prenom": prenomController.text,
      "tel": phoneController.text,
      "role": "locataire",
      "email": emailController.text,
      "password": passwordController.text,
      "password_confirmation": passwordController.text,
    };

    var ctrl = context.read<LocataireCtrl>();
    print("Voici les donnees $userData");

    var res = await ctrl.createLocataire(userData);
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop();

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
                Text("Ajout locataire réussie !", style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        nameController.text="";
        prenomController.text="";
        emailController.text="";
        phoneController.text="";
        passwordController.text="";
        Navigator.of(context).pop();
      });
    } else {
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
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer votre nom';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Nom",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.drive_file_rename_outline),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: prenomController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer votre prénom';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Prénom",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.drive_file_rename_outline),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer votre email';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Adresse email",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.mail_rounded),
              ),
              errorText: fieldErrors['email'],
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer votre numéro de téléphone';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Numéro de téléphone",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
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
            child: Text("Ajouter locataire"),
          ),
        ],
      ),
    );
  }
}