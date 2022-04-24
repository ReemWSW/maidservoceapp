import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:maid/models/order.dart';
import 'package:maid/utils/app_url.dart';

class OrderProvider with ChangeNotifier {
  Future<Map<String, dynamic>> order(
    String addressDetail,
    String addressTombon,
    String addressAmphure,
    String addressProvince,
    String detail,
    DateTime selectedDate,
    String category,
    String typeSelected,
  ) async {
    var result;

    final Map<String, dynamic> orderData = {
      "address": {
        "detail": addressDetail,
        "tombon": addressTombon,
        "amphure": addressAmphure,
        "province": addressProvince
      },
      "categoty": category,
      "type": typeSelected,
      "detail": detail,
      "datetime": selectedDate,
    };

    Response response = await post(
      Uri.parse(AppUrl.orderPost),
      body: json.encode(orderData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      Order authUser = Order.fromJson(userData);

      // UserPreferences().saveUser(authUser);
      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
    return result;
  }
}
