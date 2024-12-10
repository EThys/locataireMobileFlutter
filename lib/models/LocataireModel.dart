// To parse this JSON data, do
//
//     final locataireModel = locataireModelFromJson(jsonString);

import 'dart:convert';

LocataireModel locataireModelFromJson(String str) => LocataireModel.fromJson(json.decode(str));

String locataireModelToJson(LocataireModel data) => json.encode(data.toJson());

class LocataireModel {
  String ? nom;
  String ? prenom;
  String ? tel;
  String ? role;
  String ? email;
  String ? password;
  String ? passwordConfirmation;

  LocataireModel({
     this.nom,
     this.prenom,
     this.tel,
     this.role,
     this.email,
     this.password,
     this.passwordConfirmation,
  });

  factory LocataireModel.fromJson(Map<String, dynamic> json) => LocataireModel(
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
