import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nzoapp/screens/auth/views/components/sign_up_form.dart';
import 'package:nzoapp/route/route_constants.dart';
import 'package:nzoapp/screens/locataire/views/components/TenantSignUpForm.dart';

import '../../../constants.dart';

class TenantSignUpScreen extends StatefulWidget {
  const TenantSignUpScreen({super.key});

  @override
  State<TenantSignUpScreen> createState() => _TenantSignUpScreenState();
}

class _TenantSignUpScreenState extends State<TenantSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout Locataire"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/pexelsTwo.jpg",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "C'est parti !",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "euillez remplir les informations suivantes pour ajouter vos locataire dans NzoApp.",
                  ),
                  const SizedBox(height: defaultPadding),
                  TenantSignUpForm(formKey: _formKey),
                  const SizedBox(height: defaultPadding),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
