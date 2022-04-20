import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:maid/models/user.dart';
import 'package:maid/utils/app_url.dart';

class UserProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;
  bool? get userMaid => _user.maid;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  // void getUser(String name) async {
  //   var result;
  //   Response response = await post(
  //     Uri.parse(AppUrl.baseURL + AppUrl.getUser),
  //     body: json.encode({"name": name}),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //   final Map<String, dynamic> responseData = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     result = {
  //       'status': true,
  //       'message': responseData['message'],
  //     };
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': responseData['message'],
  //     };
  //   }
  //   notifyListeners();
  // }

  // Future<Map<String, dynamic>> setMaid(String id) async {
  //   var result;

  //   Response response = await post(
  //     Uri.parse(AppUrl.baseURL + AppUrl.maidSet),
  //     body: json.encode({"id": id}),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   final Map<String, dynamic> responseData = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     var userData = responseData['data'];

  //     _user.maid = true;
  //     notifyListeners();

  //     print('this is user  ${_user.maid}');
  //     result = {
  //       'status': true,
  //       'message': responseData['message'],
  //       'user': responseData['data']
  //     };
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': responseData['message'],
  //     };
  //   }

  //   return result;
  // }
}
