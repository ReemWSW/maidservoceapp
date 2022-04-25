import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:maid/models/user.dart';
import 'package:maid/utils/app_url.dart';
import 'package:maid/utils/sharepreferences/auth.dart';

class UserProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;
  bool? get userMaid => _user.maid;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setPostMaid() {
    _user.maid = true;
    notifyListeners();
    UserPreferences().setMaid(true);
  }

  Future<Map<String, dynamic>> setMaid(String? id) async {
    final Map<String, dynamic> registrationData = {
      'id': id,
    };

    var result;

    Response response = await post(
      Uri.parse(AppUrl.setMaid),
      body: json.encode({"id": id}),
      headers: {'Content-Type': 'application/json'},
    );


    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      UserPreferences().setMaid(true);
      _user.maid = true;
      notifyListeners();

      result = {
        'status': true,
        'message': responseData['message'],
        'user': responseData['data']
      };
    } else {
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }

    return result;
  }
}
