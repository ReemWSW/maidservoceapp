// ignore_for_file: constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:maid/models/user.dart';
import 'package:maid/utils/app_url.dart';
import 'package:maid/utils/sharepreferences/auth.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  final Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.baseURL + AppUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
    return result;
  }

  void logout() async {
    _loggedInStatus = Status.LoggedOut;
    notifyListeners();

    UserPreferences().removeUser();
  }

  Future<Map<String, dynamic>> register(
    String image,
    String name,
    String email,
    String password,
    String phone,
  ) async {
    final Map<String, dynamic> registrationData = {
      'image': image,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'maid': false,
    };
    // print(registrationData);
    var res;
    Uri uri = Uri.parse(AppUrl.baseURL + AppUrl.register);
    print(uri);
    res = await post(uri,
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
    return res;
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    // print(response.statusCode);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'ลงทะเบียนเสร็จสิ้น',
        'data': authUser
      };
    } else if (response.statusCode == 300) {
      result = {
        'status': false,
        'message': 'อีเมลล์ถูกลงทะเบียนแล้ว',
        'data': responseData['message']
      };
    } else {
      result = {
        'status': false,
        'message': 'ไม่สามารถลงทะเบียนได้',
        'data': responseData['message']
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
