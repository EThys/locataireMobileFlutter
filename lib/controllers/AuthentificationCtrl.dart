import 'package:flutter/material.dart';
import 'package:nzoapp/models/LoginModel.dart';
import 'package:nzoapp/models/RegisterModel.dart';
import 'package:nzoapp/utils/Endpoints.dart';
import '../utils/requetes.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/StockageKeys.dart';

class AuthentificationCtrl with ChangeNotifier {
  AuthentificationCtrl({this.stockage});

  String _token = "";

  String get token {
    var locale = stockage?.read<String>(StockageKeys.tokenKey);
    return locale ?? "";
  }

  set token(String value) {
    stockage?.write(StockageKeys.tokenKey, value);
    _token = value;
  }

  RegisterModel _user = RegisterModel();
  LoginModel _userAuth=LoginModel();
  GetStorage? stockage;

  List<RegisterModel> Listregister = [];
  List<LoginModel> Listlogin = [];
  bool loading = false;

  RegisterModel get user {
    var locale = stockage?.read(StockageKeys.userKey);
    _user = RegisterModel.fromJson(locale);
    return _user;
  }

  set user(RegisterModel value) {
    stockage?.write(StockageKeys.userKey, value.toJson());
    _user = value;
  }

  Future<HttpResponse> login(Map data) async {
    var url = "${Endpoints.loginEndpoint}";
    print("ethberg${url}");
    HttpResponse response = await postData(url, data);
    print("gggggggggggggggggggggg${response.data}");
    if (response.success) {
      var temp_user = response.data?["user"] ?? {};
      print("ELOOOOOOOOOUUUUUUUUU ${temp_user}");
      user = RegisterModel.fromJson(temp_user);
      stockage?.write(
          StockageKeys.tokenKey, response.data?['token'] ?? "");
      notifyListeners();

    }
    print(response.data);
    return response;
  }

  Future<HttpResponse> register(Map<String, dynamic> userData) async {
    try {
      final url = Endpoints.signUpEndpoint;
      print("urlllllllllll: $url");
      HttpResponse response = await postData(url, userData);

      if (response.success) {
        print("Inscription reussie: ${response.data}");
        notifyListeners();
      } else {
        print("Registration failed: ${response.errorMsg}");
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

  // Future<HttpResponse> logout(Map data) async {
  //   var url = "${Endpoints.logout}";
  //   var tkn = stockage?.read(StockageKeys.tokenKey);
  //   HttpResponse response = await postData(url, data, token: tkn);
  //   if (response.status) {
  //     notifyListeners();
  //   }
  //   print(response.data);
  //   /*
  //   NotificationController notificationController=NotificationController();
  //   notificationController.shutDown();*/
  //   return response;
  // }
  // Future<HttpResponse> changerPassword(Map data) async {
  //   var url = "${Endpoints.changerPassword}";
  //   HttpResponse response = await postData(url, data);
  //   print("hhhhhhhhhhhhhhhhhh$response");
  //   if (response.status) {
  //     var tkn = stockage?.read(StockageKeys.tokenKey);
  //     print("================== ${response.data}");
  //     print("mot de passe changer avec success");
  //   }
  //   print(response.data);
  //   return response;
  // }

// "identifiant": "jean.dupont@example.com",
// "password": "12345678"
}
void main(){
  var ctrl=AuthentificationCtrl();
  ctrl.login({
    "identifiant": "ethbergmuzoladdd@gmail.com",
    "password": "12345678"
  });
}

