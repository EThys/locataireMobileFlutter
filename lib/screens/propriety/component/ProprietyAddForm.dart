import 'package:flutter/material.dart';
import 'package:nzoapp/controllers/LocataireCtrl.dart';
import 'package:nzoapp/controllers/ProprieteCtrl.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';
import '../../../../../utils/Routes.dart';

class ProprietyAddForm extends StatefulWidget {
  const ProprietyAddForm({super.key, required GlobalKey<FormState> formKey});

  @override
  State<ProprietyAddForm> createState() => _ProprietyAddFormState();
}

class _ProprietyAddFormState extends State<ProprietyAddForm> {
  Map<String, String> fieldErrors = {};
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

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
      "description": descriptionController.text,
      "adresse": adresseController.text
    };

    var ctrl = context.read<ProprieteCtrl>();
    print("Voici les donnees $userData");

    var res = await ctrl.createPropriete(userData);
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
                Text("Ajout propriety réussie !", style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        descriptionController.text="";
        adresseController.text="";
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
            controller: descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer une descrption';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Description",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.drive_file_rename_outline),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: adresseController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer votre adresse';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Adresse",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(Icons.drive_file_rename_outline),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Ajouter propriety"),
          ),
        ],
      ),
    );
  }
}