import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nzoapp/screens/auth/views/components/sign_up_form.dart';
import 'package:nzoapp/route/route_constants.dart';

import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Veuillez saisir vos données valides afin de créer un compte.",
                  ),
                  const SizedBox(height: defaultPadding),
                  SignUpForm(formKey: _formKey),
                  const SizedBox(height: defaultPadding),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       onChanged: (value) {},
                  //       value: false,
                  //     ),
                  //     Expanded(
                  //       child: Text.rich(
                  //         TextSpan(
                  //           text: "I agree with the",
                  //           children: [
                  //             TextSpan(
                  //               recognizer: TapGestureRecognizer()
                  //                 ..onTap = () {
                  //                   Navigator.pushNamed(
                  //                       context, termsOfServicesScreenRoute);
                  //                 },
                  //               text: " Terms of service ",
                  //               style: const TextStyle(
                  //                 color: primaryColor,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //             const TextSpan(
                  //               text: "& privacy policy.",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(height: defaultPadding * 2),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, entryPointScreenRoute);
                  //   },
                  //   child: const Text("Inscription"),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vous avez deja un compte?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, logInScreenRoute);
                        },
                        child: const Text("Se connecter"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
