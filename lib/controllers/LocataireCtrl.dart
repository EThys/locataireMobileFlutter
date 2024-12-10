import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzoapp/models/LocataireModel.dart';
import 'package:nzoapp/models/RegisterModel.dart';
import 'package:nzoapp/utils/Endpoints.dart';
import '../utils/StockageKeys.dart';
import '../utils/requetes.dart';


class LocataireCtrl with ChangeNotifier {

  LocataireModel _locataire = LocataireModel();
  List<RegisterModel> Listregister = [];
  bool loading = false;
  GetStorage? stockage;

  LocataireCtrl({this.stockage});

  Future<HttpResponse> createLocataire(Map<String, dynamic> userData) async {
    try {
      final url = Endpoints.createLocataire;
      var _token=stockage?.read(StockageKeys.tokenKey);

      print("ESIMBIEEEEEE koooooooooooooo: ${_token}");
      print("urlllllllllll: $url");
      HttpResponse response = await postData(url, userData,token: _token);
      print("Matamaaaaaaaaaaaaaaaaaaaa ${response.data}");

      if (response.success) {
        print("Ajout locataire reussie: ${response.data}");
        notifyListeners();
      } else {
        print("Ajout locataire echec: ${response.errorMsg}");
      }

      return response;
    } catch (e) {
      print("Exception during registration: $e");
      return HttpResponse(
          success: false,
          errorMsg: "Une erreur est survenue lors de l'inscription",
          isException: true
      );
    }
  }


}
void main(){
  var ctrl=LocataireCtrl();
  ctrl.createLocataire({
    "nom":"usungu",
    "prenom":"glody",
    "tel":"0994435601",
    "email":"gloda@gmail.com",
    "password":"123456789",
    "password_confirmation":"123456789"
  });
}

