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
  String? get provinceMaid => _user.address!.province;
  String? get amphureMaid => _user.address!.amphure;
  String? get tombonMaid => _user.address!.tombon;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future setPostMaid(
      bool maid, String province, String amphure, String tombon) async {
    _user.maid = maid;
    _user.address!.province = province;
    _user.address!.amphure = amphure;
    _user.address!.tombon = tombon;

    notifyListeners();
    UserPreferences().setMaid(
      maid,
      province,
      amphure,
      tombon,
    );
  }

  Future<Map<String, dynamic>> setMaid(
    String? id,
    bool? maid,
    String province,
    String amphure,
    String tombon,
  ) async {
    final Map<String, dynamic> registrationData = {
      'id': id,
      'maid': maid,
      'province': province,
      'amphure': amphure,
      'tombon': tombon,
    };
    var result;

    Response response = await post(
      Uri.parse(AppUrl.setMaid),
      body: json.encode({
        'id': id,
        'maid': maid,
        'province': province,
        'amphure': amphure,
        'tombon': tombon,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      UserPreferences().setMaid(
        maid!,
        province,
        amphure,
        tombon,
      );
      _user.maid = maid;

      var address = _user.address;
      if (address != null) {
        address.province = province;
        address.amphure = amphure;
        address.tombon = tombon;
      }
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
