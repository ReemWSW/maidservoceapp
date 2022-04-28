import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:maid/models/user.dart';
import 'package:maid/utils/app_url.dart';
import 'package:maid/utils/enum.dart';
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

  Future<Map<String, dynamic>> setMaid(String? id, bool? maid, String province,
      String amphure, String tombon, String category, DateTime datetime) async {
    var categoryPost;
    switch (category) {
      case 'ซักผ้า':
        categoryPost = "${Categories.wash}";
        break;
      case 'ทำความสะอาดบ้าน':
        categoryPost = "${Categories.clean}";
        break;
      case 'ทำความสะอาดเฟอร์นิเจอร์':
        categoryPost = "${Categories.furniture}";
        break;
      case 'ทำความสะอาดทั้งหมด':
        categoryPost = "${Categories.all}";
        break;
      default:
    }
    var result;

    Response response = await post(
      Uri.parse(AppUrl.setMaid),
      body: json.encode({
        'id': id,
        'maid': maid,
        'province': province,
        'amphure': amphure,
        'tombon': tombon,
        'category': categoryPost,
        'datetime': datetime.toString()
      }),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      UserPreferences()
          .setMaid(maid!, province, amphure, tombon, category, datetime);
      _user.maid = maid;
      _user.category = category;

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
