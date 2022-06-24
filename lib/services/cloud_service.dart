import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_2cs/config/api.dart';
import 'package:projet_2cs/models/missions.dart';
import 'package:projet_2cs/models/user.dart';

import 'localstorage.dart';

class Auth extends ChangeNotifier {
  bool? _isAuth;
  Transportateur? _transportateur;
  MissionsModel? _missions;
  String? _token;

  bool get isAuth {
    if (_isAuth != null && _isAuth == true && _token != null)
      return true;
    else
      return false;
  }

  String? get token => _token;

  Transportateur? get transportateur => _transportateur;

  MissionsModel? get missions => _missions;

  Future login(String? email, String? password) async {
    final url = apiUrl + "transportateurConnexion";
    final headers = {
      "Content-Type": "application/json",
    };
    final body = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        _isAuth = true;
        _token = data["acessToken"];
        _transportateur = Transportateur();
        _transportateur!.idTransportateur = data["idTransportateur"];
        await LocalStorage.saveUser(
            _token, data["idTransportateur"].toString(), data["acessToken"]);
        notifyListeners();
      } else {
        final data = jsonDecode(response.body);
        _transportateur = Transportateur();
        _transportateur = Transportateur.fromJson(data);

        throw Error();
      }
    } catch (e) {
      print("login error");
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final userData = await LocalStorage.getUser();
    if (userData == null) {
      _isAuth = false;
      _token = null;
      notifyListeners();

      return false;
    } else {
      _isAuth = true;
      _token = userData["token"];
      _transportateur = Transportateur();
      _transportateur!.idTransportateur = int.parse(userData["user_id"]!);

      notifyListeners();
      return true;
    }
  }

  Future getUserData() async {
    print("wow");

    String url =
        apiUrl + "transportateurs/${_transportateur!.idTransportateur}";

    try {
      print(_transportateur!.idTransportateur);
      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          //"Content-Type": "application/json",
          'Authorization': 'Bearer $_token',
        },
      );
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        print(userData);
        _transportateur = Transportateur.fromJson(userData);

        notifyListeners();
      } else {
        final userData = json.decode(response.body);
        print(userData);
        print('xxx');
        throw Error();
      }
    } catch (e) {
      throw e;
    }
  }

  Future getMissions() async {
    final userData = await LocalStorage.getUser();

    print(int.parse(userData!["user_id"]!));

    String url =
        apiUrl + "transportateurs/${int.parse(userData["user_id"]!)}/missions";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          //"Content-Type": "application/json",
          'Authorization': 'Bearer $_token',
        },
      );
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        print(userData);
        _missions = MissionsModel.fromJson(userData);

        notifyListeners();
      } else {
        final userData = json.decode(response.body);
        print(userData);
        throw Error();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> completeMission(String num_carte_id_patient,
      String temps_attente, XFile convention, XFile capture,String kilometrage) async {

    final url = apiUrl + "transportateur/missionComplete/${_missions?.missions![0].idmission}";
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $_token',
    };
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(url),
    );
    request.files.add(
      http.MultipartFile(
        'conv_lit',
        convention.readAsBytes().asStream(),
        await convention.length(),
        filename: convention.name,
        contentType: MediaType('image', convention.name.split(".")[1]),
      ),
    );
    request.files.add(
      http.MultipartFile(
        'conv_lit',
        capture.readAsBytes().asStream(),
        await capture.length(),
        filename: capture.name,
        contentType: MediaType('image', capture.name.split(".")[1]),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "num_carte_id_patient": num_carte_id_patient,
      "temps_attente": temps_attente,
      "kilometrage": kilometrage,
    });
    try {
      var response = await request.send();
      var data = await response.stream.bytesToString();
      print(data);
      if (response.statusCode == 200) print("Image saved");
      else print('error on updating mission'+response.statusCode.toString());

    } catch (e) {
      print('erroe');
      throw e;
    }
  }

  Future<bool> logOut() async {
    try {
      _isAuth = false;
      _token = null;
      _transportateur = null;
      await LocalStorage.clearLocalStorage();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
