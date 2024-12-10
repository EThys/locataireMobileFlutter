import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nzoapp/screens/propriety/component/ProprietyAddForm.dart';
import '../../../constants.dart';

class ProprietyScreen extends StatefulWidget {
  const ProprietyScreen({super.key});

  @override
  State<ProprietyScreen> createState() => _ProprietyScreenState();
}

class _ProprietyScreenState extends State<ProprietyScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout propriete"),
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
                    "Veuillez remplir les informations suivantes pour ajouter une propriete dans NzoApp.",
                  ),
                  const SizedBox(height: defaultPadding),
                  ProprietyAddForm(formKey: _formKey),
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
