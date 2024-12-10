import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzoapp/models/LocataireModel.dart';
import 'package:nzoapp/models/RegisterModel.dart';
import 'package:nzoapp/utils/Endpoints.dart';
import '../utils/StockageKeys.dart';
import '../utils/requetes.dart';


class ProprieteCtrl with ChangeNotifier {

  bool loading = false;
  GetStorage? stockage;

  ProprieteCtrl({this.stockage});

  Future<HttpResponse> createPropriete(Map<String, dynamic> data) async {
    try {
      final url = Endpoints.createPropriete;
      var _token=stockage?.read(StockageKeys.tokenKey);

      print("ESIMBIEEEEEE koooooooooooooo: ${_token}");
      print("urlllllllllll: $url");
      HttpResponse response = await postData(url, data,token: _token);

      if (response.success) {
        print("Ajout propriete reussie: ${response.data}");
        notifyListeners();
      } else {
        print("Ajout propriete echec: ${response.errorMsg}");
      }

      return response;
    } catch (e) {
      print("Exception during add: $e");
      return HttpResponse(
          success: false,
          errorMsg: "Une erreur est survenue lors de l'ajout",
          isException: true
      );
    }
  }


}
void main(){
  var ctrl=ProprieteCtrl();
  ctrl.createPropriete({
    "description":"usungu",
    "adresse":"glody"
  });
}

