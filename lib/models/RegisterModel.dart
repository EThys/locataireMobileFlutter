// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String ? nom;
  String ? prenom;
  String ? tel;
  String ? role;
  String ? email;
  String ? password;
  String ? passwordConfirmation;

  RegisterModel({
    this.nom,
    this.prenom,
    this.tel,
    this.role,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    nom: json["nom"],
    prenom: json["prenom"],
    tel: json["tel"],
    role: json["role"],
    email: json["email"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "nom": nom,
    "prenom": prenom,
    "tel": tel,
    "role": role,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
