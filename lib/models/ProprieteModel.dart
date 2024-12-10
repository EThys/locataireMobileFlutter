// To parse this JSON data, do
//
//     final proprieteModel = proprieteModelFromJson(jsonString);

import 'dart:convert';

ProprieteModel proprieteModelFromJson(String str) => ProprieteModel.fromJson(json.decode(str));

String proprieteModelToJson(ProprieteModel data) => json.encode(data.toJson());

class ProprieteModel {
  String ? description;
  String ? adresse;

  ProprieteModel({
    this.description,
    this.adresse,
  });

  factory ProprieteModel.fromJson(Map<String, dynamic> json) => ProprieteModel(
    description: json["description"],
    adresse: json["adresse"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "adresse": adresse,
  };
}
